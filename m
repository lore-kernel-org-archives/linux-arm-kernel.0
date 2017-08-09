From: jeffy.chen@rock-chips.com (Jeffy Chen)
Date: Wed,  9 Aug 2017 20:19:36 +0800
Subject: [PATCH 0/3] ASoC: rockchip: Parse dai links from dts
Message-ID: <1502281179-15916-1-git-send-email-jeffy.chen@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Currently we are using a fixed list of dai links in the driver.
This serial of patches would let the driver parse dai links from
dts, so that we can reorder/disable them in the dts.

Tested on my chromebook bob(with cros 4.4 kernel), it still works
after disabled rt5514 codec in the dts.



Jeffy Chen (3):
  ASoC: rockchip: Parse dai links from dts
  arm64: dts: rockchip: Add rockchip,codec-names property
  dt-bindings: ASoC: rockchip: Add rockchip,codec-names property

 .../bindings/sound/rockchip,rk3399-gru-sound.txt   |   2 +
 arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi       |   1 +
 sound/soc/rockchip/rk3399_gru_sound.c              | 129 ++++++++++++++-------
 3 files changed, 89 insertions(+), 43 deletions(-)

-- 
2.1.4
