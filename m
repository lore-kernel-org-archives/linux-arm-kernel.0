From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 03 Jul 2014 16:08:30 +0200
Subject: ARM: shmobile: fix shmobile_smp_apmu_suspend_init build failure for
 !SUSPEND
Message-ID: <4396372.pxzjeyg4CZ@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Patch d6d757c9a4e ("ARM: shmobile: APMU: Add Core-Standby-state for
Suspend to RAM") added both an inline wrapper for shmobile_smp_apmu_suspend_init
and an empty function in arch/arm/mach-shmobile/platsmp-apmu.c. We get a
build failure when both are present, so this patch removes the one in the .c
file and keeps the inline version.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>

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
