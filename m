From: jonathan.austin@arm.com (Jonathan Austin)
Date: Thu, 29 Aug 2013 18:41:11 +0100
Subject: [PATCH 1/2] ARM: integrator_cp: Set LCD{0,
 1} enable lines when turning on CLCD
Message-ID: <1377798071-26790-1-git-send-email-jonathan.austin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This turns on the internal integrator LCD display(s). It seems that the code
to do this got lost in refactoring of the CLCD driver.

Signed-off-by: Jonathan Austin <jonathan.austin@arm.com>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
Cc: stable at vger.kernel.org

---
...resending this patch to arm at kernel.org as suggested by Linus W with this Ack

 arch/arm/mach-integrator/integrator_cp.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-integrator/integrator_cp.c b/arch/arm/mach-integrator/integrator_cp.c
index 8c60fcb..2f4c9248 100644
--- a/arch/arm/mach-integrator/integrator_cp.c
+++ b/arch/arm/mach-integrator/integrator_cp.c
@@ -199,7 +199,8 @@ static struct mmci_platform_data mmc_data = {
 static void cp_clcd_enable(struct clcd_fb *fb)
 {
 	struct fb_var_screeninfo *var = &fb->fb.var;
-	u32 val = CM_CTRL_STATIC1 | CM_CTRL_STATIC2;
+	u32 val = CM_CTRL_STATIC1 | CM_CTRL_STATIC2
+			| CM_CTRL_LCDEN0 | CM_CTRL_LCDEN1;
 
 	if (var->bits_per_pixel <= 8 ||
 	    (var->bits_per_pixel == 16 && var->green.length == 5))
-- 
1.7.9.5
