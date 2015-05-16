From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Sat, 16 May 2015 02:23:41 +0200
Subject: [PATCH 12/14] ARM: berlin: move BG2Q clock node
In-Reply-To: <1431735823-28006-1-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1431735823-28006-1-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <1431735823-28006-13-git-send-email-sebastian.hesselbarth@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Antoine Tenart <antoine.tenart@free-electrons.com>

With the introduction of the Berlin simple-mfd controller driver, all
drivers previously sharing the chip and system controller nodes now
have their own sub-node.

Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>
Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
---
Cc: Stephen Boyd <sboyd@codeaurora.org>
---
 arch/arm/boot/dts/berlin2q.dtsi | 50 ++++++++++++++++++++++-------------------
 1 file changed, 27 insertions(+), 23 deletions(-)

diff --git a/arch/arm/boot/dts/berlin2q.dtsi b/arch/arm/boot/dts/berlin2q.dtsi
index 8715d11c8f76..4a21ba386230 100644
--- a/arch/arm/boot/dts/berlin2q.dtsi
+++ b/arch/arm/boot/dts/berlin2q.dtsi
@@ -74,7 +74,7 @@
 		sdhci0: sdhci at ab0000 {
 			compatible = "mrvl,pxav3-mmc";
 			reg = <0xab0000 0x200>;
-			clocks = <&chip CLKID_SDIO1XIN>;
+			clocks = <&chip_clk CLKID_SDIO1XIN>;
 			interrupts = <GIC_SPI 17 IRQ_TYPE_LEVEL_HIGH>;
 			status = "disabled";
 		};
@@ -82,7 +82,7 @@
 		sdhci1: sdhci at ab0800 {
 			compatible = "mrvl,pxav3-mmc";
 			reg = <0xab0800 0x200>;
-			clocks = <&chip CLKID_SDIO1XIN>;
+			clocks = <&chip_clk CLKID_SDIO1XIN>;
 			interrupts = <GIC_SPI 20 IRQ_TYPE_LEVEL_HIGH>;
 			status = "disabled";
 		};
@@ -91,7 +91,7 @@
 			compatible = "mrvl,pxav3-mmc";
 			reg = <0xab1000 0x200>;
 			interrupts = <GIC_SPI 28 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&chip CLKID_NFC_ECC>, <&chip CLKID_NFC>;
+			clocks = <&chip_clk CLKID_NFC_ECC>, <&chip_clk CLKID_NFC>;
 			clock-names = "io", "core";
 			status = "disabled";
 		};
@@ -112,7 +112,7 @@
 		local-timer at ad0600 {
 			compatible = "arm,cortex-a9-twd-timer";
 			reg = <0xad0600 0x20>;
-			clocks = <&chip CLKID_TWD>;
+			clocks = <&chip_clk CLKID_TWD>;
 			interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
 		};
 
@@ -135,7 +135,7 @@
 			compatible = "chipidea,usb2";
 			reg = <0xa30000 0x10000>;
 			interrupts = <GIC_SPI 52 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&chip CLKID_USB2>;
+			clocks = <&chip_clk CLKID_USB2>;
 			phys = <&usb_phy2>;
 			phy-names = "usb-phy";
 			status = "disabled";
@@ -160,7 +160,7 @@
 		eth0: ethernet at b90000 {
 			compatible = "marvell,pxa168-eth";
 			reg = <0xb90000 0x10000>;
-			clocks = <&chip CLKID_GETH0>;
+			clocks = <&chip_clk CLKID_GETH0>;
 			interrupts = <GIC_SPI 24 IRQ_TYPE_LEVEL_HIGH>;
 			/* set by bootloader */
 			local-mac-address = [00 00 00 00 00 00];
@@ -267,7 +267,7 @@
 				reg = <0x1400 0x100>;
 				interrupt-parent = <&aic>;
 				interrupts = <4>;
-				clocks = <&chip CLKID_CFG>;
+				clocks = <&chip_clk CLKID_CFG>;
 				pinctrl-0 = <&twsi0_pmux>;
 				pinctrl-names = "default";
 				status = "disabled";
@@ -280,7 +280,7 @@
 				reg = <0x1800 0x100>;
 				interrupt-parent = <&aic>;
 				interrupts = <5>;
-				clocks = <&chip CLKID_CFG>;
+				clocks = <&chip_clk CLKID_CFG>;
 				pinctrl-0 = <&twsi1_pmux>;
 				pinctrl-names = "default";
 				status = "disabled";
@@ -289,7 +289,7 @@
 			timer0: timer at 2c00 {
 				compatible = "snps,dw-apb-timer";
 				reg = <0x2c00 0x14>;
-				clocks = <&chip CLKID_CFG>;
+				clocks = <&chip_clk CLKID_CFG>;
 				clock-names = "timer";
 				interrupts = <8>;
 			};
@@ -297,14 +297,14 @@
 			timer1: timer at 2c14 {
 				compatible = "snps,dw-apb-timer";
 				reg = <0x2c14 0x14>;
-				clocks = <&chip CLKID_CFG>;
+				clocks = <&chip_clk CLKID_CFG>;
 				clock-names = "timer";
 			};
 
 			timer2: timer at 2c28 {
 				compatible = "snps,dw-apb-timer";
 				reg = <0x2c28 0x14>;
-				clocks = <&chip CLKID_CFG>;
+				clocks = <&chip_clk CLKID_CFG>;
 				clock-names = "timer";
 				status = "disabled";
 			};
@@ -312,7 +312,7 @@
 			timer3: timer at 2c3c {
 				compatible = "snps,dw-apb-timer";
 				reg = <0x2c3c 0x14>;
-				clocks = <&chip CLKID_CFG>;
+				clocks = <&chip_clk CLKID_CFG>;
 				clock-names = "timer";
 				status = "disabled";
 			};
@@ -320,7 +320,7 @@
 			timer4: timer at 2c50 {
 				compatible = "snps,dw-apb-timer";
 				reg = <0x2c50 0x14>;
-				clocks = <&chip CLKID_CFG>;
+				clocks = <&chip_clk CLKID_CFG>;
 				clock-names = "timer";
 				status = "disabled";
 			};
@@ -328,7 +328,7 @@
 			timer5: timer at 2c64 {
 				compatible = "snps,dw-apb-timer";
 				reg = <0x2c64 0x14>;
-				clocks = <&chip CLKID_CFG>;
+				clocks = <&chip_clk CLKID_CFG>;
 				clock-names = "timer";
 				status = "disabled";
 			};
@@ -336,7 +336,7 @@
 			timer6: timer at 2c78 {
 				compatible = "snps,dw-apb-timer";
 				reg = <0x2c78 0x14>;
-				clocks = <&chip CLKID_CFG>;
+				clocks = <&chip_clk CLKID_CFG>;
 				clock-names = "timer";
 				status = "disabled";
 			};
@@ -344,7 +344,7 @@
 			timer7: timer at 2c8c {
 				compatible = "snps,dw-apb-timer";
 				reg = <0x2c8c 0x14>;
-				clocks = <&chip CLKID_CFG>;
+				clocks = <&chip_clk CLKID_CFG>;
 				clock-names = "timer";
 				status = "disabled";
 			};
@@ -361,10 +361,14 @@
 
 		chip: chip-control at ea0000 {
 			compatible = "marvell,berlin2q-chip-ctrl", "simple-mfd", "syscon";
-			#clock-cells = <1>;
 			reg = <0xea0000 0x400>, <0xdd0170 0x10>;
-			clocks = <&refclk>;
-			clock-names = "refclk";
+
+			chip_clk: clock {
+				compatible = "marvell,berlin2q-clk";
+				#clock-cells = <1>;
+				clocks = <&refclk>;
+				clock-names = "refclk";
+			};
 
 			soc_pinctrl: pin-controller {
 				compatible = "marvell,berlin2q-soc-pinctrl";
@@ -389,7 +393,7 @@
 			compatible = "marvell,berlin2q-ahci", "generic-ahci";
 			reg = <0xe90000 0x1000>;
 			interrupts = <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&chip CLKID_SATA>;
+			clocks = <&chip_clk CLKID_SATA>;
 			#address-cells = <1>;
 			#size-cells = <0>;
 
@@ -409,7 +413,7 @@
 		sata_phy: phy at e900a0 {
 			compatible = "marvell,berlin2q-sata-phy";
 			reg = <0xe900a0 0x200>;
-			clocks = <&chip CLKID_SATA>;
+			clocks = <&chip_clk CLKID_SATA>;
 			#address-cells = <1>;
 			#size-cells = <0>;
 			#phy-cells = <1>;
@@ -428,7 +432,7 @@
 			compatible = "chipidea,usb2";
 			reg = <0xed0000 0x10000>;
 			interrupts = <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&chip CLKID_USB0>;
+			clocks = <&chip_clk CLKID_USB0>;
 			phys = <&usb_phy0>;
 			phy-names = "usb-phy";
 			status = "disabled";
@@ -438,7 +442,7 @@
 			compatible = "chipidea,usb2";
 			reg = <0xee0000 0x10000>;
 			interrupts = <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&chip CLKID_USB1>;
+			clocks = <&chip_clk CLKID_USB1>;
 			phys = <&usb_phy1>;
 			phy-names = "usb-phy";
 			status = "disabled";
-- 
2.1.0
