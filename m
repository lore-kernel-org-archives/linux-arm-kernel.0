From: broonie@kernel.org (Mark Brown)
Date: Tue, 21 Mar 2017 18:45:51 +0000
Subject: Applied "ASoC: sun8i-codec: Fix space on audio-routing widget" to the
 asoc tree
In-Reply-To: <20170309095602.13809-2-mylene.josserand@free-electrons.com>
Message-ID: <E1cqOn1-00019C-9I@debutante>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   ASoC: sun8i-codec: Fix space on audio-routing widget

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 79e26de81448fad80f6c15ae1e3c9e7fca2740cd Mon Sep 17 00:00:00 2001
From: =?UTF-8?q?Myl=C3=A8ne=20Josserand?=
 <mylene.josserand@free-electrons.com>
Date: Sat, 18 Mar 2017 08:55:07 +0100
Subject: [PATCH] ASoC: sun8i-codec: Fix space on audio-routing widget
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

An unwanted space is present in an audio widget's name on the dapm
routing. It causes an error on the recognition of this widget (error:
("no dapm match for AIF1 Slot 0 Right").

Remove the space fixes it.

Signed-off-by: Myl??ne Josserand <mylene.josserand@free-electrons.com>
Acked-by: Chen-Yu Tsai <wens@csie.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sunxi/sun8i-codec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/sunxi/sun8i-codec.c b/sound/soc/sunxi/sun8i-codec.c
index 107fa8213600..adb13fbd2006 100644
--- a/sound/soc/sunxi/sun8i-codec.c
+++ b/sound/soc/sunxi/sun8i-codec.c
@@ -337,7 +337,7 @@ static const struct snd_soc_dapm_route sun8i_codec_dapm_routes[] = {
 	/* DAC Mixer Routes */
 	{ "Left Digital DAC Mixer", "AIF1 Slot 0 Digital DAC Playback Switch",
 	  "Digital Left DAC"},
-	{ "Right Digital DAC Mixer", "AIF1 Slot 0 Digital DAC Playback Switch ",
+	{ "Right Digital DAC Mixer", "AIF1 Slot 0 Digital DAC Playback Switch",
 	  "Digital Right DAC"},
 };
 
-- 
2.11.0
