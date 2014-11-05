From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Wed,  5 Nov 2014 17:01:27 +0100
Subject: [PATCH v2 11/11] ARM: at91/dt: add NOR definition in sama5d3xcm dtsi
In-Reply-To: <1415203287-21517-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1415203287-21517-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1415203287-21517-12-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 arch/arm/boot/dts/sama5d3xcm.dtsi | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/arch/arm/boot/dts/sama5d3xcm.dtsi b/arch/arm/boot/dts/sama5d3xcm.dtsi
index 962dc28..857ef05 100644
--- a/arch/arm/boot/dts/sama5d3xcm.dtsi
+++ b/arch/arm/boot/dts/sama5d3xcm.dtsi
@@ -75,6 +75,40 @@
 			};
 		};
 
+		ebi at 10000000 {
+			pinctrl-0 = <&pinctrl_ebi_addr &pinctrl_ebi_cs0>;
+
+			cs at 0 {
+				#address-cells = <2>;
+				#size-cells = <1>;
+				ranges;
+				atmel,generic-dev;
+				atmel,read-mode = "nrd";
+				atmel,write-mode = "nwe";
+				atmel,bus-width = <16>;
+				atmel,ncs-rd-setup-ns = <0>;
+				atmel,ncs-wr-setup-ns = <0>;
+				atmel,nwe-setup-ns = <8>;
+				atmel,nrd-setup-ns = <16>;
+				atmel,ncs-rd-pulse-ns = <84>;
+				atmel,ncs-wr-pulse-ns = <84>;
+				atmel,nrd-pulse-ns = <76>;
+				atmel,nwe-pulse-ns = <76>;
+				atmel,nrd-cycle-ns = <107>;
+				atmel,nwe-cycle-ns = <84>;
+				atmel,tdf-ns = <16>;
+
+				nor: flash at 0,0 {
+					compatible = "cfi-flash";
+					linux,mtd-name = "physmap-flash.0";
+					#address-cells = <1>;
+					#size-cells = <1>;
+					reg = <0x0 0x0 0x1000000>;
+					bank-width = <2>;
+				};
+			};
+		};
+
 		nand0: nand at 60000000 {
 			nand-bus-width = <8>;
 			nand-ecc-mode = "hw";
-- 
1.9.1
