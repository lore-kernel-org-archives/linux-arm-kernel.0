From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Thu, 16 Aug 2012 16:41:05 +0300
Subject: [PATCH v3 6/9] ASoC: omap-mcbsp: Remove unused defines
In-Reply-To: <1345124468-8876-1-git-send-email-peter.ujfalusi@ti.com>
References: <1345124468-8876-1-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <1345124468-8876-7-git-send-email-peter.ujfalusi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

NUM_LINKS is no longer in use by the code.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Acked-by: Jarkko Nikula <jarkko.nikula@bitmer.com>
---
 sound/soc/omap/omap-mcbsp.h |   16 ----------------
 1 files changed, 0 insertions(+), 16 deletions(-)

diff --git a/sound/soc/omap/omap-mcbsp.h b/sound/soc/omap/omap-mcbsp.h
index baebcee..ba8386a 100644
--- a/sound/soc/omap/omap-mcbsp.h
+++ b/sound/soc/omap/omap-mcbsp.h
@@ -39,22 +39,6 @@ enum omap_mcbsp_div {
 	OMAP_MCBSP_CLKGDV,		/* Sample rate generator divider */
 };
 
-#if defined(CONFIG_SOC_OMAP2420)
-#define NUM_LINKS	2
-#endif
-#if defined(CONFIG_ARCH_OMAP15XX) || defined(CONFIG_ARCH_OMAP16XX)
-#undef  NUM_LINKS
-#define NUM_LINKS	3
-#endif
-#if defined(CONFIG_ARCH_OMAP4)
-#undef  NUM_LINKS
-#define NUM_LINKS	4
-#endif
-#if defined(CONFIG_ARCH_OMAP3) || defined(CONFIG_SOC_OMAP2430)
-#undef  NUM_LINKS
-#define NUM_LINKS	5
-#endif
-
 int omap_mcbsp_st_add_controls(struct snd_soc_pcm_runtime *rtd);
 
 #endif
-- 
1.7.8.6
