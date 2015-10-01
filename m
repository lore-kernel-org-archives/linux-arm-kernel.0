From: sudipm.mukherjee@gmail.com (Sudip Mukherjee)
Date: Thu,  1 Oct 2015 17:09:59 +0530
Subject: [PATCH] thermal: exynos: fix register read in TMU
Message-ID: <1443699599-9693-1-git-send-email-sudipm.mukherjee@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The value of emul_con was getting overwritten if the selected soc is
SOC_ARCH_EXYNOS5260. And so as a result we were reading from the wrong
register in the case of SOC_ARCH_EXYNOS5260.

Signed-off-by: Sudip Mukherjee <sudip@vectorindia.org>
---
 drivers/thermal/samsung/exynos_tmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
index 0bae8cc..ca920b0 100644
--- a/drivers/thermal/samsung/exynos_tmu.c
+++ b/drivers/thermal/samsung/exynos_tmu.c
@@ -932,7 +932,7 @@ static void exynos4412_tmu_set_emulation(struct exynos_tmu_data *data,
 
 	if (data->soc == SOC_ARCH_EXYNOS5260)
 		emul_con = EXYNOS5260_EMUL_CON;
-	if (data->soc == SOC_ARCH_EXYNOS5433)
+	else if (data->soc == SOC_ARCH_EXYNOS5433)
 		emul_con = EXYNOS5433_TMU_EMUL_CON;
 	else if (data->soc == SOC_ARCH_EXYNOS7)
 		emul_con = EXYNOS7_TMU_REG_EMUL_CON;
-- 
1.9.1
