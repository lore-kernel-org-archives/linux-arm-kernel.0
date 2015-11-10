From: sugar.zhang@rock-chips.com (Sugar Zhang)
Date: Tue, 10 Nov 2015 15:32:06 +0800
Subject: [PATCH 0/3] ASoC: rockchip: i2s: compatible with different chips
Message-ID: <1447140729-18267-1-git-send-email-sugar.zhang@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

there maybe more than one i2s module inside chip, and these i2s modules
have different channels features.

for example: there are 3 i2s in rk3066, one support 8 channels playback
and 2 channels capture, but the others only support 2 channels playback
and 2 channels capture.

in order to compatible with these various chips, we add playback and
capture property to specify these values.

there are default channels configuration in driver: 8 channels playback
and 2 channels capture. if not add property, we use the default values.

Sugar Zhang (3):
  ASoC: rockchip: i2s: compatible with different chips
  ASoC: rockchip: add playback property
  ARM: dts: rockchip: add channels properties for i2s

 .../devicetree/bindings/sound/rockchip-i2s.txt       |  2 ++
 arch/arm/boot/dts/rk3066a.dtsi                       |  6 ++++++
 arch/arm/boot/dts/rk3188.dtsi                        |  2 ++
 arch/arm/boot/dts/rk3288.dtsi                        |  2 ++
 sound/soc/rockchip/rockchip_i2s.c                    | 20 +++++++++++++++-----
 5 files changed, 27 insertions(+), 5 deletions(-)

-- 
2.3.6
