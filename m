From: chaotian.jing@mediatek.com (Chaotian Jing)
Date: Tue, 19 May 2015 14:36:48 +0800
Subject: [PATCH v4 4/7] arm64: dts: mediatek: Add MT8173 MMC dts
In-Reply-To: <1432017411-2996-1-git-send-email-chaotian.jing@mediatek.com>
References: <1432017411-2996-1-git-send-email-chaotian.jing@mediatek.com>
Message-ID: <1432017411-2996-5-git-send-email-chaotian.jing@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Eddie Huang <eddie.huang@mediatek.com>

Add node mmc0 ~ mmc3 for mt8173.dtsi
Add node mmc0, mmc1 for mt8173-evb.dts

Signed-off-by: Chaotian Jing <chaotian.jing@mediatek.com>
Signed-off-by: Eddie Huang <eddie.huang@mediatek.com>
---
 arch/arm64/boot/dts/mediatek/mt8173-evb.dts | 115 ++++++++++++++++++++++++++++
 arch/arm64/boot/dts/mediatek/mt8173.dtsi    |  43 ++++++++++-
 2 files changed, 157 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt8173-evb.dts b/arch/arm64/boot/dts/mediatek/mt8173-evb.dts
index b1560c9..5312f07 100644
--- a/arch/arm64/boot/dts/mediatek/mt8173-evb.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8173-evb.dts
@@ -33,6 +33,121 @@
 	chosen { };
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
+	cap-sd-highspeed;
+	sd-uhs-sdr25;
+	cd-gpios = <&pio 132 0>;
+	vmmc-supply = <&mt6397_vmch_reg>;
+	vqmmc-supply = <&mt6397_vmc_reg>;
+};
+
+&pio {
+	mmc0_pins_default: mmc0default {
+		pins_cmd_dat {
+			pinmux = <MT8173_PIN_57_MSDC0_DAT0__FUNC_MSDC0_DAT0>,
+				<MT8173_PIN_58_MSDC0_DAT1__FUNC_MSDC0_DAT1>,
+				<MT8173_PIN_59_MSDC0_DAT2__FUNC_MSDC0_DAT2>,
+				<MT8173_PIN_60_MSDC0_DAT3__FUNC_MSDC0_DAT3>,
+				<MT8173_PIN_61_MSDC0_DAT4__FUNC_MSDC0_DAT4>,
+				<MT8173_PIN_62_MSDC0_DAT5__FUNC_MSDC0_DAT5>,
+				<MT8173_PIN_63_MSDC0_DAT6__FUNC_MSDC0_DAT6>,
+				<MT8173_PIN_64_MSDC0_DAT7__FUNC_MSDC0_DAT7>,
+				<MT8173_PIN_66_MSDC0_CMD__FUNC_MSDC0_CMD>,
+				<MT8173_PIN_68_MSDC0_RST___FUNC_MSDC0_RSTB>;
+				bias-pull-up;
+		};
+		pins_clk {
+			pinmux =  <MT8173_PIN_65_MSDC0_CLK__FUNC_MSDC0_CLK>;
+				bias-pull-down;
+		};
+	};
+
+	mmc1_pins_default: mmc1default {
+		pins_cmd_dat {
+			pinmux = <MT8173_PIN_73_MSDC1_DAT0__FUNC_MSDC1_DAT0>,
+			     <MT8173_PIN_74_MSDC1_DAT1__FUNC_MSDC1_DAT1>,
+			     <MT8173_PIN_75_MSDC1_DAT2__FUNC_MSDC1_DAT2>,
+			     <MT8173_PIN_76_MSDC1_DAT3__FUNC_MSDC1_DAT3>,
+			     <MT8173_PIN_78_MSDC1_CMD__FUNC_MSDC1_CMD>;
+			input-enable;
+			drive-strength = <MTK_DRIVE_4mA>;
+			bias-pull-up = <MTK_PUPD_SET_R1R0_10>;
+		};
+
+		pins_clk {
+			pinmux = <MT8173_PIN_77_MSDC1_CLK__FUNC_MSDC1_CLK>;
+			bias-pull-down;
+			drive-strength = <MTK_DRIVE_4mA>;
+		};
+
+		pins_insert {
+			pinmux = <MT8173_PIN_132_I2S0_DATA1__FUNC_GPIO132>;
+			bias-pull-up;
+		};
+	};
+
+	mmc0_pins_uhs: mmc0 at 0{
+		pins_cmd_dat {
+			pinmux = <MT8173_PIN_57_MSDC0_DAT0__FUNC_MSDC0_DAT0>,
+				<MT8173_PIN_58_MSDC0_DAT1__FUNC_MSDC0_DAT1>,
+				<MT8173_PIN_59_MSDC0_DAT2__FUNC_MSDC0_DAT2>,
+				<MT8173_PIN_60_MSDC0_DAT3__FUNC_MSDC0_DAT3>,
+				<MT8173_PIN_61_MSDC0_DAT4__FUNC_MSDC0_DAT4>,
+				<MT8173_PIN_62_MSDC0_DAT5__FUNC_MSDC0_DAT5>,
+				<MT8173_PIN_63_MSDC0_DAT6__FUNC_MSDC0_DAT6>,
+				<MT8173_PIN_64_MSDC0_DAT7__FUNC_MSDC0_DAT7>,
+				<MT8173_PIN_66_MSDC0_CMD__FUNC_MSDC0_CMD>,
+				<MT8173_PIN_68_MSDC0_RST___FUNC_MSDC0_RSTB>;
+			input-enable;
+			drive-strength = <MTK_DRIVE_2mA>;
+			bias-pull-up = <MTK_PUPD_SET_R1R0_01>;
+		};
+
+		pins_clk {
+			pinmux = <MT8173_PIN_65_MSDC0_CLK__FUNC_MSDC0_CLK>;
+			drive-strength = <MTK_DRIVE_2mA>;
+			bias-pull-down = <MTK_PUPD_SET_R1R0_01>;
+		};
+	};
+
+	mmc1_pins_uhs: mmc1 at 0 {
+		pins_cmd_dat {
+			pinmux = <MT8173_PIN_73_MSDC1_DAT0__FUNC_MSDC1_DAT0>,
+			     <MT8173_PIN_74_MSDC1_DAT1__FUNC_MSDC1_DAT1>,
+			     <MT8173_PIN_75_MSDC1_DAT2__FUNC_MSDC1_DAT2>,
+			     <MT8173_PIN_76_MSDC1_DAT3__FUNC_MSDC1_DAT3>,
+			     <MT8173_PIN_78_MSDC1_CMD__FUNC_MSDC1_CMD>;
+			input-enable;
+			drive-strength = <MTK_DRIVE_4mA>;
+			bias-pull-up = <MTK_PUPD_SET_R1R0_10>;
+		};
+
+		pins_clk {
+			pinmux = <MT8173_PIN_77_MSDC1_CLK__FUNC_MSDC1_CLK>;
+			drive-strength = <MTK_DRIVE_4mA>;
+			bias-pull-down = <MTK_PUPD_SET_R1R0_10>;
+		};
+	};
+};
+
 &pwrap {
 	pmic: mt6397 {
 		compatible = "mediatek,mt6397";
diff --git a/arch/arm64/boot/dts/mediatek/mt8173.dtsi b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
index d2aed57..4581345 100644
--- a/arch/arm64/boot/dts/mediatek/mt8173.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
@@ -251,7 +251,48 @@
 			clock-names = "baud", "bus";
 			status = "disabled";
 		};
-	};
 
+		mmc0: mmc at 11230000 {
+			compatible = "mediatek,mt8173-mmc",
+				     "mediatek,mt8135-mmc";
+			reg = <0 0x11230000 0 0x1000>;
+			interrupts = <GIC_SPI 71 IRQ_TYPE_LEVEL_LOW>;
+			clocks = <&pericfg CLK_PERI_MSDC30_0>,
+				 <&topckgen CLK_TOP_MSDC50_0_H_SEL>;
+			clock-names = "source", "hclk";
+			status = "disabled";
+		};
+
+		mmc1: mmc at 11240000 {
+			compatible = "mediatek,mt8173-mmc",
+				     "mediatek,mt8135-mmc";
+			reg = <0 0x11240000 0 0x1000>;
+			interrupts = <GIC_SPI 72 IRQ_TYPE_LEVEL_LOW>;
+			clocks = <&pericfg CLK_PERI_MSDC30_1>;
+			clock-names = "source";
+			status = "disabled";
+		};
+
+		mmc2: mmc at 11250000 {
+			compatible = "mediatek,mt8173-mmc",
+				     "mediatek,mt8135-mmc";
+			reg = <0 0x11250000 0 0x1000>;
+			interrupts = <GIC_SPI 73 IRQ_TYPE_LEVEL_LOW>;
+			clocks = <&pericfg CLK_PERI_MSDC30_2>;
+			clock-names = "source";
+			status = "disabled";
+		};
+
+		mmc3: mmc at 11260000 {
+			compatible = "mediatek,mt8173-mmc",
+				     "mediatek,mt8135-mmc";
+			reg = <0 0x11260000 0 0x1000>;
+			interrupts = <GIC_SPI 74 IRQ_TYPE_LEVEL_LOW>;
+			clocks = <&pericfg CLK_PERI_MSDC30_3>,
+				 <&topckgen CLK_TOP_MSDC50_2_H_SEL>;
+			clock-names = "source", "hclk";
+			status = "disabled";
+		};
+	};
 };
 
-- 
1.8.1.1.dirty
