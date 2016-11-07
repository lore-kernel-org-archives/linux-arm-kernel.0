From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon,  7 Nov 2016 14:08:18 +0100
Subject: [PATCH 0/3] ARM: gr8: evb: Enable the i2s codec
Message-ID: <cover.9296840e0b7438e0ae63b4ec0d64957640b64a78.1478524066.git-series.maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The GR8-EVB comes with a wm8978 codec connected to the SoC through an I2S
bus.

A few patches were needed for it to work with simple-card, those are the
very first patches.

The last one will add that card to the relevant device tree so that we can
use it.

Let me know what you think,
Maxime

Maxime Ripard (3):
  ASoC: sunxi: i2s: Implement set_sysclk
  ASoC: wm8978: Adjust clock indices so that simple card works
  ARM: gr8: evb: Add i2s codec

 arch/arm/boot/dts/ntc-gr8-evb.dts | 14 ++++++++-
 sound/soc/codecs/wm8978.h         |  2 +-
 sound/soc/sunxi/sun4i-i2s.c       | 53 ++++++++++++++++++++++----------
 3 files changed, 53 insertions(+), 16 deletions(-)

base-commit: ff9ed64af60bd87cc1c1225e595a33fe248b02bf
-- 
git-series 0.8.11
