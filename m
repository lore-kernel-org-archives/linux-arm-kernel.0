From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Tue, 13 Oct 2015 08:51:49 +0900
Subject: [PATCH] thermal: exynos: Fix register read in TMU
Message-ID: <1444693909-17754-1-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>

The value of emul_con was getting overwritten if the selected soc is
SOC_ARCH_EXYNOS5260. And so as a result we were reading from the wrong
register in the case of SOC_ARCH_EXYNOS5260.

Signed-off-by: Sudip Mukherjee <sudip@vectorindia.org>
Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
Acked-by: Lukasz Majewski <l.majewski@samsung.com>
Fixes: 488c7455d74c ("thermal: exynos: Add the support for Exynos5433 TMU")
Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 drivers/thermal/samsung/exynos_tmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
index 0bae8cc6c23a..ca920b0ecf8f 100644
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
