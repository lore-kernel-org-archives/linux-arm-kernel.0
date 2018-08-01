From: colin.king@canonical.com (Colin King)
Date: Wed,  1 Aug 2018 11:47:37 +0100
Subject: [PATCH 4/9] ALSA: ens137x: remove redundant array pcm_devs
In-Reply-To: <20180801104742.4328-1-colin.king@canonical.com>
References: <20180801104742.4328-1-colin.king@canonical.com>
Message-ID: <20180801104742.4328-5-colin.king@canonical.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Colin Ian King <colin.king@canonical.com>

The array pcm_devs is being assigned but is never used hence it is
redundant and can be removed.

Cleans up clang warning:
warning: variable 'pcm_devs' set but not used [-Wunused-but-set-variable]

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 sound/pci/ens1370.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/pci/ens1370.c b/sound/pci/ens1370.c
index 39f79a6b5283..727eb3da1fda 100644
--- a/sound/pci/ens1370.c
+++ b/sound/pci/ens1370.c
@@ -2392,7 +2392,7 @@ static int snd_audiopci_probe(struct pci_dev *pci,
 	static int dev;
 	struct snd_card *card;
 	struct ensoniq *ensoniq;
-	int err, pcm_devs[2];
+	int err;
 
 	if (dev >= SNDRV_CARDS)
 		return -ENODEV;
@@ -2412,7 +2412,6 @@ static int snd_audiopci_probe(struct pci_dev *pci,
 	}
 	card->private_data = ensoniq;
 
-	pcm_devs[0] = 0; pcm_devs[1] = 1;
 #ifdef CHIP1370
 	if ((err = snd_ensoniq_1370_mixer(ensoniq)) < 0) {
 		snd_card_free(card);
-- 
2.17.1
