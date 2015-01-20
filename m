From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Tue, 20 Jan 2015 13:16:57 +0100
Subject: [PATCH v4 7/9] ARM: dts: Exynos: add 'hdmi' clock to mixer nodes
In-Reply-To: <1421756219-21037-1-git-send-email-m.szyprowski@samsung.com>
References: <1421756219-21037-1-git-send-email-m.szyprowski@samsung.com>
Message-ID: <1421756219-21037-8-git-send-email-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mixed block needs to control hdmi clock to properly perform power on/off
operation, so add 'hdmi' clock also to mixer nodes.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 arch/arm/boot/dts/exynos5250.dtsi | 5 +++--
 arch/arm/boot/dts/exynos5420.dtsi | 5 +++--
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/exynos5250.dtsi b/arch/arm/boot/dts/exynos5250.dtsi
index 9bb1b0b738f5..e8c67fdb69fb 100644
--- a/arch/arm/boot/dts/exynos5250.dtsi
+++ b/arch/arm/boot/dts/exynos5250.dtsi
@@ -732,8 +732,9 @@
 		compatible = "samsung,exynos5250-mixer";
 		reg = <0x14450000 0x10000>;
 		interrupts = <0 94 0>;
-		clocks = <&clock CLK_MIXER>, <&clock CLK_SCLK_HDMI>;
-		clock-names = "mixer", "sclk_hdmi";
+		clocks = <&clock CLK_MIXER>, <&clock CLK_HDMI>,
+			 <&clock CLK_SCLK_HDMI>;
+		clock-names = "mixer", "hdmi", "sclk_hdmi";
 	};
 
 	dp_phy: video-phy at 10040720 {
diff --git a/arch/arm/boot/dts/exynos5420.dtsi b/arch/arm/boot/dts/exynos5420.dtsi
index e5cb74d2b9f5..8e464314260c 100644
--- a/arch/arm/boot/dts/exynos5420.dtsi
+++ b/arch/arm/boot/dts/exynos5420.dtsi
@@ -724,8 +724,9 @@
 		compatible = "samsung,exynos5420-mixer";
 		reg = <0x14450000 0x10000>;
 		interrupts = <0 94 0>;
-		clocks = <&clock CLK_MIXER>, <&clock CLK_SCLK_HDMI>;
-		clock-names = "mixer", "sclk_hdmi";
+		clocks = <&clock CLK_MIXER>, <&clock CLK_HDMI>,
+			 <&clock CLK_SCLK_HDMI>;
+		clock-names = "mixer", "hdmi", "sclk_hdmi";
 	};
 
 	gsc_0: video-scaler at 13e00000 {
-- 
1.9.2
