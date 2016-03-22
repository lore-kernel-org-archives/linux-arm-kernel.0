From: jszhang@marvell.com (Jisheng Zhang)
Date: Tue, 22 Mar 2016 22:35:29 +0800
Subject: [PATCH] drivers: firmware: psci: add __init mark to
 psci_dt_cpu_init_idle
Message-ID: <1458657329-2484-1-git-send-email-jszhang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

psci_dt_cpu_init_idle() and psci_cpu_init_idle() are not needed after
booting, so mark them as __init.

Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
---
 drivers/firmware/psci.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/psci.c b/drivers/firmware/psci.c
index 7d52186..284413f 100644
--- a/drivers/firmware/psci.c
+++ b/drivers/firmware/psci.c
@@ -250,7 +250,7 @@ static int __init psci_features(u32 psci_func_id)
 #ifdef CONFIG_CPU_IDLE
 static DEFINE_PER_CPU_READ_MOSTLY(u32 *, psci_power_state);
 
-static int psci_dt_cpu_init_idle(struct device_node *cpu_node, int cpu)
+static int __init psci_dt_cpu_init_idle(struct device_node *cpu_node, int cpu)
 {
 	int i, ret, count = 0;
 	u32 *psci_states;
@@ -310,7 +310,7 @@ free_mem:
 	return ret;
 }
 
-int psci_cpu_init_idle(unsigned int cpu)
+int __init psci_cpu_init_idle(unsigned int cpu)
 {
 	struct device_node *cpu_node;
 	int ret;
-- 
2.8.0.rc3
