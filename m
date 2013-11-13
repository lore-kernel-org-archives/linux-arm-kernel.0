From: magnus.damm@gmail.com (Magnus Damm)
Date: Thu, 14 Nov 2013 07:34:06 +0900
Subject: [PATCH] ARM: shmobile: Use ->init_late() on Lager
Message-ID: <20131113223406.20634.52693.sendpatchset@w520>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Hook in shmobile_init_late() on Lager. This enables some PM
related things like CPUIdle and Suspend-to-RAM.

With this patch applied it is possible to use Suspend-to-RAM:
# echo enabled > /sys/class/tty/ttySC6/power/wakeup
# echo mem > /sys/power/state 
(wake by sending a character on the serial console)

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-shmobile/board-lager-reference.c |    1 +
 arch/arm/mach-shmobile/board-lager.c           |    1 +
 2 files changed, 2 insertions(+)

--- 0001/arch/arm/mach-shmobile/board-lager-reference.c
+++ work/arch/arm/mach-shmobile/board-lager-reference.c	2013-11-13 16:55:46.000000000 +0900
@@ -41,5 +41,6 @@ DT_MACHINE_START(LAGER_DT, "lager")
 	.init_early	= r8a7790_init_early,
 	.init_time	= rcar_gen2_timer_init,
 	.init_machine	= lager_add_standard_devices,
+	.init_late	= shmobile_init_late,
 	.dt_compat	= lager_boards_compat_dt,
 MACHINE_END
--- 0001/arch/arm/mach-shmobile/board-lager.c
+++ work/arch/arm/mach-shmobile/board-lager.c	2013-11-13 16:55:38.000000000 +0900
@@ -259,5 +259,6 @@ DT_MACHINE_START(LAGER_DT, "lager")
 	.init_early	= r8a7790_init_early,
 	.init_time	= rcar_gen2_timer_init,
 	.init_machine	= lager_init,
+	.init_late	= shmobile_init_late,
 	.dt_compat	= lager_boards_compat_dt,
 MACHINE_END
