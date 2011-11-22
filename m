From: boojin.kim@samsung.com (Boojin Kim)
Date: Tue, 22 Nov 2011 11:03:22 +0900
Subject: [PATCH] ASoC: SAMSUNG: Fix build error
Message-ID: <1321927402-28898-1-git-send-email-boojin.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds <linux/modules.h> to fix following build errors.

sound/soc/codecs/wm8994.c: In function 'wm8994_readable':
sound/soc/codecs/wm8994.c:58: warning: unused variable 'wm8994'
sound/soc/samsung/smdk_wm8994.c:176: error: expected declaration specifiers or '...' before string constant
sound/soc/samsung/smdk_wm8994.c:176: warning: data definition has no type or storage class
sound/soc/samsung/smdk_wm8994.c:176: warning: type defaults to 'int' in declaration of 'MODULE_DESCRIPTION'
sound/soc/samsung/smdk_wm8994.c:176: warning: function declaration isn't a prototype
sound/soc/samsung/smdk_wm8994.c:177: error: expected declaration specifiers or '...' before string constant

Signed-off-by: Boojin Kim <boojin.kim@samsung.com>
---
 sound/soc/samsung/smdk_wm8994.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/sound/soc/samsung/smdk_wm8994.c b/sound/soc/samsung/smdk_wm8994.c
index f75e439..ad9ac42 100644
--- a/sound/soc/samsung/smdk_wm8994.c
+++ b/sound/soc/samsung/smdk_wm8994.c
@@ -9,6 +9,7 @@
 
 #include "../codecs/wm8994.h"
 #include <sound/pcm_params.h>
+#include <linux/module.h>
 
  /*
   * Default CFG switch settings to use this driver:
-- 
1.7.1
