From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Tue, 16 Feb 2016 15:20:30 +0900
Subject: [PATCH v5 1/3] clk: samsung: Enable COMPILE_TEST for Samsung clocks
In-Reply-To: <1455603632-11158-1-git-send-email-k.kozlowski@samsung.com>
References: <1455603632-11158-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <1455603632-11158-2-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable the COMPILE_TEST to get build coverage of some of Samsung clock
controller drivers. Still some of them will be built only if
appropriate SoC is chosen (like SOC_EXYNOS4415 or ARCH_S3C64XX).

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>
Tested-by: Javier Martinez Canillas <javier@osg.samsung.com>
Reviewed-by: Andi Shyti <andi.shyti@samsung.com>

---

Changes since v4:
1. Rebase on current clk tree which already contains patch moving
   Samsung clock drivers into the COMMON_CLK section.
   (b9e65ebc654, "clk: Move vendor's Kconfig into CCF menu section")

Changes since v3:
1. Rebase on next-20160127 (s3c64xx became multiplatform)

Changes since v2:
1. New patch.
---
 drivers/clk/samsung/Kconfig | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/samsung/Kconfig b/drivers/clk/samsung/Kconfig
index b3fe5cb01afe..dd6093a33f84 100644
--- a/drivers/clk/samsung/Kconfig
+++ b/drivers/clk/samsung/Kconfig
@@ -1,8 +1,8 @@
 config COMMON_CLK_SAMSUNG
-	bool
+	bool "Samsung Exynos clock controller support" if COMPILE_TEST
 
 config S3C2410_COMMON_CLK
-	bool
+	bool "Samsung S3C2410 clock controller support" if COMPILE_TEST
 	select COMMON_CLK_SAMSUNG
 	help
 	  Build the s3c2410 clock driver based on the common clock framework.
@@ -16,10 +16,10 @@ config S3C2410_COMMON_DCLK
 	  framework.
 
 config S3C2412_COMMON_CLK
-	bool
+	bool "Samsung S3C2412 clock controller support" if COMPILE_TEST
 	select COMMON_CLK_SAMSUNG
 
 config S3C2443_COMMON_CLK
-	bool
+	bool "Samsung S3C2443 clock controller support" if COMPILE_TEST
 	select COMMON_CLK_SAMSUNG
 
-- 
2.5.0
