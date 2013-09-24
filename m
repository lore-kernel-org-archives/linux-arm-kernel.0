From: abrestic@chromium.org (Andrew Bresticker)
Date: Tue, 24 Sep 2013 11:06:54 -0700
Subject: [PATCH V3 4/6] ARM: dts: exynos5250: add input clocks to audss clock
 controller
In-Reply-To: <1380046016-5811-1-git-send-email-abrestic@chromium.org>
References: <1379982078-23381-1-git-send-email-abrestic@chromium.org>
 <1380046016-5811-1-git-send-email-abrestic@chromium.org>
Message-ID: <1380046016-5811-4-git-send-email-abrestic@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Specify pll_ref, pll_in, sclk_audio, and sclk_pcm_in for the AudioSS
clock controller.

Signed-off-by: Andrew Bresticker <abrestic@chromium.org>
---
Changes since v1:
 - specified additional input clocks
---
 arch/arm/boot/dts/exynos5250.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/exynos5250.dtsi b/arch/arm/boot/dts/exynos5250.dtsi
index 7d7cc77..2d6a93d 100644
--- a/arch/arm/boot/dts/exynos5250.dtsi
+++ b/arch/arm/boot/dts/exynos5250.dtsi
@@ -88,6 +88,8 @@
 		compatible = "samsung,exynos5250-audss-clock";
 		reg = <0x03810000 0x0C>;
 		#clock-cells = <1>;
+		clocks = <&clock 1>, <&clock 7>, <&clock 138>, <&clock 160>;
+		clock-names = "pll_ref", "pll_in", "sclk_audio", "sclk_pcm_in";
 	};
 
 	timer {
-- 
1.8.4
