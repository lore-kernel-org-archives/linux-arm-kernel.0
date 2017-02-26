From: narcisaanamaria12@gmail.com (Narcisa Ana Maria Vasile)
Date: Sun, 26 Feb 2017 19:47:51 +0200
Subject: [PATCH] staging: bcm2835-audio: Fixed spacing around '&'
Message-ID: <1488131271-2908-1-git-send-email-narcisaanamaria12@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This was reported by checkpatch.pl

Signed-off-by: Narcisa Ana Maria Vasile <narcisaanamaria12@gmail.com>
---
 drivers/staging/bcm2835-audio/bcm2835-pcm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/bcm2835-audio/bcm2835-pcm.c b/drivers/staging/bcm2835-audio/bcm2835-pcm.c
index 9e79236..328bee4a 100644
--- a/drivers/staging/bcm2835-audio/bcm2835-pcm.c
+++ b/drivers/staging/bcm2835-audio/bcm2835-pcm.c
@@ -91,7 +91,7 @@ void bcm2835_playback_fifo(struct bcm2835_alsa_stream *alsa_stream)
 		frames_to_bytes(alsa_stream->substream->runtime, alsa_stream->substream->runtime->status->hw_ptr),
 		new_period);
 	if (alsa_stream->buffer_size) {
-		alsa_stream->pos += consumed &~(1 << 30);
+		alsa_stream->pos += consumed & ~(1 << 30);
 		alsa_stream->pos %= alsa_stream->buffer_size;
 	}
 
-- 
1.9.1
