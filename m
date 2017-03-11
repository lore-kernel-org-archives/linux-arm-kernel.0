From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Sat, 11 Mar 2017 22:00:20 +0200
Subject: [PATCH v3 4/5] mfd: exynos-lpass: Use common soc/exynos-regs-pmu.h
 header
In-Reply-To: <20170311200021.5827-1-krzk@kernel.org>
References: <20170311200021.5827-1-krzk@kernel.org>
Message-ID: <20170311200021.5827-5-krzk@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The MFD-specific header will go away because it duplicates defines from
exynos-regs-pmu.h.

Reported-by: kbuild test robot <fengguang.wu@intel.com>
Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/mfd/exynos-lpass.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mfd/exynos-lpass.c b/drivers/mfd/exynos-lpass.c
index 2e064fb8826f..8bebad92a385 100644
--- a/drivers/mfd/exynos-lpass.c
+++ b/drivers/mfd/exynos-lpass.c
@@ -18,11 +18,11 @@
 #include <linux/io.h>
 #include <linux/module.h>
 #include <linux/mfd/syscon.h>
-#include <linux/mfd/syscon/exynos5-pmu.h>
 #include <linux/of.h>
 #include <linux/of_platform.h>
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
+#include <linux/soc/samsung/exynos-regs-pmu.h>
 #include <linux/types.h>
 
 /* LPASS Top register definitions */
@@ -83,7 +83,7 @@ static void exynos_lpass_enable(struct exynos_lpass *lpass)
 
 	/* Activate related PADs from retention state */
 	regmap_write(lpass->pmu, EXYNOS5433_PAD_RETENTION_AUD_OPTION,
-		     EXYNOS5433_PAD_INITIATE_WAKEUP_FROM_LOWPWR);
+		     EXYNOS_WAKEUP_FROM_LOWPWR);
 
 	exynos_lpass_core_sw_reset(lpass, LPASS_I2S_SW_RESET);
 	exynos_lpass_core_sw_reset(lpass, LPASS_DMA_SW_RESET);
-- 
2.9.3
