From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Fri, 14 Nov 2014 16:53:57 +0100
Subject: [PATCH 1/2] ARM: imx: Remove unneeded .map_io initialization
Message-ID: <1415980438-12939-1-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If machine_desc.map_io is not set, devicemaps_init() in the common ARM
code will call debug_ll_io_init().

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
Untested

 arch/arm/mach-imx/mach-imx6sl.c | 1 -
 arch/arm/mach-imx/mach-imx6sx.c | 1 -
 2 files changed, 2 deletions(-)

diff --git a/arch/arm/mach-imx/mach-imx6sl.c b/arch/arm/mach-imx/mach-imx6sl.c
index ed263a21d928da39..28ba204e611d1186 100644
--- a/arch/arm/mach-imx/mach-imx6sl.c
+++ b/arch/arm/mach-imx/mach-imx6sl.c
@@ -76,7 +76,6 @@ static const char * const imx6sl_dt_compat[] __initconst = {
 };
 
 DT_MACHINE_START(IMX6SL, "Freescale i.MX6 SoloLite (Device Tree)")
-	.map_io		= debug_ll_io_init,
 	.init_irq	= imx6sl_init_irq,
 	.init_machine	= imx6sl_init_machine,
 	.init_late      = imx6sl_init_late,
diff --git a/arch/arm/mach-imx/mach-imx6sx.c b/arch/arm/mach-imx/mach-imx6sx.c
index 3de3b7369aef10ca..54fd64b184c8b3e8 100644
--- a/arch/arm/mach-imx/mach-imx6sx.c
+++ b/arch/arm/mach-imx/mach-imx6sx.c
@@ -53,7 +53,6 @@ static const char * const imx6sx_dt_compat[] __initconst = {
 };
 
 DT_MACHINE_START(IMX6SX, "Freescale i.MX6 SoloX (Device Tree)")
-	.map_io		= debug_ll_io_init,
 	.init_irq	= imx6sx_init_irq,
 	.init_machine	= imx6sx_init_machine,
 	.dt_compat	= imx6sx_dt_compat,
-- 
1.9.1
