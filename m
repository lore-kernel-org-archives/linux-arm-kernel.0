From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Sun, 04 Aug 2013 20:28:04 +0100
Subject: [PATCH RFC 07/13] ASoC: kirkwood: move calculation of max buffer
 size to kirkwood.h
In-Reply-To: <20130804192136.GK23006@n2100.arm.linux.org.uk>
References: <20130804192136.GK23006@n2100.arm.linux.org.uk>
Message-ID: <E1V63yG-0004le-16@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 sound/soc/kirkwood/kirkwood-dma.c |    2 +-
 sound/soc/kirkwood/kirkwood.h     |    2 ++
 2 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/sound/soc/kirkwood/kirkwood-dma.c b/sound/soc/kirkwood/kirkwood-dma.c
index 2091d55..ee31016 100644
--- a/sound/soc/kirkwood/kirkwood-dma.c
+++ b/sound/soc/kirkwood/kirkwood-dma.c
@@ -51,7 +51,7 @@ static struct snd_pcm_hardware kirkwood_dma_snd_hw = {
 	.rate_max		= 384000,
 	.channels_min		= 1,
 	.channels_max		= 8,
-	.buffer_bytes_max	= KIRKWOOD_SND_MAX_PERIOD_BYTES * KIRKWOOD_SND_MAX_PERIODS,
+	.buffer_bytes_max	= KIRKWOOD_SND_MAX_BUFFER_BYTES,
 	.period_bytes_min	= KIRKWOOD_SND_MIN_PERIOD_BYTES,
 	.period_bytes_max	= KIRKWOOD_SND_MAX_PERIOD_BYTES,
 	.periods_min		= KIRKWOOD_SND_MIN_PERIODS,
diff --git a/sound/soc/kirkwood/kirkwood.h b/sound/soc/kirkwood/kirkwood.h
index 1d13dee..f8e1ccc 100644
--- a/sound/soc/kirkwood/kirkwood.h
+++ b/sound/soc/kirkwood/kirkwood.h
@@ -125,6 +125,8 @@
 #define KIRKWOOD_SND_MAX_PERIODS		16
 #define KIRKWOOD_SND_MIN_PERIOD_BYTES		0x4000
 #define KIRKWOOD_SND_MAX_PERIOD_BYTES		0x4000
+#define KIRKWOOD_SND_MAX_BUFFER_BYTES		(KIRKWOOD_SND_MAX_PERIOD_BYTES \
+						 * KIRKWOOD_SND_MAX_PERIODS)
 
 struct kirkwood_dma_data {
 	void __iomem *io;
-- 
1.7.4.4
