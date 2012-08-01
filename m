From: b29396@freescale.com (Dong Aisheng)
Date: Wed, 1 Aug 2012 11:20:16 +0800
Subject: [PATCH v2 1/1] ARM: mx28evk: add missed clkmux select for saif
Message-ID: <1343791216-22515-1-git-send-email-b29396@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Dong Aisheng <dong.aisheng@linaro.org>

Added missed clkmux setting for mx28evk.

Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Liam Girdwood <lrg@ti.com>
Cc: Wolfram Sang <w.sang@pengutronix.de>
Cc: Shawn Guo <shawn.guo@linaro.org>
Signed-off-by: Dong Aisheng <dong.aisheng@linaro.org>
---
ChangeLog v1->v2:
* rebased on 3.6-rc1
---
 arch/arm/mach-mxs/mach-mxs.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-mxs/mach-mxs.c b/arch/arm/mach-mxs/mach-mxs.c
index 8dabfe8..02d1ab2 100644
--- a/arch/arm/mach-mxs/mach-mxs.c
+++ b/arch/arm/mach-mxs/mach-mxs.c
@@ -24,6 +24,7 @@
 #include <asm/mach/arch.h>
 #include <asm/mach/time.h>
 #include <mach/common.h>
+#include <mach/digctl.h>
 
 static struct fb_videomode mx23evk_video_modes[] = {
 	{
@@ -237,6 +238,8 @@ static void __init imx28_evk_init(void)
 	mxsfb_pdata.mode_count = ARRAY_SIZE(mx28evk_video_modes);
 	mxsfb_pdata.default_bpp = 32;
 	mxsfb_pdata.ld_intf_width = STMLCDIF_24BIT;
+
+	mxs_saif_clkmux_select(MXS_DIGCTL_SAIF_CLKMUX_EXTMSTR0);
 }
 
 static void __init m28evk_init(void)
-- 
1.7.0.4
