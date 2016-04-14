From: garlic.tseng@mediatek.com (Garlic Tseng)
Date: Thu, 14 Apr 2016 20:14:25 +0800
Subject: [alsa-devel] [RFC PATCH v2 0/5] ASoC: Mediatek: Add support for
 MT2701 SOC
Message-ID: <1460636070-37426-1-git-send-email-garlic.tseng@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Refactor and go v2 because of the 60KB limitation

This patch adds basic support for Mediatek AFE for MT2701 SoC.
The patch is based on broonie tree "for-next" branch.

The interface to connect with BT chip is not finished yet, but as an upstream
rookie I really need some comments. Any comments will be greatly appreciated.


Garlic Tseng (5):
  ASoC: mediatek: Refine mt8173 driver
  ASoC: mediatek: add documents for mt2701
  ASoC: mediatek: add clock and irq control for 2701 platform driver
  ASoC: mediatek: add mt2701 platform driver implementation.
  ASoC: mediatek: Add mt2701-cs42448 driver and config option.

 .../devicetree/bindings/sound/mt2701-cs42448.txt   |   39 +
 .../devicetree/bindings/sound/mtk2701-afe-pcm.txt  |  150 ++
 sound/soc/mediatek/Kconfig                         |   21 +
 sound/soc/mediatek/Makefile                        |   15 +-
 sound/soc/mediatek/mt2701/Makefile                 |   20 +
 sound/soc/mediatek/mt2701/mt2701-cs42448.c         |  376 +++++
 sound/soc/mediatek/mt2701/mtk2701-afe-clock-ctrl.c |  259 +++
 sound/soc/mediatek/mt2701/mtk2701-afe-clock-ctrl.h |   28 +
 sound/soc/mediatek/mt2701/mtk2701-afe-common.h     |  217 +++
 sound/soc/mediatek/mt2701/mtk2701-afe-pcm.c        | 1752 ++++++++++++++++++++
 sound/soc/mediatek/mt2701/mtk2701-irq.c            |  109 ++
 sound/soc/mediatek/mt2701/mtk2701-irq.h            |   30 +
 sound/soc/mediatek/mt2701/mtk2701-reg.h            |  165 ++
 sound/soc/mediatek/mt8173/Makefile                 |    7 +
 sound/soc/mediatek/{ => mt8173}/mt8173-max98090.c  |    2 +-
 .../mediatek/{ => mt8173}/mt8173-rt5650-rt5514.c   |    2 +-
 .../mediatek/{ => mt8173}/mt8173-rt5650-rt5676.c   |    4 +-
 sound/soc/mediatek/{ => mt8173}/mt8173-rt5650.c    |    2 +-
 sound/soc/mediatek/{ => mt8173}/mtk-afe-common.h   |    0
 sound/soc/mediatek/{ => mt8173}/mtk-afe-pcm.c      |    0
 20 files changed, 3186 insertions(+), 12 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/mt2701-cs42448.txt
 create mode 100644 Documentation/devicetree/bindings/sound/mtk2701-afe-pcm.txt
 create mode 100644 sound/soc/mediatek/mt2701/Makefile
 create mode 100644 sound/soc/mediatek/mt2701/mt2701-cs42448.c
 create mode 100644 sound/soc/mediatek/mt2701/mtk2701-afe-clock-ctrl.c
 create mode 100644 sound/soc/mediatek/mt2701/mtk2701-afe-clock-ctrl.h
 create mode 100644 sound/soc/mediatek/mt2701/mtk2701-afe-common.h
 create mode 100644 sound/soc/mediatek/mt2701/mtk2701-afe-pcm.c
 create mode 100644 sound/soc/mediatek/mt2701/mtk2701-irq.c
 create mode 100644 sound/soc/mediatek/mt2701/mtk2701-irq.h
 create mode 100644 sound/soc/mediatek/mt2701/mtk2701-reg.h
 create mode 100644 sound/soc/mediatek/mt8173/Makefile
 rename sound/soc/mediatek/{ => mt8173}/mt8173-max98090.c (99%)
 rename sound/soc/mediatek/{ => mt8173}/mt8173-rt5650-rt5514.c (99%)
 rename sound/soc/mediatek/{ => mt8173}/mt8173-rt5650-rt5676.c (99%)
 rename sound/soc/mediatek/{ => mt8173}/mt8173-rt5650.c (99%)
 rename sound/soc/mediatek/{ => mt8173}/mtk-afe-common.h (100%)
 rename sound/soc/mediatek/{ => mt8173}/mtk-afe-pcm.c (100%)

-- 
1.9.1
