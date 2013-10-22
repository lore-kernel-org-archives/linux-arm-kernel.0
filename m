From: rahul.sharma@samsung.com (Rahul Sharma)
Date: Tue, 22 Oct 2013 15:41:08 +0530
Subject: [PATCH v2 7/7] ARM: dts: update hdmiphy dt node for exynos5420
In-Reply-To: <1382436668-15813-1-git-send-email-rahul.sharma@samsung.com>
References: <1382436668-15813-1-git-send-email-rahul.sharma@samsung.com>
Message-ID: <1382436668-15813-8-git-send-email-rahul.sharma@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

hdmiphy dt node needs a child node called 'phy-power-control'
which represents the PMU register for power controlling the
hdmiphy.

hdmi driver dt node provides phy property which points to
the hdmiphy dt node.

Signed-off-by: Rahul Sharma <rahul.sharma@samsung.com>
---
 arch/arm/boot/dts/exynos5420.dtsi |   14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/exynos5420.dtsi b/arch/arm/boot/dts/exynos5420.dtsi
index ed687ac..f7fb337 100644
--- a/arch/arm/boot/dts/exynos5420.dtsi
+++ b/arch/arm/boot/dts/exynos5420.dtsi
@@ -207,7 +207,7 @@
 	};
 
 	hdmi at 14530000 {
-		compatible = "samsung,exynos4212-hdmi";
+		compatible = "samsung,exynos5420-hdmi";
 		reg = <0x14530000 0x70000>;
 		interrupts = <0 95 0>;
 		clocks = <&clock 413>, <&clock 143>, <&clock 768>,
@@ -215,6 +215,18 @@
 		clock-names = "hdmi", "sclk_hdmi", "sclk_pixel",
 			"sclk_hdmiphy", "mout_hdmi";
 		status = "disabled";
+		phy = <&hdmiphy>;
+	};
+
+	hdmiphy: hdmiphy at 145D0000 {
+		compatible = "samsung,exynos5420-hdmiphy";
+		reg = <0x145D0000 0x20>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+
+		phy-power-control {
+			reg = <0x10040700 0x04>;
+		};
 	};
 
 	mixer at 14450000 {
-- 
1.7.10.4
