From: rnayak@ti.com (Rajendra Nayak)
Date: Fri, 18 Jan 2013 17:53:50 +0530
Subject: [PATCH] ARM: arch_timer: Don't expect both secure and nonsecure PPI
 IRQ info
Message-ID: <1358511830-7909-1-git-send-email-rnayak@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The current logic expects platforms to pass information about *both*
secure and nonsecure PPI IRQ. Make arch_timer work even when either one
of those are provided instead.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
---
 arch/arm/kernel/arch_timer.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/kernel/arch_timer.c b/arch/arm/kernel/arch_timer.c
index c8ef207..59e1e26 100644
--- a/arch/arm/kernel/arch_timer.c
+++ b/arch/arm/kernel/arch_timer.c
@@ -495,7 +495,7 @@ int __init arch_timer_of_register(void)
 	if (!arch_timer_ppi[VIRT_PPI]) {
 		arch_timer_use_virtual = false;
 
-		if (!arch_timer_ppi[PHYS_SECURE_PPI] ||
+		if (!arch_timer_ppi[PHYS_SECURE_PPI] &&
 		    !arch_timer_ppi[PHYS_NONSECURE_PPI]) {
 			pr_warn("arch_timer: No interrupt available, giving up\n");
 			return -EINVAL;
-- 
1.7.9.5
