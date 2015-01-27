From: chaotian.jing@mediatek.com (Chaotian Jing)
Date: Tue, 27 Jan 2015 14:15:31 +0800
Subject: [PATCH 6/7] dts: mediatek: Add MT8135 mmc dts
In-Reply-To: <1422339332-27498-1-git-send-email-chaotian.jing@mediatek.com>
References: <1422339332-27498-1-git-send-email-chaotian.jing@mediatek.com>
Message-ID: <1422339332-27498-7-git-send-email-chaotian.jing@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add node mmc0, mmc1, mmc2

Signed-off-by: Chaotian Jing <chaotian.jing@mediatek.com>
---
 arch/arm/boot/dts/mt8135-evbp1.dts | 137 +++++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/mt8135.dtsi      |  27 ++++++++
 2 files changed, 164 insertions(+)

diff --git a/arch/arm/boot/dts/mt8135-evbp1.dts b/arch/arm/boot/dts/mt8135-evbp1.dts
index 73a833b..34abca6 100644
--- a/arch/arm/boot/dts/mt8135-evbp1.dts
+++ b/arch/arm/boot/dts/mt8135-evbp1.dts
@@ -226,3 +226,140 @@
 		};
 	};
 };
+
+&pio {
+	mmc0_pins_default: mmc0default {
+		pins_cmd_dat {
+			pins = <MT8135_PIN_0_MSDC0_DAT7__FUNC_MSDC0_DAT7>,
+				<MT8135_PIN_1_MSDC0_DAT6__FUNC_MSDC0_DAT6>,
+				<MT8135_PIN_2_MSDC0_DAT5__FUNC_MSDC0_DAT5>,
+				<MT8135_PIN_3_MSDC0_DAT4__FUNC_MSDC0_DAT4>,
+				<MT8135_PIN_4_MSDC0_CMD__FUNC_MSDC0_CMD>,
+				<MT8135_PIN_6_MSDC0_DAT3__FUNC_MSDC0_DAT3>,
+				<MT8135_PIN_7_MSDC0_DAT2__FUNC_MSDC0_DAT2>,
+				<MT8135_PIN_8_MSDC0_DAT1__FUNC_MSDC0_DAT1>,
+				<MT8135_PIN_9_MSDC0_DAT0__FUNC_MSDC0_DAT0>,
+				<MT8135_PIN_33_MSDC0_RSTB__FUNC_MSDC0_RSTB>;
+			bias-pull-up;
+		};
+		pins_clk {
+			pins = <MT8135_PIN_5_MSDC0_CLK__FUNC_MSDC0_CLK>;
+			bias-pull-down;
+		};
+	};
+
+	mmc1_pins_default: mmc1default {
+		pins_cmd_dat {
+			pins = <MT8135_PIN_83_MSDC1_DAT0__FUNC_MSDC1_DAT0>,
+			     <MT8135_PIN_84_MSDC1_DAT1__FUNC_MSDC1_DAT1>,
+			     <MT8135_PIN_85_MSDC1_CMD__FUNC_MSDC1_CMD>,
+			     <MT8135_PIN_87_MSDC1_DAT2__FUNC_MSDC1_DAT2>,
+			     <MT8135_PIN_88_MSDC1_DAT3__FUNC_MSDC1_DAT3>,
+			     <MT8135_PIN_63_MSDC1_INSI__FUNC_MSDC1_INSI>;
+			bias-pull-up;
+		};
+		pins_clk {
+			pins = <MT8135_PIN_86_MSDC1_CLK__FUNC_MSDC1_CLK>;
+			bias-pull-down;
+		};
+	};
+
+	mmc2_pins_default: mmc2default {
+		pins_cmd_dat {
+			pins = <MT8135_PIN_82_MSDC2_DAT0__FUNC_MSDC2_DAT0>,
+			     <MT8135_PIN_81_MSDC2_DAT1__FUNC_MSDC2_DAT1>,
+			     <MT8135_PIN_79_MSDC2_CMD__FUNC_MSDC2_CMD>,
+			     <MT8135_PIN_77_MSDC2_DAT2__FUNC_MSDC2_DAT2>,
+			     <MT8135_PIN_78_MSDC2_DAT3__FUNC_MSDC2_DAT3>,
+			     <MT8135_PIN_65_MSDC2_INSI__FUNC_MSDC2_INSI>;
+			bias-pull-up;
+		};
+		pins_clk {
+			pins = <MT8135_PIN_80_MSDC2_CLK__FUNC_MSDC2_CLK>;
+		bias-pull-down;
+		};
+	};
+
+	mmc0_pins_uhs: mmc0 at 0 {
+		pins_cmd_dat {
+			pins = <MT8135_PIN_0_MSDC0_DAT7__FUNC_MSDC0_DAT7>,
+			     <MT8135_PIN_1_MSDC0_DAT6__FUNC_MSDC0_DAT6>,
+			     <MT8135_PIN_2_MSDC0_DAT5__FUNC_MSDC0_DAT5>,
+			     <MT8135_PIN_3_MSDC0_DAT4__FUNC_MSDC0_DAT4>,
+			     <MT8135_PIN_4_MSDC0_CMD__FUNC_MSDC0_CMD>,
+			     <MT8135_PIN_6_MSDC0_DAT3__FUNC_MSDC0_DAT3>,
+			     <MT8135_PIN_7_MSDC0_DAT2__FUNC_MSDC0_DAT2>,
+			     <MT8135_PIN_8_MSDC0_DAT1__FUNC_MSDC0_DAT1>,
+			     <MT8135_PIN_9_MSDC0_DAT0__FUNC_MSDC0_DAT0>,
+			     <MT8135_PIN_33_MSDC0_RSTB__FUNC_MSDC0_RSTB>;
+			input-enable;
+			drive-strength = <MTK_DRIVE_6mA>;
+			bias-pull-up = <MTK_PUPD_SET_R1R0_01>;
+		};
+		pins_clk {
+			pins = <MT8135_PIN_5_MSDC0_CLK__FUNC_MSDC0_CLK>;
+			drive-strength = <MTK_DRIVE_6mA>;
+			bias-pull-down = <MTK_PUPD_SET_R1R0_01>;
+		};
+	};
+
+	mmc1_pins_uhs: mmc1 at 0 {
+		pins_cmd_dat {
+			pins = <MT8135_PIN_83_MSDC1_DAT0__FUNC_MSDC1_DAT0>,
+			     <MT8135_PIN_84_MSDC1_DAT1__FUNC_MSDC1_DAT1>,
+			     <MT8135_PIN_85_MSDC1_CMD__FUNC_MSDC1_CMD>,
+			     <MT8135_PIN_87_MSDC1_DAT2__FUNC_MSDC1_DAT2>,
+			     <MT8135_PIN_88_MSDC1_DAT3__FUNC_MSDC1_DAT3>;
+			input-enable;
+			drive-strength = <MTK_DRIVE_8mA>;
+			bias-pull-up = <MTK_PUPD_SET_R1R0_10>;
+		};
+		pins_clk {
+			pins = <MT8135_PIN_86_MSDC1_CLK__FUNC_MSDC1_CLK>;
+			drive-strength = <MTK_DRIVE_8mA>;
+			bias-pull-down = <MTK_PUPD_SET_R1R0_10>;
+		};
+	};
+
+	mmc2_pins_uhs: mmc2 at 0 {
+		pins_cmd_dat {
+			pins = <MT8135_PIN_82_MSDC2_DAT0__FUNC_MSDC2_DAT0>,
+			     <MT8135_PIN_81_MSDC2_DAT1__FUNC_MSDC2_DAT1>,
+			     <MT8135_PIN_79_MSDC2_CMD__FUNC_MSDC2_CMD>,
+			     <MT8135_PIN_77_MSDC2_DAT2__FUNC_MSDC2_DAT2>,
+			     <MT8135_PIN_78_MSDC2_DAT3__FUNC_MSDC2_DAT3>;
+			input-enable;
+			drive-strength = <MTK_DRIVE_8mA>;
+			bias-pull-up = <MTK_PUPD_SET_R1R0_10>;
+		};
+		pins_clk {
+			pins = <MT8135_PIN_80_MSDC2_CLK__FUNC_MSDC2_CLK>;
+			drive-strength = <MTK_DRIVE_8mA>;
+			bias-pull-down = <MTK_PUPD_SET_R1R0_10>;
+		};
+	};
+};
+
+&mmc0 {
+	pinctrl-names = "default", "state_uhs";
+	pinctrl-0 = <&mmc0_pins_default>;
+	pinctrl-1 = <&mmc0_pins_uhs>;
+	status = "okay";
+	bus-width = <8>;
+	max-frequency = <50000000>;
+	cap-mmc-highspeed;
+	core-power-supply = <&mt6397_vemc_3v3_reg>;
+	non-removable;
+};
+
+&mmc1 {
+	pinctrl-names = "default", "state_uhs";
+	pinctrl-0 = <&mmc1_pins_default>;
+	pinctrl-1 = <&mmc1_pins_uhs>;
+	status = "okay";
+	bus-width = <4>;
+	max-frequency = <50000000>;
+	core-power-supply = <&mt6397_vmch_reg>;
+	io-power-supply = <&mt6397_vmc_reg>;
+	cd-gpios = <&pio 63 0>;
+};
diff --git a/arch/arm/boot/dts/mt8135.dtsi b/arch/arm/boot/dts/mt8135.dtsi
index 53ce89f..cc2550c 100644
--- a/arch/arm/boot/dts/mt8135.dtsi
+++ b/arch/arm/boot/dts/mt8135.dtsi
@@ -253,5 +253,32 @@
 			      <0 0x10214000 0 0x2000>,
 			      <0 0x10216000 0 0x2000>;
 		};
+
+		mmc0: mmc at 11230000 {
+			compatible = "mediatek,mt8135-mmc";
+			reg = <0 0x11230000 0 0x108>;
+			interrupts = <GIC_SPI 39 IRQ_TYPE_LEVEL_LOW>;
+			clocks = <&pericfg PERI_MSDC20_1_CK>;
+			clock-names = "source";
+			status = "disabled";
+		};
+
+		mmc1: mmc at 11240000 {
+			compatible = "mediatek,mt8135-mmc";
+			reg = <0 0x11240000 0 0x108>;
+			interrupts = <GIC_SPI 40 IRQ_TYPE_LEVEL_LOW>;
+			clocks = <&pericfg PERI_MSDC20_2_CK>;
+			clock-names = "source";
+			status = "disabled";
+		};
+
+		mmc2: mmc at 11250000 {
+			compatible = "mediatek,mt8135-mmc";
+			reg = <0 0x11250000 0 0x108>;
+			interrupts = <GIC_SPI 41 IRQ_TYPE_LEVEL_LOW>;
+			clocks = <&pericfg PERI_MSDC30_1_CK>;
+			clock-names = "source";
+			status = "disabled";
+		};
 	};
 };
-- 
1.8.1.1.dirty
