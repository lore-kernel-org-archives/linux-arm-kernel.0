From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Sat, 31 Aug 2013 13:46:37 +0100
Subject: [PATCH 12/14] ASoC: kirkwood-t5325: add DAPM links between codec and
 cpu DAI
In-Reply-To: <20130831123458.GF6617@n2100.arm.linux.org.uk>
References: <20130831123458.GF6617@n2100.arm.linux.org.uk>
Message-ID: <E1VFkZZ-0003JG-9d@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the DAPM links to connect the codec DAC and ADCs to the cpu DAI
I2S inputs/outputs.  This is required to restore audio on this
platform as kirkwood-i2s must know which output streams to enable.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 sound/soc/kirkwood/kirkwood-t5325.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/sound/soc/kirkwood/kirkwood-t5325.c b/sound/soc/kirkwood/kirkwood-t5325.c
index 82a8c5f..5f5ae08 100644
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
@@ -66,6 +69,7 @@ static int t5325_dai_init(struct snd_soc_pcm_runtime *rtd)
 	return 0;
 }
 
+/* This will need to be updated when DPCM support works. */
 static struct snd_soc_dai_link t5325_dai[] = {
 {
 	.name = "ALC5621",
-- 
1.7.4.4
