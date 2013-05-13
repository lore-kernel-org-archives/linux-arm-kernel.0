From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 13 May 2013 11:44:02 +0200
Subject: [PATCH 03/14] ARM: nomadik: Remove init_irq declaration in machine
 description
In-Reply-To: <1368438253-28218-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1368438253-28218-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1368438253-28218-4-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit ebafed7a ("ARM: irq: Call irqchip_init if no init_irq function is
specified") removed the need to explictly setup the init_irq field in
the machine description when using only irqchip_init. Remove that
declaration for nomadik as well.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/mach-nomadik/cpu-8815.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/mach-nomadik/cpu-8815.c b/arch/arm/mach-nomadik/cpu-8815.c
index 59f6ff5..3d43f95 100644
--- a/arch/arm/mach-nomadik/cpu-8815.c
+++ b/arch/arm/mach-nomadik/cpu-8815.c
@@ -323,7 +323,6 @@ static const char * cpu8815_board_compat[] = {
 
 DT_MACHINE_START(NOMADIK_DT, "Nomadik STn8815")
 	.map_io		= cpu8815_map_io,
-	.init_irq	= irqchip_init,
 	.init_time	= cpu8815_timer_init_of,
 	.init_machine	= cpu8815_init_of,
 	.restart	= cpu8815_restart,
-- 
1.8.1.2
