From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue,  1 Jul 2014 09:28:44 +0900
Subject: [PATCH 4/8] ARM: shmobile: Use __init for APMU suspend init function
In-Reply-To: <cover.1404174157.git.horms+renesas@verge.net.au>
References: <cover.1404174157.git.horms+renesas@verge.net.au>
Message-ID: <0d77c9aa7a13a9fcfc93836188474f43394ea657.1404174157.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm+renesas@opensource.se>

The function shmobile_smp_apmu_suspend_init() should
be put into the init section to not trigger section
mismatch warnings.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/platsmp-apmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-shmobile/platsmp-apmu.c b/arch/arm/mach-shmobile/platsmp-apmu.c
index ce07eb9..a05b16d 100644
--- a/arch/arm/mach-shmobile/platsmp-apmu.c
+++ b/arch/arm/mach-shmobile/platsmp-apmu.c
@@ -240,7 +240,7 @@ static int shmobile_smp_apmu_enter_suspend(suspend_state_t state)
 	return 0;
 }
 
-void shmobile_smp_apmu_suspend_init(void)
+void __init shmobile_smp_apmu_suspend_init(void)
 {
 	shmobile_suspend_ops.enter = shmobile_smp_apmu_enter_suspend;
 }
-- 
2.0.0.rc2
