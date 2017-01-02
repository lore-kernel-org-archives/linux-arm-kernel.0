From: andre.przywara@arm.com (Andre Przywara)
Date: Mon,  2 Jan 2017 23:03:44 +0000
Subject: [PATCH 3/5] arm64: dts: sun50i: add MMC nodes
In-Reply-To: <1483398226-29321-1-git-send-email-andre.przywara@arm.com>
References: <1483398226-29321-1-git-send-email-andre.przywara@arm.com>
Message-ID: <1483398226-29321-4-git-send-email-andre.przywara@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 67 +++++++++++++++++++++++++++
 1 file changed, 67 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
index e0dcab8..c680566 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
@@ -150,6 +150,32 @@
 				pins = "PB8", "PB9";
 				function = "uart0";
 			};
+
+			mmc0_pins: mmc0 at 0 {
+				pins = "PF0", "PF1", "PF2", "PF3", "PF4", "PF5";
+				function = "mmc0";
+				drive-strength = <30>;
+			};
+
+			mmc0_default_cd_pin: mmc0_cd_pin at 0 {
+				pins = "PF6";
+				function = "gpio_in";
+				bias-pull-up;
+			};
+
+			mmc1_pins: mmc1 at 0 {
+				pins = "PG0", "PG1", "PG2", "PG3", "PG4", "PG5";
+				function = "mmc1";
+				drive-strength = <30>;
+			};
+
+			mmc2_pins: mmc2 at 0 {
+				pins = "PC1", "PC5", "PC6", "PC8", "PC9",
+				       "PC10", "PC11", "PC12", "PC13", "PC14",
+				       "PC15", "PC16";
+				function = "mmc2";
+				drive-strength = <30>;
+			};
 		};
 
 		uart0: serial at 1c28000 {
@@ -240,6 +266,47 @@
 			#size-cells = <0>;
 		};
 
+		mmc0: mmc at 1c0f000 {
+			compatible = "allwinner,sun50i-a64-mmc",
+				     "allwinner,sun5i-a13-mmc";
+			reg = <0x01c0f000 0x1000>;
+			clocks = <&ccu 31>, <&ccu 75>;
+			clock-names = "ahb", "mmc";
+			resets = <&ccu 8>;
+			reset-names = "ahb";
+			interrupts = <GIC_SPI 60 IRQ_TYPE_LEVEL_HIGH>;
+			status = "disabled";
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		mmc1: mmc at 1c10000 {
+			compatible = "allwinner,sun50i-a64-mmc",
+				     "allwinner,sun5i-a13-mmc";
+			reg = <0x01c10000 0x1000>;
+			clocks = <&ccu 32>, <&ccu 76>;
+			clock-names = "ahb", "mmc";
+			resets = <&ccu 9>;
+			reset-names = "ahb";
+			interrupts = <GIC_SPI 61 IRQ_TYPE_LEVEL_HIGH>;
+			status = "disabled";
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		mmc2: mmc at 1c11000 {
+			compatible = "allwinner,sun50i-a64-emmc";
+			reg = <0x01c11000 0x1000>;
+			clocks = <&ccu 33>, <&ccu 77>;
+			clock-names = "ahb", "mmc";
+			resets = <&ccu 10>;
+			reset-names = "ahb";
+			interrupts = <GIC_SPI 62 IRQ_TYPE_LEVEL_HIGH>;
+			status = "disabled";
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
 		gic: interrupt-controller at 1c81000 {
 			compatible = "arm,gic-400";
 			reg = <0x01c81000 0x1000>,
-- 
2.8.2
