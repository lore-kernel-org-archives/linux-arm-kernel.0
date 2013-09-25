From: abrestic@chromium.org (Andrew Bresticker)
Date: Wed, 25 Sep 2013 14:12:52 -0700
Subject: [PATCH V4 6/6] ARM: dts: exynos5420: add input clocks to audss clock
 controller
In-Reply-To: <1380143572-11741-1-git-send-email-abrestic@chromium.org>
References: <1380046016-5811-1-git-send-email-abrestic@chromium.org>
 <1380143572-11741-1-git-send-email-abrestic@chromium.org>
Message-ID: <1380143572-11741-6-git-send-email-abrestic@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Specify the remaining input clocks (pll_ref, pll_in, and sclk_pcm_in)
for the AudioSS clock controller.

Signed-off-by: Andrew Bresticker <abrestic@chromium.org>
---
Changes since v1:
 - specified additional input clocks
---
 arch/arm/boot/dts/exynos5420.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/exynos5420.dtsi b/arch/arm/boot/dts/exynos5420.dtsi
index d537cd7..056b55e 100644
--- a/arch/arm/boot/dts/exynos5420.dtsi
+++ b/arch/arm/boot/dts/exynos5420.dtsi
@@ -72,8 +72,8 @@
 		compatible = "samsung,exynos5420-audss-clock";
 		reg = <0x03810000 0x0C>;
 		#clock-cells = <1>;
-		clocks = <&clock 148>;
-		clock-names = "sclk_audio";
+		clocks = <&clock 1>, <&clock 5>, <&clock 148>, <&clock 149>;
+		clock-names = "pll_ref", "pll_in", "sclk_audio", "sclk_pcm_in";
 	};
 
 	codec at 11000000 {
-- 
1.8.4
