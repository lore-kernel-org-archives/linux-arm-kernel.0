From: bhumirks@gmail.com (Bhumika Goyal)
Date: Sun, 13 Aug 2017 18:13:11 +0530
Subject: [PATCH 4/6] usb: gadget: make snd_pcm_hardware const
In-Reply-To: <1502628193-3343-1-git-send-email-bhumirks@gmail.com>
References: <1502628193-3343-1-git-send-email-bhumirks@gmail.com>
Message-ID: <1502628193-3343-5-git-send-email-bhumirks@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Make this const as it is only used during a copy operation.
Done using Coccinelle.

Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>
---
 drivers/usb/gadget/function/u_audio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/function/u_audio.c b/drivers/usb/gadget/function/u_audio.c
index d4caa21..3971bba 100644
--- a/drivers/usb/gadget/function/u_audio.c
+++ b/drivers/usb/gadget/function/u_audio.c
@@ -79,7 +79,7 @@ struct snd_uac_chip {
 	unsigned int p_framesize;
 };
 
-static struct snd_pcm_hardware uac_pcm_hardware = {
+static const struct snd_pcm_hardware uac_pcm_hardware = {
 	.info = SNDRV_PCM_INFO_INTERLEAVED | SNDRV_PCM_INFO_BLOCK_TRANSFER
 		 | SNDRV_PCM_INFO_MMAP | SNDRV_PCM_INFO_MMAP_VALID
 		 | SNDRV_PCM_INFO_PAUSE | SNDRV_PCM_INFO_RESUME,
-- 
1.9.1
