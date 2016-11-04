From: Nicolae_Rosia@mentor.com (Nicolae Rosia)
Date: Fri, 4 Nov 2016 16:02:17 +0200
Subject: [PATCH v2 4/5] ARM: OMAP2: kill omap2_pmic_init
In-Reply-To: <1478268138-7044-1-git-send-email-Nicolae_Rosia@mentor.com>
References: <1478000206-10855-1-git-send-email-Nicolae_Rosia@mentor.com>
 <1478268138-7044-1-git-send-email-Nicolae_Rosia@mentor.com>
Message-ID: <1478268138-7044-5-git-send-email-Nicolae_Rosia@mentor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Last call of function was removed with commit
bfd46a ("ARM: OMAP: Fix i2c init for twl4030")

Signed-off-by: Nicolae Rosia <Nicolae_Rosia@mentor.com>
---
 arch/arm/mach-omap2/twl-common.h | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/arch/arm/mach-omap2/twl-common.h b/arch/arm/mach-omap2/twl-common.h
index 397722d..5579bd6 100644
--- a/arch/arm/mach-omap2/twl-common.h
+++ b/arch/arm/mach-omap2/twl-common.h
@@ -39,12 +39,6 @@ void omap_pmic_init(int bus, u32 clkrate, const char *pmic_type, int pmic_irq,
 		    struct twl4030_platform_data *pmic_data);
 void omap_pmic_late_init(void);
 
-static inline void omap2_pmic_init(const char *pmic_type,
-				   struct twl4030_platform_data *pmic_data)
-{
-	omap_pmic_init(2, 2600, pmic_type, 7 + OMAP_INTC_START, pmic_data);
-}
-
 void omap_twl4030_audio_init(char *card_name, struct omap_tw4030_pdata *pdata);
 
 #endif /* __OMAP_PMIC_COMMON__ */
-- 
2.5.5
