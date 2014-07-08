From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue,  8 Jul 2014 11:34:16 +0200
Subject: [PATCH] ARM: shmobile: fix shmobile_smp_apmu_suspend_init build
 failure for !SUSPEND
In-Reply-To: <cover.1404811926.git.horms+renesas@verge.net.au>
References: <cover.1404811926.git.horms+renesas@verge.net.au>
Message-ID: <d358c99838f3cf63ad7536124be4318cc84b11fa.1404811926.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Arnd Bergmann <arnd@arndb.de>

Patch d6d757c9a4e ("ARM: shmobile: APMU: Add Core-Standby-state for
Suspend to RAM") added both an inline wrapper for shmobile_smp_apmu_suspend_init
and an empty function in arch/arm/mach-shmobile/platsmp-apmu.c. We get a
build failure when both are present, so this patch removes the one in the .c
file and keeps the inline version.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/platsmp-apmu.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm/mach-shmobile/platsmp-apmu.c b/arch/arm/mach-shmobile/platsmp-apmu.c
index a05b16d..2c06810 100644
--- a/arch/arm/mach-shmobile/platsmp-apmu.c
+++ b/arch/arm/mach-shmobile/platsmp-apmu.c
@@ -244,6 +244,4 @@ void __init shmobile_smp_apmu_suspend_init(void)
 {
 	shmobile_suspend_ops.enter = shmobile_smp_apmu_enter_suspend;
 }
-#else
-void shmobile_smp_apmu_suspend_init(void) {}
 #endif
-- 
2.0.0.rc2
