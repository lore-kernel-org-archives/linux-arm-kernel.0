From: jeffy.chen@rock-chips.com (Jeffy Chen)
Date: Thu, 24 Aug 2017 12:52:20 +0800
Subject: [RESENT PATCH v7 0/7] ASoC: rockchip: Parse dai links from dts
Message-ID: <20170824045227.15504-1-jeffy.chen@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Currently we are using a fixed list of dai links in the driver.
This serial of patches would let the driver parse dai links from
dts, so that we can make some of them optional for future boards.

Tested on my chromebook bob(with cros 4.4 kernel), it still works
after disabled rt5514 codecs in the dts.


Changes in v7:
Rebase on the newest for-next

Changes in v6:
Add dmic wakeup delay(not used for now).

Changes in v3:
Use compatible to match audio codecs
        -- Suggested-by Matthias Kaehlcke <mka@chromium.org>

Changes in v2:
Let rockchip,codec-names be a required property, because we plan to
add more supported codecs to the fixed dai link list in the driver.

Jeffy Chen (7):
  ASoC: rockchip: Use codec of_node and dai_name for rt5514 dsp
  arm64: dts: rockchip: Add rt5514 dsp for Gru
  arm64: dts: rockchip: Update rt5514 devices' compatible for Gru
  ASoC: rockchip: Parse dai links from dts
  ASoC: rockchip: Add support for DP codec
  ASoC: rockchip: Add support for DMIC codec
  dt-bindings: ASoC: rockchip: Update description of rockchip,codec

 .../bindings/sound/rockchip,rk3399-gru-sound.txt   |   2 +-
 arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi       |   7 +-
 sound/soc/rockchip/Kconfig                         |   2 +
 sound/soc/rockchip/rk3399_gru_sound.c              | 255 +++++++++++++++------
 4 files changed, 186 insertions(+), 80 deletions(-)

-- 
2.11.0
