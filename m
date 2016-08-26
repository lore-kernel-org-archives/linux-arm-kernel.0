From: finley.xiao@rock-chips.com (Finley Xiao)
Date: Fri, 26 Aug 2016 00:36:28 -0700
Subject: [PATCH v3 0/3] nvmem: rockchip-efuse: support more rockchip SoCs
Message-ID: <1472196991-8529-1-git-send-email-finley.xiao@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As the timing and organization of efuse may be different
between rockchip SoCs, so their read function may be different.
We add different device tree compatible string for rockchip SoCs
to match their own read function.
 
V2->V3:
- delete patch 3/4 in v2, don't add efuse0 device node
- 3/3 fix read data error sometimes by disable efuse redundancy

Finley Xiao (3):
  nvmem: rockchip-efuse: update compatible strings for Rockchip efuse
  ARM: dts: rockchip: update compatible strings for Rockchip efuse
  nvmem: rockchip-efuse: add rk3399-efuse support

 .../devicetree/bindings/nvmem/rockchip-efuse.txt   |  13 +-
 arch/arm/boot/dts/rk3066a.dtsi                     |   2 +-
 arch/arm/boot/dts/rk3188.dtsi                      |   2 +-
 arch/arm/boot/dts/rk3288.dtsi                      |   2 +-
 drivers/nvmem/rockchip-efuse.c                     | 131 ++++++++++++++++++---
 5 files changed, 126 insertions(+), 24 deletions(-)

-- 
1.9.1
