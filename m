From: haojian.zhuang@marvell.com (Haojian Zhuang)
Date: Fri, 13 Aug 2010 21:14:52 +0800
Subject: [PATCH 2/5] ASoC: fix pxa2xx-pcm.h path
Message-ID: <mailman.168.1281707730.27306.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since pxa2xx-pcm.h is removed from sound/soc/pxa, we need to update the
path in related files.

Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
---
 sound/soc/pxa/pxa-ssp.c    |    2 +-
 sound/soc/pxa/pxa2xx-pcm.c |    1 -
 2 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/sound/soc/pxa/pxa-ssp.c b/sound/soc/pxa/pxa-ssp.c
index 99d80e8..c4f480d 100644
--- a/sound/soc/pxa/pxa-ssp.c
+++ b/sound/soc/pxa/pxa-ssp.c
@@ -35,7 +35,7 @@
 #include <mach/audio.h>
 #include <plat/ssp.h>

-#include "pxa2xx-pcm.h"
+#include "../../arm/pxa2xx-pcm.h"
 #include "pxa-ssp.h"

 /*
diff --git a/sound/soc/pxa/pxa2xx-pcm.c b/sound/soc/pxa/pxa2xx-pcm.c
index 5127044..02fb664 100644
--- a/sound/soc/pxa/pxa2xx-pcm.c
+++ b/sound/soc/pxa/pxa2xx-pcm.c
@@ -16,7 +16,6 @@
 #include <sound/soc.h>
 #include <sound/pxa2xx-lib.h>

-#include "pxa2xx-pcm.h"
 #include "../../arm/pxa2xx-pcm.h"

 static int pxa2xx_pcm_hw_params(struct snd_pcm_substream *substream,
-- 
1.5.6.5
