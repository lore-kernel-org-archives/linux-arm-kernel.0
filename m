From: magnus.damm@gmail.com (Magnus Damm)
Date: Mon, 08 Apr 2013 10:23:37 +0900
Subject: [PATCH 02/02] ARM: shmobile: use r8a7790 timer setup code on Lager
In-Reply-To: <20130408012318.13555.58237.sendpatchset@w520>
References: <20130408012318.13555.58237.sendpatchset@w520>
Message-ID: <20130408012337.13555.70590.sendpatchset@w520>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Use the r8a7790 timer init function on Lager
to make sure the architected timer is started
regardless of boot loader setting.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-shmobile/board-lager.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- 0001/arch/arm/mach-shmobile/board-lager.c
+++ work/arch/arm/mach-shmobile/board-lager.c	2013-04-08 10:15:49.000000000 +0900
@@ -40,7 +40,7 @@ static const char *lager_boards_compat_d
 
 DT_MACHINE_START(LAGER_DT, "lager")
 	.init_irq	= irqchip_init,
-	.init_time	= shmobile_timer_init,
+	.init_time	= r8a7790_timer_init,
 	.init_machine	= lager_add_standard_devices,
 	.dt_compat	= lager_boards_compat_dt,
 MACHINE_END
