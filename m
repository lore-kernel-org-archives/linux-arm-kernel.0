From: colin.king@canonical.com (Colin King)
Date: Wed,  1 Aug 2018 11:47:38 +0100
Subject: [PATCH 5/9] ALSA: sonicvibes: remove redundant pointer 'dir'
In-Reply-To: <20180801104742.4328-1-colin.king@canonical.com>
References: <20180801104742.4328-1-colin.king@canonical.com>
Message-ID: <20180801104742.4328-6-colin.king@canonical.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Colin Ian King <colin.king@canonical.com>

Pointer 'dir' is being assigned but is never used hence it is
redundant and can be removed.

Cleans up clang warning:
warning: variable 'dir' set but not used [-Wunused-but-set-variable]

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 sound/pci/sonicvibes.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/sound/pci/sonicvibes.c b/sound/pci/sonicvibes.c
index 7fbdb703bfcd..7218f38b59db 100644
--- a/sound/pci/sonicvibes.c
+++ b/sound/pci/sonicvibes.c
@@ -1433,14 +1433,12 @@ static int snd_sonicvibes_midi(struct sonicvibes *sonic,
 {
 	struct snd_mpu401 * mpu = rmidi->private_data;
 	struct snd_card *card = sonic->card;
-	struct snd_rawmidi_str *dir;
 	unsigned int idx;
 	int err;
 
 	mpu->private_data = sonic;
 	mpu->open_input = snd_sonicvibes_midi_input_open;
 	mpu->close_input = snd_sonicvibes_midi_input_close;
-	dir = &rmidi->streams[SNDRV_RAWMIDI_STREAM_OUTPUT];
 	for (idx = 0; idx < ARRAY_SIZE(snd_sonicvibes_midi_controls); idx++)
 		if ((err = snd_ctl_add(card, snd_ctl_new1(&snd_sonicvibes_midi_controls[idx], sonic))) < 0)
 			return err;
-- 
2.17.1
