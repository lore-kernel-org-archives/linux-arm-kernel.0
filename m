From: garlic.tseng@mediatek.com (Garlic Tseng)
Date: Thu, 14 Apr 2016 15:37:04 +0800
Subject: [alsa-devel] [RFC PATCH 0/4] ASoC: Mediatek: Add support for MT2701
 SOC
Message-ID: <1460619428-48882-1-git-send-email-garlic.tseng@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds basic support for Mediatek AFE for MT2701 SoC.
The patch is based on broonie tree "for-next" branch.

The interface to connect with BT chip is not finish yet, but as an upstream
rookie I really need some comments. Any comments will be greatly appreciated.

Garlic Tseng (4):
  ASoC: mediatek: Refine mt8173 driver
  ASoC: mediatek: add documents for mt2701
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
 sound/soc/mediatek/mt8173-max98090.c               |  213 ---
 sound/soc/mediatek/mt8173-rt5650-rt5514.c          |  258 ---
 sound/soc/mediatek/mt8173-rt5650-rt5676.c          |  288 ----
 sound/soc/mediatek/mt8173-rt5650.c                 |  236 ---
 sound/soc/mediatek/mt8173/Makefile                 |    7 +
 sound/soc/mediatek/mt8173/mt8173-max98090.c        |  213 +++
 sound/soc/mediatek/mt8173/mt8173-rt5650-rt5514.c   |  258 +++
 sound/soc/mediatek/mt8173/mt8173-rt5650-rt5676.c   |  288 ++++
 sound/soc/mediatek/mt8173/mt8173-rt5650.c          |  236 +++
 sound/soc/mediatek/mt8173/mtk-afe-common.h         |  101 ++
 sound/soc/mediatek/mt8173/mtk-afe-pcm.c            | 1333 +++++++++++++++
 sound/soc/mediatek/mtk-afe-common.h                |  101 --
 sound/soc/mediatek/mtk-afe-pcm.c                   | 1333 ---------------
 26 files changed, 5610 insertions(+), 2436 deletions(-)
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
 delete mode 100644 sound/soc/mediatek/mt8173-max98090.c
 delete mode 100644 sound/soc/mediatek/mt8173-rt5650-rt5514.c
 delete mode 100644 sound/soc/mediatek/mt8173-rt5650-rt5676.c
 delete mode 100644 sound/soc/mediatek/mt8173-rt5650.c
 create mode 100644 sound/soc/mediatek/mt8173/Makefile
 create mode 100644 sound/soc/mediatek/mt8173/mt8173-max98090.c
 create mode 100644 sound/soc/mediatek/mt8173/mt8173-rt5650-rt5514.c
 create mode 100644 sound/soc/mediatek/mt8173/mt8173-rt5650-rt5676.c
 create mode 100644 sound/soc/mediatek/mt8173/mt8173-rt5650.c
 create mode 100644 sound/soc/mediatek/mt8173/mtk-afe-common.h
 create mode 100644 sound/soc/mediatek/mt8173/mtk-afe-pcm.c
 delete mode 100644 sound/soc/mediatek/mtk-afe-common.h
 delete mode 100644 sound/soc/mediatek/mtk-afe-pcm.c

-- 
1.9.1
