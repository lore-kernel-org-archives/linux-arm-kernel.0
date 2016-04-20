From: pc.liao@mediatek.com (PC Liao)
Date: Wed, 20 Apr 2016 14:40:45 +0800
Subject: [PATCH 0/2 v6] ASoC: mediatek: Add second I2S on mt8173-rt5650
 machine driver
Message-ID: <1461134447-42001-1-git-send-email-pc.liao@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Because applied patch (commit 0beeb8d0b434b8b007ac8058fb2cac5997fff6df
"ASoC: mediatek: Add second I2S on mt8173-rt5650 machine driver") is 
dropped, I upload new version which include dependent patch.

Changes since v5:
 - add "ASoC: core: export snd_soc_get_dai_name" patch. 
Because snd_soc_of_get_dai_name() fix the property name "sound-dai". 
Our patch needs to change name to use, so export
snd_soc_get_dai_name() which is included in snd_soc_of_get_dai_name(). 

Changes since v4:
Change name from "sound-dai" to "capture-dai" to determine the capture path

Changes since v2,v3:
Fix unclear code and use sound-dai to determine the capture path

Changes since v1:
Use codec dai name to determine the capture path. 


Jean-Francois Moine (1):
  ASoC: core: export snd_soc_get_dai_name

PC Liao (1):
  ASoC: mediatek: Add second I2S on mt8173-rt5650 machine driver

 .../devicetree/bindings/sound/mt8173-rt5650.txt    |    6 +++
 include/sound/soc.h                                |    2 +
 sound/soc/mediatek/mt8173-rt5650.c                 |   44 ++++++++++++++++++--
 sound/soc/soc-core.c                               |    5 ++-
 4 files changed, 52 insertions(+), 5 deletions(-)

-- 
1.7.9.5
