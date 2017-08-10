From: jeffy.chen@rock-chips.com (Jeffy Chen)
Date: Thu, 10 Aug 2017 12:54:55 +0800
Subject: [PATCH v2 0/3] ASoC: rockchip: Parse dai links from dts
Message-ID: <1502340898-28403-1-git-send-email-jeffy.chen@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Currently we are using a fixed list of dai links in the driver.
This serial of patches would let the driver parse dai links from
dts, so that we can disable some of them for future boards in the
dts.

Tested on my chromebook bob(with cros 4.4 kernel), it still works
after disabled rt5514 codec in the dts.


Changes in v2:
Let rockchip,codec-names be a required property, because we plan to
add more supported codecs to the fixed dai link list in the driver.
Let rockchip,codec-names be a required property.

Jeffy Chen (3):
  ASoC: rockchip: Parse dai links from dts
  arm64: dts: rockchip: Add rockchip,codec-names property
  dt-bindings: ASoC: rockchip: Add rockchip,codec-names property

 .../bindings/sound/rockchip,rk3399-gru-sound.txt   |   2 +
 arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi       |   1 +
 sound/soc/rockchip/rk3399_gru_sound.c              | 125 +++++++++++++--------
 3 files changed, 84 insertions(+), 44 deletions(-)

-- 
2.1.4
