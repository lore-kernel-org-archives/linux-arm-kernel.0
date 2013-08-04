From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Sun, 04 Aug 2013 20:30:04 +0100
Subject: [PATCH RFC 09/13] ASoC: kirkwood-openrd: add DAPM links between
 codec and cpu DAI
In-Reply-To: <20130804192136.GK23006@n2100.arm.linux.org.uk>
References: <20130804192136.GK23006@n2100.arm.linux.org.uk>
Message-ID: <E1V640C-0004lq-9U@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the DAPM links to connect the codec DAC and ADCs to the cpu DAI
I2S inputs/outputs.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 sound/soc/kirkwood/kirkwood-openrd.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/sound/soc/kirkwood/kirkwood-openrd.c b/sound/soc/kirkwood/kirkwood-openrd.c
index a25dfcf..37740f4 100644
--- a/sound/soc/kirkwood/kirkwood-openrd.c
+++ b/sound/soc/kirkwood/kirkwood-openrd.c
@@ -63,12 +63,19 @@ static struct snd_soc_dai_link openrd_client_dai[] = {
 },
 };
 
+static const struct snd_soc_dapm_route routes[] = {
+	/* Connect the codec streams to the I2S connections */
+	{ "Playback", NULL, "i2sdo" },
+	{ "i2sdi", NULL, "Capture" },
+};
 
 static struct snd_soc_card openrd_client = {
 	.name = "OpenRD Client",
 	.owner = THIS_MODULE,
 	.dai_link = openrd_client_dai,
 	.num_links = ARRAY_SIZE(openrd_client_dai),
+	.dapm_routes = routes,
+	.num_dapm_routes = ARRAY_SIZE(routes),
 };
 
 static int openrd_probe(struct platform_device *pdev)
-- 
1.7.4.4
