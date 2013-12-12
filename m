From: jason@lakedaemon.net (Jason Cooper)
Date: Thu, 12 Dec 2013 15:25:18 +0000
Subject: [PATCH 3/4] ARM: orion5x: sort DT nodes by address
In-Reply-To: <cover.1386861599.git.jason@lakedaemon.net>
References: <cover.1386861599.git.jason@lakedaemon.net>
Message-ID: <6226cf186cd1d8dfd3495d9084b7ca543bb2ea1a.1386861599.git.jason@lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Prevent future unnecessary merge conflicts

Signed-off-by: Jason Cooper <jason@lakedaemon.net>
---
 arch/arm/boot/dts/orion5x.dtsi | 106 ++++++++++++++++++++---------------------
 1 file changed, 53 insertions(+), 53 deletions(-)

diff --git a/arch/arm/boot/dts/orion5x.dtsi b/arch/arm/boot/dts/orion5x.dtsi
index e06c37e91ac6..9f51538cd9ef 100644
--- a/arch/arm/boot/dts/orion5x.dtsi
+++ b/arch/arm/boot/dts/orion5x.dtsi
@@ -42,6 +42,25 @@
 			interrupts = <6>, <7>, <8>, <9>;
 		};
 
+		spi at 10600 {
+			compatible = "marvell,orion-spi";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			cell-index = <0>;
+			reg = <0x10600 0x28>;
+			status = "disabled";
+		};
+
+		i2c at 11000 {
+			compatible = "marvell,mv64xxx-i2c";
+			reg = <0x11000 0x20>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			interrupts = <5>;
+			clock-frequency = <100000>;
+			status = "disabled";
+		};
+
 		serial at 12000 {
 			compatible = "ns16550a";
 			reg = <0x12000 0x100>;
@@ -60,15 +79,6 @@
 			status = "disabled";
 		};
 
-		spi at 10600 {
-			compatible = "marvell,orion-spi";
-			#address-cells = <1>;
-			#size-cells = <0>;
-			cell-index = <0>;
-			reg = <0x10600 0x28>;
-			status = "disabled";
-		};
-
 		wdt at 20300 {
 			compatible = "marvell,orion-wdt";
 			reg = <0x20300 0x28>;
@@ -82,30 +92,6 @@
 			status = "disabled";
 		};
 
-		ehci at a0000 {
-			compatible = "marvell,orion-ehci";
-			reg = <0xa0000 0x1000>;
-			interrupts = <12>;
-			status = "disabled";
-		};
-
-		sata at 80000 {
-			compatible = "marvell,orion-sata";
-			reg = <0x80000 0x5000>;
-			interrupts = <29>;
-			status = "disabled";
-		};
-
-		i2c at 11000 {
-			compatible = "marvell,mv64xxx-i2c";
-			reg = <0x11000 0x20>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-			interrupts = <5>;
-			clock-frequency = <100000>;
-			status = "disabled";
-		};
-
 		xor at 60900 {
 			compatible = "marvell,orion-xor";
 			reg = <0x60900 0x100
@@ -125,26 +111,6 @@
 			};
 		};
 
-		crypto@90000 {
-			compatible = "marvell,orion-crypto";
-			reg = <0x90000 0x10000>,
-			      <0xf2200000 0x800>;
-			reg-names = "regs", "sram";
-			interrupts = <28>;
-			status = "okay";
-		};
-
-		mdio: mdio-bus at 72004 {
-			compatible = "marvell,orion-mdio";
-			#address-cells = <1>;
-			#size-cells = <0>;
-			reg = <0x72004 0x84>;
-			interrupts = <22>;
-			status = "disabled";
-
-			/* add phy nodes in board file */
-		};
-
 		eth: ethernet-controller at 72000 {
 			compatible = "marvell,orion-eth";
 			#address-cells = <1>;
@@ -162,5 +128,39 @@
 				/* set phy-handle property in board file */
 			};
 		};
+
+		mdio: mdio-bus at 72004 {
+			compatible = "marvell,orion-mdio";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0x72004 0x84>;
+			interrupts = <22>;
+			status = "disabled";
+
+			/* add phy nodes in board file */
+		};
+
+		sata at 80000 {
+			compatible = "marvell,orion-sata";
+			reg = <0x80000 0x5000>;
+			interrupts = <29>;
+			status = "disabled";
+		};
+
+		crypto at 90000 {
+			compatible = "marvell,orion-crypto";
+			reg = <0x90000 0x10000>,
+			      <0xf2200000 0x800>;
+			reg-names = "regs", "sram";
+			interrupts = <28>;
+			status = "okay";
+		};
+
+		ehci at a0000 {
+			compatible = "marvell,orion-ehci";
+			reg = <0xa0000 0x1000>;
+			interrupts = <12>;
+			status = "disabled";
+		};
 	};
 };
-- 
1.8.5.1
