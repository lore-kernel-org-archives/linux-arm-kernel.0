From: jszhang@marvell.com (Jisheng Zhang)
Date: Tue, 22 Mar 2016 22:42:42 +0800
Subject: [PATCH 3/4] soc: qcom: spm: use const and __initconst for
 qcom_cpuidle_ops
In-Reply-To: <1458657763-2561-1-git-send-email-jszhang@marvell.com>
References: <1458657763-2561-1-git-send-email-jszhang@marvell.com>
Message-ID: <1458657763-2561-4-git-send-email-jszhang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The qcom_cpuidle_ops structures is not over-written, so add "const"
qualifier and replace __initdata with __initconst.

Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
---
 drivers/soc/qcom/spm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/qcom/spm.c b/drivers/soc/qcom/spm.c
index 5548a31..1fcbb22 100644
--- a/drivers/soc/qcom/spm.c
+++ b/drivers/soc/qcom/spm.c
@@ -274,7 +274,7 @@ check_spm:
 	return per_cpu(cpu_spm_drv, cpu) ? 0 : -ENXIO;
 }
 
-static struct cpuidle_ops qcom_cpuidle_ops __initdata = {
+static const struct cpuidle_ops qcom_cpuidle_ops __initconst = {
 	.suspend = qcom_idle_enter,
 	.init = qcom_cpuidle_init,
 };
-- 
2.8.0.rc3
