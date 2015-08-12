From: chaotian.jing@mediatek.com (Chaotian Jing)
Date: Wed, 12 Aug 2015 16:24:04 +0800
Subject: [PATCH 3/4] arm64: dts: mediatek: Support SD/EMMC SDR104/HS200/HS400
In-Reply-To: <1439367845-5891-1-git-send-email-chaotian.jing@mediatek.com>
References: <1439367845-5891-1-git-send-email-chaotian.jing@mediatek.com>
Message-ID: <1439367845-5891-4-git-send-email-chaotian.jing@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add 400Mhz source clock for EMMC HS400 mode
Support EMMC DDR50/HS200/HS400 of mt8173-evb
Support SD SDR25/SDR50/DDR50/SDR104 of mt8173-evb

Signed-off-by: Chaotian Jing <chaotian.jing@mediatek.com>
---
 arch/arm64/boot/dts/mediatek/mt8173-evb.dts | 10 ++++++++--
 arch/arm64/boot/dts/mediatek/mt8173.dtsi    |  5 +++--
 2 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt8173-evb.dts b/arch/arm64/boot/dts/mediatek/mt8173-evb.dts
index 4be66ca..cd5317f 100644
--- a/arch/arm64/boot/dts/mediatek/mt8173-evb.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8173-evb.dts
@@ -70,8 +70,11 @@
 	pinctrl-0 = <&mmc0_pins_default>;
 	pinctrl-1 = <&mmc0_pins_uhs>;
 	bus-width = <8>;
-	max-frequency = <50000000>;
+	max-frequency = <200000000>;
 	cap-mmc-highspeed;
+	mmc-ddr-1_8v;
+	mmc-hs200-1_8v;
+	mmc-hs400-1_8v;
 	vmmc-supply = <&mt6397_vemc_3v3_reg>;
 	vqmmc-supply = <&mt6397_vio18_reg>;
 	non-removable;
@@ -83,9 +86,12 @@
 	pinctrl-0 = <&mmc1_pins_default>;
 	pinctrl-1 = <&mmc1_pins_uhs>;
 	bus-width = <4>;
-	max-frequency = <50000000>;
+	max-frequency = <200000000>;
 	cap-sd-highspeed;
 	sd-uhs-sdr25;
+	sd-uhs-sdr50;
+	sd-uhs-ddr50;
+	sd-uhs-sdr104;
 	cd-gpios = <&pio 132 0>;
 	vmmc-supply = <&mt6397_vmch_reg>;
 	vqmmc-supply = <&mt6397_vmc_reg>;
diff --git a/arch/arm64/boot/dts/mediatek/mt8173.dtsi b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
index d18ee42..495ed94 100644
--- a/arch/arm64/boot/dts/mediatek/mt8173.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
@@ -450,8 +450,9 @@
 			reg = <0 0x11230000 0 0x1000>;
 			interrupts = <GIC_SPI 71 IRQ_TYPE_LEVEL_LOW>;
 			clocks = <&pericfg CLK_PERI_MSDC30_0>,
-				 <&topckgen CLK_TOP_MSDC50_0_H_SEL>;
-			clock-names = "source", "hclk";
+				 <&topckgen CLK_TOP_MSDC50_0_H_SEL>,
+				 <&topckgen CLK_TOP_MSDCPLL_D2>;
+			clock-names = "source", "hclk", "400Mhz_clk";
 			status = "disabled";
 		};
 
-- 
1.8.1.1.dirty
