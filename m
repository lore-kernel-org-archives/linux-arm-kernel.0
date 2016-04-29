From: garlic.tseng@mediatek.com (Garlic Tseng)
Date: Fri, 29 Apr 2016 21:00:41 +0800
Subject: [alsa-devel] [PATCH 0/7] ASoC: Mediatek: Add support for MT2701 SOC
Message-ID: <1461934848-60011-1-git-send-email-garlic.tseng@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds basic support for Mediatek AFE for MT2701 SoC.
The patch is based on broonie tree "for-next" branch.

Change since RFC v2:
add BT function
refine Kconfig and Makefile
add prefix 'mt8173' and 'mt2701' for relative drivers.

Garlic Tseng (7):
  ASoC: mediatek: Refine mt8173 driver and change config option
  ASoC: mediatek: add documents for mt2701
  ASoC: mediatek: add clock and irq control for 2701 platform driver
  ASoC: mediatek: add mt2701 platform driver implementation.
  ASoC: bt-sco: extend rate and add a general compatible string
  ASoC: mediatek: add BT implementation
  ASoC: mediatek: Add mt2701-cs42448 driver and config option.

 Documentation/devicetree/bindings/sound/bt-sco.txt |    2 +-
 .../devicetree/bindings/sound/mt2701-afe-pcm.txt   |  150 ++
 .../devicetree/bindings/sound/mt2701-cs42448.txt   |   43 +
 sound/soc/codecs/bt-sco.c                          |    5 +-
 sound/soc/mediatek/Kconfig                         |   35 +-
 sound/soc/mediatek/Makefile                        |    9 +-
 sound/soc/mediatek/mt2701/Makefile                 |   20 +
 sound/soc/mediatek/mt2701/mt2701-afe-clock-ctrl.c  |  344 ++++
 sound/soc/mediatek/mt2701/mt2701-afe-clock-ctrl.h  |   33 +
 sound/soc/mediatek/mt2701/mt2701-afe-common.h      |  228 +++
 sound/soc/mediatek/mt2701/mt2701-afe-pcm.c         | 1825 ++++++++++++++++++++
 sound/soc/mediatek/mt2701/mt2701-cs42448.c         |  412 +++++
 sound/soc/mediatek/mt2701/mt2701-irq.c             |   74 +
 sound/soc/mediatek/mt2701/mt2701-irq.h             |   26 +
 sound/soc/mediatek/mt2701/mt2701-reg.h             |  195 +++
 sound/soc/mediatek/mt8173/Makefile                 |    7 +
 sound/soc/mediatek/mt8173/mt8173-afe-common.h      |  101 ++
 .../{mtk-afe-pcm.c => mt8173/mt8173-afe-pcm.c}     |  488 +++---
 sound/soc/mediatek/{ => mt8173}/mt8173-max98090.c  |    2 +-
 .../mediatek/{ => mt8173}/mt8173-rt5650-rt5514.c   |    2 +-
 .../mediatek/{ => mt8173}/mt8173-rt5650-rt5676.c   |    4 +-
 sound/soc/mediatek/{ => mt8173}/mt8173-rt5650.c    |    2 +-
 sound/soc/mediatek/mtk-afe-common.h                |  101 --
 23 files changed, 3740 insertions(+), 368 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/mt2701-afe-pcm.txt
 create mode 100644 Documentation/devicetree/bindings/sound/mt2701-cs42448.txt
 create mode 100644 sound/soc/mediatek/mt2701/Makefile
 create mode 100644 sound/soc/mediatek/mt2701/mt2701-afe-clock-ctrl.c
 create mode 100644 sound/soc/mediatek/mt2701/mt2701-afe-clock-ctrl.h
 create mode 100644 sound/soc/mediatek/mt2701/mt2701-afe-common.h
 create mode 100644 sound/soc/mediatek/mt2701/mt2701-afe-pcm.c
 create mode 100644 sound/soc/mediatek/mt2701/mt2701-cs42448.c
 create mode 100644 sound/soc/mediatek/mt2701/mt2701-irq.c
 create mode 100644 sound/soc/mediatek/mt2701/mt2701-irq.h
 create mode 100644 sound/soc/mediatek/mt2701/mt2701-reg.h
 create mode 100644 sound/soc/mediatek/mt8173/Makefile
 create mode 100644 sound/soc/mediatek/mt8173/mt8173-afe-common.h
 rename sound/soc/mediatek/{mtk-afe-pcm.c => mt8173/mt8173-afe-pcm.c} (67%)
 rename sound/soc/mediatek/{ => mt8173}/mt8173-max98090.c (99%)
 rename sound/soc/mediatek/{ => mt8173}/mt8173-rt5650-rt5514.c (99%)
 rename sound/soc/mediatek/{ => mt8173}/mt8173-rt5650-rt5676.c (99%)
 rename sound/soc/mediatek/{ => mt8173}/mt8173-rt5650.c (99%)
 delete mode 100644 sound/soc/mediatek/mtk-afe-common.h

-- 
1.9.1
