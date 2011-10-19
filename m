From: grinberg@compulab.co.il (Igor Grinberg)
Date: Wed, 19 Oct 2011 11:39:19 +0200
Subject: [PATCH 3/4] ARM: OMAP3: cm-t35: fix audio
In-Reply-To: <1319017160-20391-1-git-send-email-grinberg@compulab.co.il>
References: <1319017160-20391-1-git-send-email-grinberg@compulab.co.il>
Message-ID: <1319017160-20391-4-git-send-email-grinberg@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

TWL4030 audio codec is not being registered if no platform data is
supplied. Plovide platform data for the TWL4030 audio codec.

Signed-off-by: Igor Grinberg <grinberg@compulab.co.il>
---
 arch/arm/mach-omap2/board-cm-t35.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/board-cm-t35.c b/arch/arm/mach-omap2/board-cm-t35.c
index 1ee056f5..18cd50c 100644
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
