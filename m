From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Fri, 22 Apr 2016 10:31:30 +0200
Subject: [PATCH 4/4] drivers: firmware: psci: use const and __initconst for
 psci_cpuidle_ops
In-Reply-To: <1461313892-20613-1-git-send-email-daniel.lezcano@linaro.org>
References: <5719E10D.5020008@linaro.org>
 <1461313892-20613-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <1461313892-20613-4-git-send-email-daniel.lezcano@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jisheng Zhang <jszhang@marvell.com>

The psci_cpuidle_ops structures is not over-written, so add "const"
qualifier and replace __initdata with __initconst.

Acked-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/firmware/psci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/psci.c b/drivers/firmware/psci.c
index 11bfee8..eb8134a 100644
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
1.9.1
