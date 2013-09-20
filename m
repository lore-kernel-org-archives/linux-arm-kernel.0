From: abrestic@chromium.org (Andrew Bresticker)
Date: Fri, 20 Sep 2013 14:13:57 -0700
Subject: [PATCH 6/6] ARM: dts: exynos5420: add sclk_pcm_in to audss clock
 controller
In-Reply-To: <1379711637-5226-1-git-send-email-abrestic@chromium.org>
References: <1379711637-5226-1-git-send-email-abrestic@chromium.org>
Message-ID: <1379711637-5226-6-git-send-email-abrestic@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The parent of sclk_pcm in the AudioSS block is sclk_maupcm0.

Signed-off-by: Andrew Bresticker <abrestic@chromium.org>
---
 arch/arm/boot/dts/exynos5420.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/exynos5420.dtsi b/arch/arm/boot/dts/exynos5420.dtsi
index d537cd7..339ab93 100644
--- a/arch/arm/boot/dts/exynos5420.dtsi
+++ b/arch/arm/boot/dts/exynos5420.dtsi
@@ -72,8 +72,8 @@
 		compatible = "samsung,exynos5420-audss-clock";
 		reg = <0x03810000 0x0C>;
 		#clock-cells = <1>;
-		clocks = <&clock 148>;
-		clock-names = "sclk_audio";
+		clocks = <&clock 148>, <&clock 149>;
+		clock-names = "sclk_audio", "sclk_pcm_in";
 	};
 
 	codec at 11000000 {
-- 
1.8.4
