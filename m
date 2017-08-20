From: dolinux.peng@gmail.com (Peng Donglin)
Date: Sun, 20 Aug 2017 13:21:00 +0800
Subject: [PATCH 00/12] Remove unnecessary function call
Message-ID: <1503206460-14848-1-git-send-email-dolinux.peng@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

First of all,the address of pdev->dev is assigned to card->dev,then
the function platform_set_drvdata copies the value the variable card
to pdev->dev.driver_data, but when calling snd_soc_register_card,the
function dev_set_drvdata(card->dev, card) will also do the same copy
operation,so i think that the former copy operation can be removed.

Peng Donglin (12):
  ASoC: s3c24xx_uda134x: Remove unnecessary function call
  ASoC: mediatek: Remove unnecessary function call
  ASoC: Intel: Remove unnecessary function call
  ASoC: atmel: Remove unnecessary function call
  ASoC: atmel: Remove unnecessary function call
  ASoC: rockchip: Remove unnecessary function call
  ASoC: mxs-sgtl5000: Remove unnecessary function call
  ASoC: qcom: Remove useless function call
  ASoC: qcom: Remove unnecessary function call
  ASoC: sun4i-codec: Remove unnecessary function call
  ASoC: tegra: Remove unnecessary function call
  ASoC: ux500: Remove unnecessary function call

 sound/soc/atmel/atmel-classd.c                   | 1 -
 sound/soc/atmel/atmel-pdmic.c                    | 1 -
 sound/soc/intel/boards/bytcht_da7213.c           | 1 -
 sound/soc/intel/boards/bytcht_es8316.c           | 1 -
 sound/soc/intel/boards/bytcr_rt5651.c            | 1 -
 sound/soc/intel/boards/cht_bsw_max98090_ti.c     | 1 -
 sound/soc/intel/boards/cht_bsw_rt5645.c          | 1 -
 sound/soc/intel/boards/cht_bsw_rt5672.c          | 1 -
 sound/soc/mediatek/mt8173/mt8173-rt5650-rt5514.c | 1 -
 sound/soc/mediatek/mt8173/mt8173-rt5650-rt5676.c | 1 -
 sound/soc/mediatek/mt8173/mt8173-rt5650.c        | 1 -
 sound/soc/mxs/mxs-sgtl5000.c                     | 1 -
 sound/soc/qcom/apq8016_sbc.c                     | 1 -
 sound/soc/qcom/storm.c                           | 1 -
 sound/soc/rockchip/rk3288_hdmi_analog.c          | 2 --
 sound/soc/rockchip/rk3399_gru_sound.c            | 1 -
 sound/soc/samsung/s3c24xx_uda134x.c              | 1 -
 sound/soc/sunxi/sun4i-codec.c                    | 1 -
 sound/soc/tegra/tegra_alc5632.c                  | 1 -
 sound/soc/tegra/tegra_max98090.c                 | 1 -
 sound/soc/tegra/tegra_rt5640.c                   | 1 -
 sound/soc/tegra/tegra_rt5677.c                   | 1 -
 sound/soc/tegra/tegra_sgtl5000.c                 | 1 -
 sound/soc/tegra/tegra_wm8753.c                   | 1 -
 sound/soc/tegra/tegra_wm8903.c                   | 1 -
 sound/soc/tegra/tegra_wm9712.c                   | 1 -
 sound/soc/tegra/trimslice.c                      | 1 -
 sound/soc/ux500/mop500.c                         | 1 -
 28 files changed, 29 deletions(-)

-- 
1.9.1
