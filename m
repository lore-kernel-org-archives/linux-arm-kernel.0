From: jeffy.chen@rock-chips.com (Jeffy Chen)
Date: Tue, 19 Sep 2017 20:57:55 +0800
Subject: [PATCH v3 0/5] This series of patches fix the boot time dapm route
 warnings(without rt5514):
Message-ID: <20170919125800.336-1-jeffy.chen@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[ 2.475501] rk3399-gru-sound sound: ASoC: no sink widget found for DMIC1L
[ 2.475503] rk3399-gru-sound sound: ASoC: Failed to add route Int Mic -> direct -> DMIC1L
[ 2.475505] rk3399-gru-sound sound: ASoC: no sink widget found for DMIC1R
[ 2.475507] rk3399-gru-sound sound: ASoC: Failed to add route Int Mic -> direct -> DMIC1R

And support detect rt5514-dsp codec and rt5514 codec by checking bus_type.

Changes in v3:
Rebase onto for-next 20170919

Changes in v2:
Separate HDMI/DMIC patches.
Fix DMic typo.

Jeffy Chen (5):
  ASoC: rockchip: Add dapm route for HDMI
  ASoC: rockchip: Add dapm route for DMic
  ASoC: rockchip: Init dapm routes dynamically
  ASoC: rockchip: Use bus_type to distinguish rt5514 dsp from rt5514
    codec
  ASoC: rt5514: Add devicetree binding support for rt5514-spi

 Documentation/devicetree/bindings/sound/rt5514.txt |  13 +-
 sound/soc/rockchip/rk3399_gru_sound.c              | 149 +++++++++++++++++----
 2 files changed, 132 insertions(+), 30 deletions(-)

-- 
2.11.0
