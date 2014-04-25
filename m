From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Fri, 25 Apr 2014 12:42:41 +0100
Subject: [PATCH 132/222] ASoC: work around block transfer issues with
 imx-pcm-dma
In-Reply-To: <20140425112951.GK26756@n2100.arm.linux.org.uk>
References: <20140425112951.GK26756@n2100.arm.linux.org.uk>
Message-ID: <E1WdeWf-0007M5-Oj@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 sound/soc/fsl/imx-pcm-dma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/fsl/imx-pcm-dma.c b/sound/soc/fsl/imx-pcm-dma.c
index 2585ae44e634..a86d84854c7f 100644
--- a/sound/soc/fsl/imx-pcm-dma.c
+++ b/sound/soc/fsl/imx-pcm-dma.c
@@ -44,7 +44,7 @@ static const struct snd_pcm_hardware imx_pcm_hardware = {
 	.buffer_bytes_max = IMX_SSI_DMABUF_SIZE,
 	.period_bytes_min = 128,
 	.period_bytes_max = 65535, /* Limited by SDMA engine */
-	.periods_min = 2,
+	.periods_min = 4,
 	.periods_max = 255,
 	.fifo_size = 0,
 };
-- 
1.8.3.1
