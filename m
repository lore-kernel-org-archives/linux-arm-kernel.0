From: paul.gortmaker@windriver.com (Paul Gortmaker)
Date: Sun, 22 Jan 2012 15:26:30 -0500
Subject: [PATCH] arm: fix build failure in mach-bcmring/arch.c
Message-ID: <1327263990-8769-1-git-send-email-paul.gortmaker@windriver.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Upstream commit d1fce9c115eeb93e01c01732dfe9a86cf76009cf

    "ARM: restart: bcmring: use new restart hook"

breaks building of this platform, since what used to be the
last field of the MACHINE_START/END block didn't have a
trailing comma.  Once another field was added below, we get:

arch/arm/mach-bcmring/arch.c:198: error: request for member 'restart' in something not a structure or union

Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>

diff --git a/arch/arm/mach-bcmring/arch.c b/arch/arm/mach-bcmring/arch.c
index 9e5e755..45c97b1 100644
--- a/arch/arm/mach-bcmring/arch.c
+++ b/arch/arm/mach-bcmring/arch.c
@@ -194,6 +194,6 @@ MACHINE_START(BCMRING, "BCMRING")
 	.init_early = bcmring_init_early,
 	.init_irq = bcmring_init_irq,
 	.timer = &bcmring_timer,
-	.init_machine = bcmring_init_machine
+	.init_machine = bcmring_init_machine,
 	.restart = bcmring_restart,
 MACHINE_END
-- 
1.7.7.2
