From: danielperezdeandres@gmail.com (Daniel Perez de Andres)
Date: Fri, 17 Feb 2017 10:18:19 +0100
Subject: [PATCH] Staging: BCM2835-Audio: bcm2835-pcm: single line block
 statement braces fix
Message-ID: <1487323099-12721-1-git-send-email-danielperezdeandres@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A single line statement under an if clause doesn't require braces {}

Signed-off-by: Daniel Perez de Andres <danielperezdeandres@gmail.com>
---
 drivers/staging/bcm2835-audio/bcm2835-pcm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/bcm2835-audio/bcm2835-pcm.c b/drivers/staging/bcm2835-audio/bcm2835-pcm.c
index 014bf7a..a2a8694 100644
--- a/drivers/staging/bcm2835-audio/bcm2835-pcm.c
+++ b/drivers/staging/bcm2835-audio/bcm2835-pcm.c
@@ -317,9 +317,9 @@ static int snd_bcm2835_pcm_prepare(struct snd_pcm_substream *substream)
 	err = bcm2835_audio_set_params(alsa_stream, channels,
 		alsa_stream->params_rate,
 		alsa_stream->pcm_format_width);
-	if (err < 0) {
+	if (err < 0)
 		audio_error(" error setting hw params\n");
-	}
+
 
 	bcm2835_audio_setup(alsa_stream);
 
-- 
2.7.4
