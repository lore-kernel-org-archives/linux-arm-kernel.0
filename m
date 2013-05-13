From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 13 May 2013 12:16:08 +0200
Subject: [PATCH 3/4] ARM: mxs: remove the .map_io declaration
In-Reply-To: <1368440169-29088-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1368440169-29088-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1368440169-29088-4-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that the ARM core code calls debug_ll_io_init, we can remove it from
the machine_desc declaration.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/mach-mxs/mach-mxs.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/mach-mxs/mach-mxs.c b/arch/arm/mach-mxs/mach-mxs.c
index 5b62b64..d67ecc1 100644
--- a/arch/arm/mach-mxs/mach-mxs.c
+++ b/arch/arm/mach-mxs/mach-mxs.c
@@ -434,7 +434,6 @@ static const char *mxs_dt_compat[] __initdata = {
 };
 
 DT_MACHINE_START(MXS, "Freescale MXS (Device Tree)")
-	.map_io		= debug_ll_io_init,
 	.init_irq	= irqchip_init,
 	.handle_irq	= icoll_handle_irq,
 	.init_time	= mxs_timer_init,
-- 
1.8.1.2
