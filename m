From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Tue, 30 May 2017 10:32:50 +0200
Subject: [PATCH 5/5] ARM: dts: at91: Add the NOR flash available on sama5d3
 dev kits
In-Reply-To: <1496133171-4787-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1496133171-4787-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1496133171-4787-6-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

sama5d3 CPU modules embed a parallel NOR flash connected to the EBI bus.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 arch/arm/boot/dts/sama5d3xcm.dtsi | 27 +++++++++++++++++++++++++--
 1 file changed, 25 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/sama5d3xcm.dtsi b/arch/arm/boot/dts/sama5d3xcm.dtsi
index 4606e1d7e6f2..9506daf5efb6 100644
--- a/arch/arm/boot/dts/sama5d3xcm.dtsi
+++ b/arch/arm/boot/dts/sama5d3xcm.dtsi
@@ -37,10 +37,33 @@
 		};
 
 		ebi at 10000000 {
-			pinctrl-0 = <&pinctrl_ebi_nand_addr>;
-			pinctrl-names = "default";
+			pinctrl-0 = <&pinctrl_ebi_addr &pinctrl_ebi_cs0>;
+			pinctr-name = "default";
 			status = "okay";
 
+			nor: flash at 0,0 {
+				compatible = "cfi-flash";
+				linux,mtd-name = "physmap-flash.0";
+				#address-cells = <1>;
+				#size-cells = <1>;
+				reg = <0x0 0x0 0x1000000>;
+				bank-width = <2>;
+				atmel,smc-read-mode = "nrd";
+				atmel,smc-write-mode = "nwe";
+				atmel,smc-bus-width = <16>;
+				atmel,smc-ncs-rd-setup-ns = <0>;
+				atmel,smc-ncs-wr-setup-ns = <0>;
+				atmel,smc-nwe-setup-ns = <8>;
+				atmel,smc-nrd-setup-ns = <16>;
+				atmel,smc-ncs-rd-pulse-ns = <84>;
+				atmel,smc-ncs-wr-pulse-ns = <84>;
+				atmel,smc-nrd-pulse-ns = <76>;
+				atmel,smc-nwe-pulse-ns = <76>;
+				atmel,smc-nrd-cycle-ns = <107>;
+				atmel,smc-nwe-cycle-ns = <84>;
+				atmel,smc-tdf-ns = <16>;
+			};
+
 			nand_controller: nand-controller {
 				status = "okay";
 
-- 
2.7.4
