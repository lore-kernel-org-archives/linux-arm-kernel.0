From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Fri,  1 Jul 2011 12:43:54 +0200
Subject: [PATCH] ASoC: wm8731: set the ACTIVE bit if bias ON entered
In-Reply-To: <ccd4b125244271af7978948689cf1dcef37bc06b.1309368631.git.nicolas.ferre@atmel.com>
References: <ccd4b125244271af7978948689cf1dcef37bc06b.1309368631.git.nicolas.ferre@atmel.com>
Message-ID: <1309517034-26110-1-git-send-email-nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Resuming from a suspend/resume cycle, the ACTIVE bit was not set even if a
stream had actually been processing.
Setting this bit at entering SND_SOC_BIAS_ON level will ensure this.

Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
Supersed the wrong patch:
"[PATCH 1/5] ASoC: wm8731: rework power management"

now based on broonie/sound-2.6 git tree branch: for-3.1.

 sound/soc/codecs/wm8731.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/sound/soc/codecs/wm8731.c b/sound/soc/codecs/wm8731.c
index 2dc964b..ee4ec31 100644
--- a/sound/soc/codecs/wm8731.c
+++ b/sound/soc/codecs/wm8731.c
@@ -453,6 +453,7 @@ static int wm8731_set_bias_level(struct snd_soc_codec *codec,
 
 	switch (level) {
 	case SND_SOC_BIAS_ON:
+		snd_soc_write(codec, WM8731_ACTIVE, 0x0001);
 		break;
 	case SND_SOC_BIAS_PREPARE:
 		break;
-- 
1.7.3
