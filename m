From: broonie@kernel.org (Mark Brown)
Date: Tue,  7 Jan 2014 14:12:01 +0000
Subject: [PATCH] ARM: dts: Remove leftover spi0 node for SMDK5250
Message-ID: <1389103921-30616-1-git-send-email-broonie@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Mark Brown <broonie@linaro.org>

Now that the SPI controllers are disabled by default for Exynos5250
there is no need to explicitly disable them in individual board files.
This hunk appears not to have been merged when doing the original
conversion, add it now.

Signed-off-by: Mark Brown <broonie@linaro.org>
---
 arch/arm/boot/dts/exynos5250-smdk5250.dts | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/arm/boot/dts/exynos5250-smdk5250.dts b/arch/arm/boot/dts/exynos5250-smdk5250.dts
index 3e69837c435c..b370f8a20cdf 100644
--- a/arch/arm/boot/dts/exynos5250-smdk5250.dts
+++ b/arch/arm/boot/dts/exynos5250-smdk5250.dts
@@ -164,10 +164,6 @@
 		};
 	};
 
-	spi_0: spi at 12d20000 {
-		status = "disabled";
-	};
-
 	spi_1: spi at 12d30000 {
 		status = "okay";
 
-- 
1.8.5.2
