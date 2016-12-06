From: zajec5@gmail.com (=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?=)
Date: Tue,  6 Dec 2016 18:17:14 +0100
Subject: [PATCH 5/5] ARM: BCM53573: Specify USB ports of on-SoC controllers
In-Reply-To: <20161206171714.22738-1-zajec5@gmail.com>
References: <20161206171714.22738-1-zajec5@gmail.com>
Message-ID: <20161206171714.22738-5-zajec5@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rafa? Mi?ecki <rafal@milecki.pl>

Broadcom OHCI and EHCI controllers always have 2 ports each on the root
hub. Describe them in DT to allow specifying extra info or referencing
port nodes.

Signed-off-by: Rafa? Mi?ecki <rafal@milecki.pl>
---
 arch/arm/boot/dts/bcm53573.dtsi | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/arm/boot/dts/bcm53573.dtsi b/arch/arm/boot/dts/bcm53573.dtsi
index e2c496a..2da04d0 100644
--- a/arch/arm/boot/dts/bcm53573.dtsi
+++ b/arch/arm/boot/dts/bcm53573.dtsi
@@ -124,6 +124,17 @@
 				reg = <0x4000 0x1000>;
 				interrupt-parent = <&gic>;
 				interrupts = <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>;
+
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				ehci_port1: port at 1 {
+					reg = <1>;
+				};
+
+				ehci_port2: port at 2 {
+					reg = <2>;
+				};
 			};
 
 			ohci: ohci at d000 {
@@ -133,6 +144,17 @@
 				reg = <0xd000 0x1000>;
 				interrupt-parent = <&gic>;
 				interrupts = <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>;
+
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				ohci_port1: port at 1 {
+					reg = <1>;
+				};
+
+				ohci_port2: port at 2 {
+					reg = <2>;
+				};
 			};
 		};
 
-- 
2.10.1
