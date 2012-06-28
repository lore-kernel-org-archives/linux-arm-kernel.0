From: shc_work@mail.ru (Alexander Shiyan)
Date: Thu, 28 Jun 2012 10:39:17 +0400
Subject: [PATCH] ARM: i.MX SSI: Removed an unnecessary setting SSI_SCR_NET bit
Message-ID: <1340865557-4626-1-git-send-email-shc_work@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch removes unnecessary setting of SSI_SCR_NET bit in code
of setup format for i.MX SSI. This bit is we are already setup at
the end of this procedure by setting IMX_SSI_NET bit in platform-data,
passed to SSI-init.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 sound/soc/fsl/imx-ssi.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/sound/soc/fsl/imx-ssi.c b/sound/soc/fsl/imx-ssi.c
index 28dd76c..2b1a630 100644
--- a/sound/soc/fsl/imx-ssi.c
+++ b/sound/soc/fsl/imx-ssi.c
@@ -96,7 +96,6 @@ static int imx_ssi_set_dai_fmt(struct snd_soc_dai *cpu_dai, unsigned int fmt)
 	case SND_SOC_DAIFMT_I2S:
 		/* data on rising edge of bclk, frame low 1clk before data */
 		strcr |= SSI_STCR_TFSI | SSI_STCR_TEFS | SSI_STCR_TXBIT0;
-		scr |= SSI_SCR_NET;
 		if (ssi->flags & IMX_SSI_USE_I2S_SLAVE) {
 			scr &= ~SSI_I2S_MODE_MASK;
 			scr |= SSI_SCR_I2S_MODE_SLAVE;
-- 
1.7.3.4
