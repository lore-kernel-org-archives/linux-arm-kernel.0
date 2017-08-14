From: bhumirks@gmail.com (Bhumika Goyal)
Date: Mon, 14 Aug 2017 17:08:48 +0530
Subject: [PATCH 09/11] ASoC: sh: make snd_soc_platform_driver const
In-Reply-To: <1502710730-18912-1-git-send-email-bhumirks@gmail.com>
References: <1502710730-18912-1-git-send-email-bhumirks@gmail.com>
Message-ID: <1502710730-18912-10-git-send-email-bhumirks@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Make these const as they are either passed as the 2nd argument to
the function devm_snd_soc_register_platform or snd_soc_register_platform,
and the arguments are of type const.
Done using Coccinelle.

Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>
---
 sound/soc/sh/dma-sh7760.c | 2 +-
 sound/soc/sh/fsi.c        | 2 +-
 sound/soc/sh/rcar/core.c  | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/sh/dma-sh7760.c b/sound/soc/sh/dma-sh7760.c
index 8fad444..81c7433 100644
--- a/sound/soc/sh/dma-sh7760.c
+++ b/sound/soc/sh/dma-sh7760.c
@@ -320,7 +320,7 @@ static int camelot_pcm_new(struct snd_soc_pcm_runtime *rtd)
 	return 0;
 }
 
-static struct snd_soc_platform_driver sh7760_soc_platform = {
+static const struct snd_soc_platform_driver sh7760_soc_platform = {
 	.ops		= &camelot_pcm_ops,
 	.pcm_new	= camelot_pcm_new,
 };
diff --git a/sound/soc/sh/fsi.c b/sound/soc/sh/fsi.c
index 005b215..60bb23f 100644
--- a/sound/soc/sh/fsi.c
+++ b/sound/soc/sh/fsi.c
@@ -1818,7 +1818,7 @@ static int fsi_pcm_new(struct snd_soc_pcm_runtime *rtd)
 	},
 };
 
-static struct snd_soc_platform_driver fsi_soc_platform = {
+static const struct snd_soc_platform_driver fsi_soc_platform = {
 	.ops		= &fsi_pcm_ops,
 	.pcm_new	= fsi_pcm_new,
 };
diff --git a/sound/soc/sh/rcar/core.c b/sound/soc/sh/rcar/core.c
index 650cc28..361afc0 100644
--- a/sound/soc/sh/rcar/core.c
+++ b/sound/soc/sh/rcar/core.c
@@ -1318,7 +1318,7 @@ static int rsnd_pcm_new(struct snd_soc_pcm_runtime *rtd)
 		PREALLOC_BUFFER, PREALLOC_BUFFER_MAX);
 }
 
-static struct snd_soc_platform_driver rsnd_soc_platform = {
+static const struct snd_soc_platform_driver rsnd_soc_platform = {
 	.ops		= &rsnd_pcm_ops,
 	.pcm_new	= rsnd_pcm_new,
 };
-- 
1.9.1
