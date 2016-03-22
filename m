From: jszhang@marvell.com (Jisheng Zhang)
Date: Tue, 22 Mar 2016 22:31:45 +0800
Subject: [PATCH] drivers: firmware: psci: make two helper functions static
Message-ID: <1458657105-2348-1-git-send-email-jszhang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

psci_power_state_loses_context() and psci_power_state_is_valid are only
used internally now, so make them static.

Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
---
 drivers/firmware/psci.c | 4 ++--
 include/linux/psci.h    | 2 --
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/firmware/psci.c b/drivers/firmware/psci.c
index 11bfee8..6d86881 100644
--- a/drivers/firmware/psci.c
+++ b/drivers/firmware/psci.c
@@ -91,7 +91,7 @@ static inline bool psci_has_ext_power_state(void)
 				PSCI_1_0_FEATURES_CPU_SUSPEND_PF_MASK;
 }
 
-bool psci_power_state_loses_context(u32 state)
+static bool psci_power_state_loses_context(u32 state)
 {
 	const u32 mask = psci_has_ext_power_state() ?
 					PSCI_1_0_EXT_POWER_STATE_TYPE_MASK :
@@ -100,7 +100,7 @@ bool psci_power_state_loses_context(u32 state)
 	return state & mask;
 }
 
-bool psci_power_state_is_valid(u32 state)
+static bool psci_power_state_is_valid(u32 state)
 {
 	const u32 valid_mask = psci_has_ext_power_state() ?
 			       PSCI_1_0_EXT_POWER_STATE_MASK :
diff --git a/include/linux/psci.h b/include/linux/psci.h
index 393efe2..bdea1cb 100644
--- a/include/linux/psci.h
+++ b/include/linux/psci.h
@@ -21,8 +21,6 @@
 #define PSCI_POWER_STATE_TYPE_POWER_DOWN	1
 
 bool psci_tos_resident_on(int cpu);
-bool psci_power_state_loses_context(u32 state);
-bool psci_power_state_is_valid(u32 state);
 
 int psci_cpu_init_idle(unsigned int cpu);
 int psci_cpu_suspend_enter(unsigned long index);
-- 
2.8.0.rc3
