From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Sat, 31 Aug 2013 13:43:36 +0100
Subject: [PATCH 09/14] ASoC: kirkwood-dma: remove IEC958_SUBFRAME formats
In-Reply-To: <20130831123458.GF6617@n2100.arm.linux.org.uk>
References: <20130831123458.GF6617@n2100.arm.linux.org.uk>
Message-ID: <E1VFkWe-0003Iw-UI@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Audio block does not support IEC958 subframes as formatted by
ALSA: they're very close, but not close enough.  The formats differ
by:

3  2   2   2   1   1
1  8   4   0   6   2   8   4   0
PCUVDDDDDDDDDDDDDDDD....AAAATTTT - IEC958 subframe
PCUV0000........DDDDDDDDDDDDDDDD - Audio block format

Where P = parity, C = channel status, U = user data, V = validity,
D = sample data, A = aux, T = preamble.  As can be seen, the
position of the sample is in a different position, and the audio
block does not have the aux or preamble bits.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 sound/soc/kirkwood/kirkwood-dma.c |    4 +---
 1 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/sound/soc/kirkwood/kirkwood-dma.c b/sound/soc/kirkwood/kirkwood-dma.c
index ee31016..3c8fc75 100644
--- a/sound/soc/kirkwood/kirkwood-dma.c
+++ b/sound/soc/kirkwood/kirkwood-dma.c
@@ -29,9 +29,7 @@
 #define KIRKWOOD_FORMATS \
 	(SNDRV_PCM_FMTBIT_S16_LE | \
 	 SNDRV_PCM_FMTBIT_S24_LE | \
-	 SNDRV_PCM_FMTBIT_S32_LE | \
-	 SNDRV_PCM_FMTBIT_IEC958_SUBFRAME_LE | \
-	 SNDRV_PCM_FMTBIT_IEC958_SUBFRAME_BE)
+	 SNDRV_PCM_FMTBIT_S32_LE)
 
 static struct kirkwood_dma_data *kirkwood_priv(struct snd_pcm_substream *subs)
 {
-- 
1.7.4.4
