From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Tue, 20 Jan 2015 13:16:58 +0100
Subject: [PATCH v4 8/9] ARM: dts: exynos5250: add display power domain
In-Reply-To: <1421756219-21037-1-git-send-email-m.szyprowski@samsung.com>
References: <1421756219-21037-1-git-send-email-m.szyprowski@samsung.com>
Message-ID: <1421756219-21037-9-git-send-email-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Andrzej Hajda <a.hajda@samsung.com>

The patch adds domain definition and references to it in appropriate devices.

Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
[mszyprow: rebased onto generic power domains dt bindings]
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Tested-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Reviewed-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
---
 arch/arm/boot/dts/exynos5250.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/exynos5250.dtsi b/arch/arm/boot/dts/exynos5250.dtsi
index e8c67fdb69fb..ae22bd98f956 100644
--- a/arch/arm/boot/dts/exynos5250.dtsi
+++ b/arch/arm/boot/dts/exynos5250.dtsi
@@ -102,6 +102,12 @@
 		#power-domain-cells = <0>;
 	};
 
+	pd_disp1: disp1-power-domain at 100440A0 {
+		compatible = "samsung,exynos4210-pd";
+		reg = <0x100440A0 0x20>;
+		#power-domain-cells = <0>;
+	};
+
 	clock: clock-controller at 10010000 {
 		compatible = "samsung,exynos5250-clock";
 		reg = <0x10010000 0x30000>;
@@ -719,6 +725,7 @@
 	hdmi: hdmi {
 		compatible = "samsung,exynos4212-hdmi";
 		reg = <0x14530000 0x70000>;
+		power-domains = <&pd_disp1>;
 		interrupts = <0 95 0>;
 		clocks = <&clock CLK_HDMI>, <&clock CLK_SCLK_HDMI>,
 			 <&clock CLK_SCLK_PIXEL>, <&clock CLK_SCLK_HDMIPHY>,
@@ -731,6 +738,7 @@
 	mixer {
 		compatible = "samsung,exynos5250-mixer";
 		reg = <0x14450000 0x10000>;
+		power-domains = <&pd_disp1>;
 		interrupts = <0 94 0>;
 		clocks = <&clock CLK_MIXER>, <&clock CLK_HDMI>,
 			 <&clock CLK_SCLK_HDMI>;
@@ -744,6 +752,7 @@
 	};
 
 	dp: dp-controller at 145B0000 {
+		power-domains = <&pd_disp1>;
 		clocks = <&clock CLK_DP>;
 		clock-names = "dp";
 		phys = <&dp_phy>;
@@ -751,6 +760,7 @@
 	};
 
 	fimd: fimd at 14400000 {
+		power-domains = <&pd_disp1>;
 		clocks = <&clock CLK_SCLK_FIMD1>, <&clock CLK_FIMD1>;
 		clock-names = "sclk_fimd", "fimd";
 	};
-- 
1.9.2
