From: grinberg@compulab.co.il (Igor Grinberg)
Date: Sun,  6 Nov 2011 16:16:25 +0200
Subject: [PATCH v2 3/4] ARM: OMAP3: cm-t35: fix audio
In-Reply-To: <1320588827-9407-1-git-send-email-grinberg@compulab.co.il>
References: <1320588827-9407-1-git-send-email-grinberg@compulab.co.il>
Message-ID: <1320588986-9480-3-git-send-email-grinberg@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

TWL4030 audio codec is not being registered if no platform data is
supplied. Provide platform data for the TWL4030 audio codec.

Signed-off-by: Igor Grinberg <grinberg@compulab.co.il>
---
v2: - Rebase on top of fixes branch
    - fix the commit message (10x to Sergei)

 arch/arm/mach-omap2/board-cm-t35.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/board-cm-t35.c b/arch/arm/mach-omap2/board-cm-t35.c
index 724a23c..7b71fe1 100644
--- a/arch/arm/mach-omap2/board-cm-t35.c
+++ b/arch/arm/mach-omap2/board-cm-t35.c
@@ -477,7 +477,8 @@ static struct twl4030_platform_data cm_t35_twldata = {
 static void __init cm_t35_init_i2c(void)
 {
 	omap3_pmic_get_config(&cm_t35_twldata, TWL_COMMON_PDATA_USB,
-			TWL_COMMON_REGULATOR_VDAC);
+			      TWL_COMMON_REGULATOR_VDAC |
+			      TWL_COMMON_PDATA_AUDIO);
 
 	omap3_pmic_init("tps65930", &cm_t35_twldata);
 }
-- 
1.7.3.4
