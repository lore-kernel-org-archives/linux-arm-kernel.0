From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Sat, 19 Nov 2016 16:48:27 +0200
Subject: [PATCH 2/6] ASoC: samsung: smdk_wm8580: Remove old platforms and drop
 mach-types usage
In-Reply-To: <1479566911-5580-1-git-send-email-krzk@kernel.org>
References: <1479566911-5580-1-git-send-email-krzk@kernel.org>
Message-ID: <1479566911-5580-3-git-send-email-krzk@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

MACH_SMDKC100, MACH_SMDKV210 and MACH_SMDKC110 are no longer supported
so drop the dead code.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 sound/soc/samsung/smdk_wm8580.c | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/sound/soc/samsung/smdk_wm8580.c b/sound/soc/samsung/smdk_wm8580.c
index 548bfd993788..59fd3b8fd414 100644
--- a/sound/soc/samsung/smdk_wm8580.c
+++ b/sound/soc/samsung/smdk_wm8580.c
@@ -14,8 +14,6 @@
 #include <sound/soc.h>
 #include <sound/pcm_params.h>
 
-#include <asm/mach-types.h>
-
 #include "../codecs/wm8580.h"
 #include "i2s.h"
 
@@ -206,15 +204,10 @@ static int __init smdk_audio_init(void)
 	int ret;
 	char *str;
 
-	if (machine_is_smdkc100()
-			|| machine_is_smdkv210() || machine_is_smdkc110()) {
-		smdk.num_links = 3;
-	} else if (machine_is_smdk6410()) {
-		str = (char *)smdk_dai[PRI_PLAYBACK].cpu_dai_name;
-		str[strlen(str) - 1] = '2';
-		str = (char *)smdk_dai[PRI_CAPTURE].cpu_dai_name;
-		str[strlen(str) - 1] = '2';
-	}
+	str = (char *)smdk_dai[PRI_PLAYBACK].cpu_dai_name;
+	str[strlen(str) - 1] = '2';
+	str = (char *)smdk_dai[PRI_CAPTURE].cpu_dai_name;
+	str[strlen(str) - 1] = '2';
 
 	smdk_snd_device = platform_device_alloc("soc-audio", -1);
 	if (!smdk_snd_device)
-- 
2.7.4
