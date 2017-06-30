From: broonie@kernel.org (Mark Brown)
Date: Fri, 30 Jun 2017 12:58:57 +0100
Subject: Applied "ASoC: audio-graph-card: update bindings for amplifier
 support" to the asoc tree
In-Reply-To: <1498742798-3128-2-git-send-email-shawnguo@kernel.org>
Message-ID: <E1dQuZd-0007yL-PG@finisterre>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   ASoC: audio-graph-card: update bindings for amplifier support

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

>From a0c683d734e0b3589892c17d0e1187f20d2c3a54 Mon Sep 17 00:00:00 2001
From: Shawn Guo <shawn.guo@linaro.org>
Date: Thu, 29 Jun 2017 21:26:37 +0800
Subject: [PATCH] ASoC: audio-graph-card: update bindings for amplifier support

The audio-graph-card should be able to support widgets and routing in
the same way as what simple-audio-card does.  The patch adds the
properties into audio-graph-card bindings.  Then an optional property
'pa-gpios' for controlling external amplifier, which depends on DAPM
widgets and routing, is added.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 Documentation/devicetree/bindings/sound/audio-graph-card.txt | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/audio-graph-card.txt b/Documentation/devicetree/bindings/sound/audio-graph-card.txt
index bac4b1b1060f..6e6720aa33f1 100644
--- a/Documentation/devicetree/bindings/sound/audio-graph-card.txt
+++ b/Documentation/devicetree/bindings/sound/audio-graph-card.txt
@@ -10,6 +10,8 @@ see ${LINUX}/Documentation/devicetree/bindings/sound/simple-card.txt
 Below are same as Simple-Card.
 
 - label
+- widgets
+- routing
 - dai-format
 - frame-master
 - bitclock-master
@@ -24,6 +26,9 @@ Required properties:
 - compatible				: "audio-graph-card";
 - dais					: list of CPU DAI port{s}
 
+Optional properties:
+- pa-gpios: GPIO used to control external amplifier.
+
 Example: Single DAI case
 
 	sound_card {
-- 
2.13.2
