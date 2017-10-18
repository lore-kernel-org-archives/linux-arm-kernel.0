From: wens@csie.org (Chen-Yu Tsai)
Date: Wed, 18 Oct 2017 16:31:36 +0800
Subject: [PATCH v2 6/8] ARM: dts: sun8i: a83t: Move mmc1 pinctrl setting to
 dtsi file
In-Reply-To: <20171018083138.14517-1-wens@csie.org>
References: <20171018083138.14517-1-wens@csie.org>
Message-ID: <20171018083138.14517-7-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

mmc1 only has 1 possible pinmux setting.

Move any settings to the dtsi file and set it by default.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sun8i-a83t-tbs-a711.dts | 2 --
 arch/arm/boot/dts/sun8i-a83t.dtsi         | 2 ++
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/sun8i-a83t-tbs-a711.dts b/arch/arm/boot/dts/sun8i-a83t-tbs-a711.dts
index 723641f56a74..de0be140338b 100644
--- a/arch/arm/boot/dts/sun8i-a83t-tbs-a711.dts
+++ b/arch/arm/boot/dts/sun8i-a83t-tbs-a711.dts
@@ -115,8 +115,6 @@
 &mmc1 {
 	mmc-pwrseq = <&wifi_pwrseq>;
 	bus-width = <4>;
-	pinctrl-names = "default";
-	pinctrl-0 = <&mmc1_pins>;
 	vmmc-supply = <&reg_vcc3v3>;
 	vqmmc-supply = <&reg_vcc3v3>;
 	non-removable;
diff --git a/arch/arm/boot/dts/sun8i-a83t.dtsi b/arch/arm/boot/dts/sun8i-a83t.dtsi
index ce6e887c8938..19acae1b4089 100644
--- a/arch/arm/boot/dts/sun8i-a83t.dtsi
+++ b/arch/arm/boot/dts/sun8i-a83t.dtsi
@@ -212,6 +212,8 @@
 			resets = <&ccu RST_BUS_MMC1>;
 			reset-names = "ahb";
 			interrupts = <GIC_SPI 61 IRQ_TYPE_LEVEL_HIGH>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&mmc1_pins>;
 			status = "disabled";
 			#address-cells = <1>;
 			#size-cells = <0>;
-- 
2.14.2
