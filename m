From: garlic.tseng@mediatek.com (Garlic Tseng)
Date: Mon, 4 Jul 2016 18:56:24 +0800
Subject: [alsa-devel] [PATCH 0/4] ASoC: Mediatek: add MT2701 platform and
 machine driver
Message-ID: <1467629788-14411-1-git-send-email-garlic.tseng@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some patches of the patchset "ASoC: Mediatek: Add support for MT2701 SOC"
have been applied to the broonie tree, so I send a new patchset for the 
remaining patches.

The patchset adds mt2701 support based on Mediatek AFE common structure.

Change since the previous patchset:
* remove unnecessary set_clkdiv and set_fmt ops in mt2701 platform driver
* add another snd_soc_dai_driver for bt-sco codec to support 8k and 16k



Garlic Tseng (4):
  ASoC: mediatek: add mt2701 platform driver implementation.
  ASoC: bt-sco: extend rate and add a general compatible string
  ASoC: mediatek: add BT implementation
  ASoC: mediatek: Add mt2701-cs42448 driver and config option.

 Documentation/devicetree/bindings/sound/bt-sco.txt |    2 +-
 sound/soc/codecs/bt-sco.c                          |   52 +-
 sound/soc/mediatek/Kconfig                         |   21 +
 sound/soc/mediatek/Makefile                        |    1 +
 sound/soc/mediatek/mt2701/Makefile                 |   19 +
 sound/soc/mediatek/mt2701/mt2701-afe-common.h      |    9 -
 sound/soc/mediatek/mt2701/mt2701-afe-pcm.c         | 1654 ++++++++++++++++++++
 sound/soc/mediatek/mt2701/mt2701-cs42448.c         |  412 +++++
 8 files changed, 2144 insertions(+), 26 deletions(-)
 create mode 100644 sound/soc/mediatek/mt2701/Makefile
 create mode 100644 sound/soc/mediatek/mt2701/mt2701-afe-pcm.c
 create mode 100644 sound/soc/mediatek/mt2701/mt2701-cs42448.c

-- 
1.9.1
