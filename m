From: alexanders83@web.de (Alexander Stein)
Date: Sat, 12 Apr 2014 11:08:25 +0200
Subject: [PATCH 2/4] ALSA: sound/atmel-ac97c.h: Remove unused flags from
 platform data
In-Reply-To: <1397293707-26890-1-git-send-email-alexanders83@web.de>
References: <1397293707-26890-1-git-send-email-alexanders83@web.de>
Message-ID: <1397293707-26890-3-git-send-email-alexanders83@web.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This platform data member is unsed, so remove it.

Signed-off-by: Alexander Stein <alexanders83@web.de>
---
 include/sound/atmel-ac97c.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/sound/atmel-ac97c.h b/include/sound/atmel-ac97c.h
index e6aabdb..00e6c289 100644
--- a/include/sound/atmel-ac97c.h
+++ b/include/sound/atmel-ac97c.h
@@ -23,7 +23,6 @@
  * @reset_pin: GPIO pin wired to the reset input on the external AC97 codec,
  *             optional to use, set to -ENODEV if not in use. AC97 layer will
  *             try to do a software reset of the external codec anyway.
- * @flags: Flags for which directions should be enabled.
  *
  * If the user do not want to use a DMA channel for playback or capture, i.e.
  * only one feature is required on the board. The slave for playback or capture
@@ -33,7 +32,6 @@
 struct ac97c_platform_data {
 	struct dw_dma_slave	rx_dws;
 	struct dw_dma_slave	tx_dws;
-	unsigned int 		flags;
 	int			reset_pin;
 };
 
-- 
1.9.2
