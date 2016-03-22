From: jszhang@marvell.com (Jisheng Zhang)
Date: Tue, 22 Mar 2016 22:42:43 +0800
Subject: [PATCH 4/4] drivers: firmware: psci: use const and __initconst for
 psci_cpuidle_ops
In-Reply-To: <1458657763-2561-1-git-send-email-jszhang@marvell.com>
References: <1458657763-2561-1-git-send-email-jszhang@marvell.com>
Message-ID: <1458657763-2561-5-git-send-email-jszhang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The psci_cpuidle_ops structures is not over-written, so add "const"
qualifier and replace __initdata with __initconst.

Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
---
 drivers/firmware/psci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/psci.c b/drivers/firmware/psci.c
index 6d86881..7d52186 100644
--- a/drivers/firmware/psci.c
+++ b/drivers/firmware/psci.c
@@ -355,7 +355,7 @@ int psci_cpu_suspend_enter(unsigned long index)
 
 /* ARM specific CPU idle operations */
 #ifdef CONFIG_ARM
-static struct cpuidle_ops psci_cpuidle_ops __initdata = {
+static const struct cpuidle_ops psci_cpuidle_ops __initconst = {
 	.suspend = psci_cpu_suspend_enter,
 	.init = psci_dt_cpu_init_idle,
 };
-- 
2.8.0.rc3
