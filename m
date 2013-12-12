From: jason@lakedaemon.net (Jason Cooper)
Date: Thu, 12 Dec 2013 15:25:16 +0000
Subject: [PATCH 1/4] ARM: kirkwood: sort dt nodes by address
In-Reply-To: <cover.1386861599.git.jason@lakedaemon.net>
References: <cover.1386861599.git.jason@lakedaemon.net>
Message-ID: <20bba5883acf79460dff047cf45b6fb8089168b2.1386861599.git.jason@lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This has caused merge conflicts in the past.

Signed-off-by: Jason Cooper <jason@lakedaemon.net>
---
 arch/arm/boot/dts/kirkwood.dtsi | 140 ++++++++++++++++++++--------------------
 1 file changed, 70 insertions(+), 70 deletions(-)

diff --git a/arch/arm/boot/dts/kirkwood.dtsi b/arch/arm/boot/dts/kirkwood.dtsi
index dd58a25a4166..1da94c187085 100644
--- a/arch/arm/boot/dts/kirkwood.dtsi
+++ b/arch/arm/boot/dts/kirkwood.dtsi
@@ -70,39 +70,21 @@
 		#address-cells = <1>;
 		#size-cells = <1>;
 
-		mbusc: mbus-controller at 20000 {
-			compatible = "marvell,mbus-controller";
-			reg = <0x20000 0x80>, <0x1500 0x20>;
-		};
-
-		timer: timer at 20300 {
-			compatible = "marvell,orion-timer";
-			reg = <0x20300 0x20>;
-			interrupt-parent = <&bridge_intc>;
-			interrupts = <1>, <2>;
-			clocks = <&core_clk 0>;
-		};
-
-		intc: main-interrupt-ctrl at 20200 {
-			compatible = "marvell,orion-intc";
-			interrupt-controller;
-			#interrupt-cells = <1>;
-			reg = <0x20200 0x10>, <0x20210 0x10>;
-		};
-
-		bridge_intc: bridge-interrupt-ctrl at 20110 {
-			compatible = "marvell,orion-bridge-intc";
-			interrupt-controller;
-			#interrupt-cells = <1>;
-			reg = <0x20110 0x8>;
-			interrupts = <1>;
-			marvell,#interrupts = <6>;
-		};
-
 		core_clk: core-clocks at 10030 {
 			compatible = "marvell,kirkwood-core-clock";
 			reg = <0x10030 0x4>;
-	        	#clock-cells = <1>;
+			#clock-cells = <1>;
+		};
+
+		spi at 10600 {
+			compatible = "marvell,orion-spi";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			cell-index = <0>;
+			interrupts = <23>;
+			reg = <0x10600 0x28>;
+			clocks = <&gate_clk 7>;
+			status = "disabled";
 		};
 
 		gpio0: gpio at 10100 {
@@ -129,6 +111,17 @@
 			clocks = <&gate_clk 7>;
 		};
 
+		i2c at 11000 {
+			compatible = "marvell,mv64xxx-i2c";
+			reg = <0x11000 0x20>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			interrupts = <29>;
+			clock-frequency = <100000>;
+			clocks = <&gate_clk 7>;
+			status = "disabled";
+		};
+
 		serial at 12000 {
 			compatible = "ns16550a";
 			reg = <0x12000 0x100>;
@@ -147,15 +140,18 @@
 			status = "disabled";
 		};
 
-		spi at 10600 {
-			compatible = "marvell,orion-spi";
-			#address-cells = <1>;
-			#size-cells = <0>;
-			cell-index = <0>;
-			interrupts = <23>;
-			reg = <0x10600 0x28>;
-			clocks = <&gate_clk 7>;
-			status = "disabled";
+		mbusc: mbus-controller at 20000 {
+			compatible = "marvell,mbus-controller";
+			reg = <0x20000 0x80>, <0x1500 0x20>;
+		};
+
+		bridge_intc: bridge-interrupt-ctrl at 20110 {
+			compatible = "marvell,orion-bridge-intc";
+			interrupt-controller;
+			#interrupt-cells = <1>;
+			reg = <0x20110 0x8>;
+			interrupts = <1>;
+			marvell,#interrupts = <6>;
 		};
 
 		gate_clk: clock-gating-control at 2011c {
@@ -165,6 +161,21 @@
 			#clock-cells = <1>;
 		};
 
+		intc: main-interrupt-ctrl at 20200 {
+			compatible = "marvell,orion-intc";
+			interrupt-controller;
+			#interrupt-cells = <1>;
+			reg = <0x20200 0x10>, <0x20210 0x10>;
+		};
+
+		timer: timer at 20300 {
+			compatible = "marvell,orion-timer";
+			reg = <0x20300 0x20>;
+			interrupt-parent = <&bridge_intc>;
+			interrupts = <1>, <2>;
+			clocks = <&core_clk 0>;
+		};
+
 		wdt: watchdog-timer at 20300 {
 			compatible = "marvell,orion-wdt";
 			reg = <0x20300 0x28>;
@@ -174,6 +185,14 @@
 			status = "okay";
 		};
 
+		ehci at 50000 {
+			compatible = "marvell,orion-ehci";
+			reg = <0x50000 0x1000>;
+			interrupts = <19>;
+			clocks = <&gate_clk 3>;
+			status = "okay";
+		};
+
 		xor at 60800 {
 			compatible = "marvell,orion-xor";
 			reg = <0x60800 0x100
@@ -214,37 +233,6 @@
 			};
 		};
 
-		ehci@50000 {
-			compatible = "marvell,orion-ehci";
-			reg = <0x50000 0x1000>;
-			interrupts = <19>;
-			clocks = <&gate_clk 3>;
-			status = "okay";
-		};
-
-		i2c at 11000 {
-			compatible = "marvell,mv64xxx-i2c";
-			reg = <0x11000 0x20>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-			interrupts = <29>;
-			clock-frequency = <100000>;
-			clocks = <&gate_clk 7>;
-			status = "disabled";
-		};
-
-		mdio: mdio-bus at 72004 {
-			compatible = "marvell,orion-mdio";
-			#address-cells = <1>;
-			#size-cells = <0>;
-			reg = <0x72004 0x84>;
-			interrupts = <46>;
-			clocks = <&gate_clk 0>;
-			status = "disabled";
-
-			/* add phy nodes in board file */
-		};
-
 		eth0: ethernet-controller at 72000 {
 			compatible = "marvell,kirkwood-eth";
 			#address-cells = <1>;
@@ -265,6 +253,18 @@
 			};
 		};
 
+		mdio: mdio-bus at 72004 {
+			compatible = "marvell,orion-mdio";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0x72004 0x84>;
+			interrupts = <46>;
+			clocks = <&gate_clk 0>;
+			status = "disabled";
+
+			/* add phy nodes in board file */
+		};
+
 		eth1: ethernet-controller at 76000 {
 			compatible = "marvell,kirkwood-eth";
 			#address-cells = <1>;
-- 
1.8.5.1
