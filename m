From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Sun, 04 Aug 2013 20:31:04 +0100
Subject: [PATCH RFC 10/13] ASoC: kirkwood-t5325: add DAPM links between codec
 and cpu DAI
In-Reply-To: <20130804192136.GK23006@n2100.arm.linux.org.uk>
References: <20130804192136.GK23006@n2100.arm.linux.org.uk>
Message-ID: <E1V641A-0004lv-DM@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the DAPM links to connect the codec DAC and ADCs to the cpu DAI
I2S inputs/outputs.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 sound/soc/kirkwood/kirkwood-t5325.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/sound/soc/kirkwood/kirkwood-t5325.c b/sound/soc/kirkwood/kirkwood-t5325.c
index 82a8c5f..1647779 100644
--- a/sound/soc/kirkwood/kirkwood-t5325.c
+++ b/sound/soc/kirkwood/kirkwood-t5325.c
@@ -52,6 +52,9 @@ static const struct snd_soc_dapm_route t5325_route[] = {
 
 	{ "MIC1",		NULL,	"Mic Jack" },
 	{ "MIC2",		NULL,	"Mic Jack" },
+
+	{ "i2sdi",		NULL,	"Capture" },
+	{ "Playback",		NULL,	"i2sdo" },
 };
 
 static int t5325_dai_init(struct snd_soc_pcm_runtime *rtd)
-- 
1.7.4.4
