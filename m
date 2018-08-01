From: colin.king@canonical.com (Colin King)
Date: Wed,  1 Aug 2018 11:47:36 +0100
Subject: [PATCH 3/9] ALSA: emu10k1: remove redundant variable attn
In-Reply-To: <20180801104742.4328-1-colin.king@canonical.com>
References: <20180801104742.4328-1-colin.king@canonical.com>
Message-ID: <20180801104742.4328-4-colin.king@canonical.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Colin Ian King <colin.king@canonical.com>

Variable attn is being assigned but is never used hence it is
redundant and can be removed.

Cleans up clang warning:
warning: variable 'attn' set but not used [-Wunused-but-set-variable]

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 sound/pci/emu10k1/emupcm.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/pci/emu10k1/emupcm.c b/sound/pci/emu10k1/emupcm.c
index 69f9b100bd24..26f6eda3e766 100644
--- a/sound/pci/emu10k1/emupcm.c
+++ b/sound/pci/emu10k1/emupcm.c
@@ -290,7 +290,7 @@ static void snd_emu10k1_pcm_init_voice(struct snd_emu10k1 *emu,
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	unsigned int silent_page, tmp;
 	int voice, stereo, w_16;
-	unsigned char attn, send_amount[8];
+	unsigned char send_amount[8];
 	unsigned char send_routing[8];
 	unsigned long flags;
 	unsigned int pitch_target;
@@ -313,7 +313,6 @@ static void snd_emu10k1_pcm_init_voice(struct snd_emu10k1 *emu,
 
 	/* volume parameters */
 	if (extra) {
-		attn = 0;
 		memset(send_routing, 0, sizeof(send_routing));
 		send_routing[0] = 0;
 		send_routing[1] = 1;
-- 
2.17.1
