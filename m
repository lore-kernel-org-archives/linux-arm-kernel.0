From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Thu, 23 Aug 2012 09:35:01 +0300
Subject: [PATCH] ARM: OMAP2+: twl-common: Fix compile time error when
 omap-twl4030 audio is not enabled
Message-ID: <1345703701-27283-1-git-send-email-peter.ujfalusi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fixes:
CC      arch/arm/mach-omap2/twl-common.o arch/arm/mach-omap2/twl-common.c:562: error: conflicting types for ?omap_twl4030_audio_init?
arch/arm/mach-omap2/twl-common.h:62: error: previous declaration of ?omap_twl4030_audio_init? was here
make[1]: *** [arch/arm/mach-omap2/twl-common.o] Error 1
make: *** [arch/arm/mach-omap2] Error 2

When building the kernel with !SND_OMAP_SOC_OMAP_TWL4030

Reported-by: Brian Austin <brian.austin@cirrus.com>
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 arch/arm/mach-omap2/twl-common.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/twl-common.c b/arch/arm/mach-omap2/twl-common.c
index 1c6045a..2919d7a 100644
--- a/arch/arm/mach-omap2/twl-common.c
+++ b/arch/arm/mach-omap2/twl-common.c
@@ -544,7 +544,7 @@ void __init omap_twl4030_audio_init(char *card_name)
 }
 
 #else /* SOC_OMAP_TWL4030 */
-void __init omap_twl4030_audio_init(char *card_name, int codec_sysclk)
+void __init omap_twl4030_audio_init(char *card_name)
 {
 	return;
 }
-- 
1.7.8.6
