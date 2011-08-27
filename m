From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Sat, 27 Aug 2011 22:17:20 +0530
Subject: [PATCH] ARM: vfp: Fix the comment to make it consistent with the code.
Message-ID: <1314463640-17346-1-git-send-email-santosh.shilimkar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Function vfp_force_reload() clears vfp_current_hw_state, so
update the comment accordingly.

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
cc: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/vfp/vfpmodule.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/vfp/vfpmodule.c b/arch/arm/vfp/vfpmodule.c
index fe4b60b..0cbd5a0 100644
--- a/arch/arm/vfp/vfpmodule.c
+++ b/arch/arm/vfp/vfpmodule.c
@@ -69,7 +69,7 @@ static bool vfp_state_in_hw(unsigned int cpu, struct thread_info *thread)
 /*
  * Force a reload of the VFP context from the thread structure.  We do
  * this by ensuring that access to the VFP hardware is disabled, and
- * clear last_VFP_context.  Must be called from non-preemptible context.
+ * clear vfp_current_hw_state.  Must be called from non-preemptible context.
  */
 static void vfp_force_reload(unsigned int cpu, struct thread_info *thread)
 {
-- 
1.7.4.1
