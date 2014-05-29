From: robherring2@gmail.com (Rob Herring)
Date: Thu, 29 May 2014 17:40:15 -0500
Subject: [PATCH v2 05/11] ARM: versatile: remove init_irq hook for DT boot
In-Reply-To: <1401403221-27523-1-git-send-email-robherring2@gmail.com>
References: <1401403221-27523-1-git-send-email-robherring2@gmail.com>
Message-ID: <1401403221-27523-6-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <robh@kernel.org>

Now that versatile's irqchips are initialized from DT, the init_irq hook
can be removed.

Signed-off-by: Rob Herring <robh@kernel.org>
Acked-by: Arnd Bergmann <arnd@arndb.de>
---
v2:
- no change
 arch/arm/mach-versatile/versatile_dt.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/mach-versatile/versatile_dt.c b/arch/arm/mach-versatile/versatile_dt.c
index 3621b00..9f9bc61 100644
--- a/arch/arm/mach-versatile/versatile_dt.c
+++ b/arch/arm/mach-versatile/versatile_dt.c
@@ -44,7 +44,6 @@ static const char *versatile_dt_match[] __initconst = {
 DT_MACHINE_START(VERSATILE_PB, "ARM-Versatile (Device Tree Support)")
 	.map_io		= versatile_map_io,
 	.init_early	= versatile_init_early,
-	.init_irq	= versatile_init_irq,
 	.init_machine	= versatile_dt_init,
 	.dt_compat	= versatile_dt_match,
 	.restart	= versatile_restart,
-- 
1.9.1
