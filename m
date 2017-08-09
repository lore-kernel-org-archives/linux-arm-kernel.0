From: arvind.yadav.cs@gmail.com (Arvind Yadav)
Date: Wed,  9 Aug 2017 13:22:34 +0530
Subject: [PATCH] staging: bcm2835-audio: constify snd_pcm_ops structures
Message-ID: <9d78b0e65d59a2bcfed7ce9e347c9202408be5d5.1502264969.git.arvind.yadav.cs@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

snd_pcm_ops are not supposed to change at runtime. All functions
working with snd_pcm_ops provided by <sound/pcm.h> work with
const snd_pcm_ops. So mark the non-const structs as const.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 drivers/staging/vc04_services/bcm2835-audio/bcm2835-pcm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/vc04_services/bcm2835-audio/bcm2835-pcm.c b/drivers/staging/vc04_services/bcm2835-audio/bcm2835-pcm.c
index 3637ddf..1bf34ce 100644
--- a/drivers/staging/vc04_services/bcm2835-audio/bcm2835-pcm.c
+++ b/drivers/staging/vc04_services/bcm2835-audio/bcm2835-pcm.c
@@ -438,7 +438,7 @@ static int snd_bcm2835_pcm_lib_ioctl(struct snd_pcm_substream *substream,
 }
 
 /* operators */
-static struct snd_pcm_ops snd_bcm2835_playback_ops = {
+static const struct snd_pcm_ops snd_bcm2835_playback_ops = {
 	.open = snd_bcm2835_playback_open,
 	.close = snd_bcm2835_playback_close,
 	.ioctl = snd_bcm2835_pcm_lib_ioctl,
@@ -450,7 +450,7 @@ static int snd_bcm2835_pcm_lib_ioctl(struct snd_pcm_substream *substream,
 	.ack = snd_bcm2835_pcm_ack,
 };
 
-static struct snd_pcm_ops snd_bcm2835_playback_spdif_ops = {
+static const struct snd_pcm_ops snd_bcm2835_playback_spdif_ops = {
 	.open = snd_bcm2835_playback_spdif_open,
 	.close = snd_bcm2835_playback_close,
 	.ioctl = snd_bcm2835_pcm_lib_ioctl,
-- 
1.9.1
