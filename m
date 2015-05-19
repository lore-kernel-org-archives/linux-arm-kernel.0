From: chaotian.jing@mediatek.com (Chaotian Jing)
Date: Tue, 19 May 2015 14:36:50 +0800
Subject: [PATCH v4 6/7] ARM: mediatek: dts: Add emmc support to mt8135
In-Reply-To: <1432017411-2996-1-git-send-email-chaotian.jing@mediatek.com>
References: <1432017411-2996-1-git-send-email-chaotian.jing@mediatek.com>
Message-ID: <1432017411-2996-7-git-send-email-chaotian.jing@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Yingjoe Chen <yingjoe.chen@mediatek.com>

Add emmc node for mt8135.dtsi & mt8135-evbp1.dts

Signed-off-by: Yingjoe Chen <yingjoe.chen@mediatek.com>
Signed-off-by: Chaotian Jing <chaotian.jing@mediatek.com>
---
 arch/arm/boot/dts/mt8135-evbp1.dts | 139 +++++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/mt8135.dtsi      |  26 +++++++
 2 files changed, 165 insertions(+)

diff --git a/arch/arm/boot/dts/mt8135-evbp1.dts b/arch/arm/boot/dts/mt8135-evbp1.dts
index 357a91f..6950e84 100644
--- a/arch/arm/boot/dts/mt8135-evbp1.dts
+++ b/arch/arm/boot/dts/mt8135-evbp1.dts
@@ -24,6 +24,145 @@
 	};
 };
 
+&mmc0 {
+	pinctrl-names = "default", "state_uhs";
+	pinctrl-0 = <&mmc0_pins_default>;
+	pinctrl-1 = <&mmc0_pins_uhs>;
+	status = "okay";
+	bus-width = <8>;
+	max-frequency = <50000000>;
+	cap-mmc-highspeed;
+	vmmc-supply = <&mt6397_vemc_3v3_reg>;
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
+	vmmc-supply = <&mt6397_vmch_reg>;
+	vqmmc-supply = <&mt6397_vmc_reg>;
+	cd-gpios = <&pio 63 0>;
+	cap-sd-highspeed;
+	sd-uhs-sdr25;
+};
+
+&pio {
+	mmc0_pins_default: mmc0default {
+		pins_cmd_dat {
+			pinmux = <MT8135_PIN_0_MSDC0_DAT7__FUNC_MSDC0_DAT7>,
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
+			pinmux = <MT8135_PIN_5_MSDC0_CLK__FUNC_MSDC0_CLK>;
+			bias-pull-down;
+		};
+	};
+
+	mmc1_pins_default: mmc1default {
+		pins_cmd_dat {
+			pinmux = <MT8135_PIN_83_MSDC1_DAT0__FUNC_MSDC1_DAT0>,
+			     <MT8135_PIN_84_MSDC1_DAT1__FUNC_MSDC1_DAT1>,
+			     <MT8135_PIN_85_MSDC1_CMD__FUNC_MSDC1_CMD>,
+			     <MT8135_PIN_87_MSDC1_DAT2__FUNC_MSDC1_DAT2>,
+			     <MT8135_PIN_88_MSDC1_DAT3__FUNC_MSDC1_DAT3>,
+			     <MT8135_PIN_63_MSDC1_INSI__FUNC_MSDC1_INSI>;
+			bias-pull-up;
+		};
+		pins_clk {
+			pinmux = <MT8135_PIN_86_MSDC1_CLK__FUNC_MSDC1_CLK>;
+			bias-pull-down;
+		};
+	};
+
+	mmc2_pins_default: mmc2default {
+		pins_cmd_dat {
+			pinmux = <MT8135_PIN_82_MSDC2_DAT0__FUNC_MSDC2_DAT0>,
+			     <MT8135_PIN_81_MSDC2_DAT1__FUNC_MSDC2_DAT1>,
+			     <MT8135_PIN_79_MSDC2_CMD__FUNC_MSDC2_CMD>,
+			     <MT8135_PIN_77_MSDC2_DAT2__FUNC_MSDC2_DAT2>,
+			     <MT8135_PIN_78_MSDC2_DAT3__FUNC_MSDC2_DAT3>,
+			     <MT8135_PIN_65_MSDC2_INSI__FUNC_MSDC2_INSI>;
+			bias-pull-up;
+		};
+		pins_clk {
+			pinmux = <MT8135_PIN_80_MSDC2_CLK__FUNC_MSDC2_CLK>;
+		bias-pull-down;
+		};
+	};
+
+	mmc0_pins_uhs: mmc0 at 0 {
+		pins_cmd_dat {
+			pinmux = <MT8135_PIN_0_MSDC0_DAT7__FUNC_MSDC0_DAT7>,
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
+			pinmux = <MT8135_PIN_5_MSDC0_CLK__FUNC_MSDC0_CLK>;
+			drive-strength = <MTK_DRIVE_6mA>;
+			bias-pull-down = <MTK_PUPD_SET_R1R0_01>;
+		};
+	};
+
+	mmc1_pins_uhs: mmc1 at 0 {
+		pins_cmd_dat {
+			pinmux = <MT8135_PIN_83_MSDC1_DAT0__FUNC_MSDC1_DAT0>,
+			     <MT8135_PIN_84_MSDC1_DAT1__FUNC_MSDC1_DAT1>,
+			     <MT8135_PIN_85_MSDC1_CMD__FUNC_MSDC1_CMD>,
+			     <MT8135_PIN_87_MSDC1_DAT2__FUNC_MSDC1_DAT2>,
+			     <MT8135_PIN_88_MSDC1_DAT3__FUNC_MSDC1_DAT3>;
+			input-enable;
+			drive-strength = <MTK_DRIVE_8mA>;
+			bias-pull-up = <MTK_PUPD_SET_R1R0_10>;
+		};
+		pins_clk {
+			pinmux = <MT8135_PIN_86_MSDC1_CLK__FUNC_MSDC1_CLK>;
+			drive-strength = <MTK_DRIVE_8mA>;
+			bias-pull-down = <MTK_PUPD_SET_R1R0_10>;
+		};
+	};
+
+	mmc2_pins_uhs: mmc2 at 0 {
+		pins_cmd_dat {
+			pinmux = <MT8135_PIN_82_MSDC2_DAT0__FUNC_MSDC2_DAT0>,
+			     <MT8135_PIN_81_MSDC2_DAT1__FUNC_MSDC2_DAT1>,
+			     <MT8135_PIN_79_MSDC2_CMD__FUNC_MSDC2_CMD>,
+			     <MT8135_PIN_77_MSDC2_DAT2__FUNC_MSDC2_DAT2>,
+			     <MT8135_PIN_78_MSDC2_DAT3__FUNC_MSDC2_DAT3>;
+			input-enable;
+			drive-strength = <MTK_DRIVE_8mA>;
+			bias-pull-up = <MTK_PUPD_SET_R1R0_10>;
+		};
+		pins_clk {
+			pinmux = <MT8135_PIN_80_MSDC2_CLK__FUNC_MSDC2_CLK>;
+			drive-strength = <MTK_DRIVE_8mA>;
+			bias-pull-down = <MTK_PUPD_SET_R1R0_10>;
+		};
+	};
+};
+
 &pwrap {
 	pmic: mt6397 {
 		compatible = "mediatek,mt6397";
diff --git a/arch/arm/boot/dts/mt8135.dtsi b/arch/arm/boot/dts/mt8135.dtsi
index 4d1ddd9..9632a0f 100644
--- a/arch/arm/boot/dts/mt8135.dtsi
+++ b/arch/arm/boot/dts/mt8135.dtsi
@@ -212,5 +212,31 @@
 			status = "disabled";
 		};
 
+		mmc0: mmc at 11230000 {
+			compatible = "mediatek,mt8135-mmc";
+			reg = <0 0x11230000 0 0x1000>;
+			interrupts = <GIC_SPI 39 IRQ_TYPE_LEVEL_LOW>;
+			clocks = <&pericfg CLK_PERI_MSDC20_1>;
+			clock-names = "source";
+			status = "disabled";
+		};
+
+		mmc1: mmc at 11240000 {
+			compatible = "mediatek,mt8135-mmc";
+			reg = <0 0x11240000 0 0x1000>;
+			interrupts = <GIC_SPI 40 IRQ_TYPE_LEVEL_LOW>;
+			clocks = <&pericfg CLK_PERI_MSDC20_2>;
+			clock-names = "source";
+			status = "disabled";
+		};
+
+		mmc2: mmc at 11250000 {
+			compatible = "mediatek,mt8135-mmc";
+			reg = <0 0x11250000 0 0x1000>;
+			interrupts = <GIC_SPI 41 IRQ_TYPE_LEVEL_LOW>;
+			clocks = <&pericfg CLK_PERI_MSDC30_1>;
+			clock-names = "source";
+			status = "disabled";
+		};
 	};
 };
-- 
1.8.1.1.dirty
