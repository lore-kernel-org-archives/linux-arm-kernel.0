From: santosh.shilimkar@ti.com (Shilimkar, Santosh)
Date: Tue, 9 Nov 2010 18:40:39 +0530
Subject: [PATCH] ARM: Temporary fix for broken arch reboot  
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB030D4FAB9E@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With commit 3d3f78d752bf, reboot seems to broken on ARM
machines. CPU dies while doing flush_pmd_entry() as part of
setup_mm_for_reboot()

I know this is not the fix but intention is to report the
issue and also provide temporary fix till it get fixed correctly

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Reported-by: Anand Gadiyar <gadiyar@ti.com>
---
Tested with OMAP4 device.

 arch/arm/kernel/process.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/arch/arm/kernel/process.c b/arch/arm/kernel/process.c
index e76fcaa..ac370b2 100644
--- a/arch/arm/kernel/process.c
+++ b/arch/arm/kernel/process.c
@@ -247,7 +247,6 @@ void machine_power_off(void)
 
 void machine_restart(char *cmd)
 {
-	machine_shutdown();
 	arm_pm_restart(reboot_mode, cmd);
 }
 
-- 
1.6.0.4
