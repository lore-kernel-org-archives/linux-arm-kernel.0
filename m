From: hdegoede@redhat.com (Hans de Goede)
Date: Tue, 22 Dec 2015 23:00:17 +0100
Subject: [PATCH] ASoC: sun4i-codec: Use proper output for external amp routes
Message-ID: <1450821617-12906-1-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

An external amp (if any) is connected to the external outputs of the SoC
of course, rather then directly to the internal amp.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 sound/soc/sunxi/sun4i-codec.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/soc/sunxi/sun4i-codec.c b/sound/soc/sunxi/sun4i-codec.c
index e6cc6a1..44f170c 100644
--- a/sound/soc/sunxi/sun4i-codec.c
+++ b/sound/soc/sunxi/sun4i-codec.c
@@ -728,7 +728,8 @@ static const struct snd_soc_dapm_widget sun4i_codec_card_dapm_widgets[] = {
 };
 
 static const struct snd_soc_dapm_route sun4i_codec_card_dapm_routes[] = {
-	{ "Speaker", NULL, "Power Amplifier" },
+	{ "Speaker", NULL, "HP Right" },
+	{ "Speaker", NULL, "HP Left" },
 };
 
 static struct snd_soc_card *sun4i_codec_create_card(struct device *dev)
-- 
2.5.0
