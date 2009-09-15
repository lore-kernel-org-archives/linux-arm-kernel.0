From: jassi.brar@samsung.com (Jassi)
Date: Tue, 15 Sep 2009 19:02:42 +0900
Subject: [PATCH 10/10] S3C64XX I2S: En/Disable codec clocks.
Message-ID: <1253008962-10730-1-git-send-email-jassi.brar@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Disable audio-bus when PCLK is used as base clock for I2S controller
codec. Enable otherwise.

Signed-Off-by: Jassi <jassi.brar@samsung.com>
---
 sound/soc/s3c24xx/s3c64xx-i2s.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/sound/soc/s3c24xx/s3c64xx-i2s.c b/sound/soc/s3c24xx/s3c64xx-i2s.c
index 71aeb33..4438f5b 100644
--- a/sound/soc/s3c24xx/s3c64xx-i2s.c
+++ b/sound/soc/s3c24xx/s3c64xx-i2s.c
@@ -107,10 +107,12 @@ static int s3c64xx_i2s_set_sysclk(struct snd_soc_dai *cpu_dai,
 	switch (clk_id) {
 	case S3C64XX_CLKSRC_PCLK:
 		iismod &= ~S3C64XX_IISMOD_IMS_SYSMUX;
+		clk_disable(i2s->iis_cclk);
 		break;
 
 	case S3C64XX_CLKSRC_MUX:
 		iismod |= S3C64XX_IISMOD_IMS_SYSMUX;
+		clk_enable(i2s->iis_cclk);
 		break;
 
 	case S3C64XX_CODCLKSRC_INT:
-- 
1.6.2.5
