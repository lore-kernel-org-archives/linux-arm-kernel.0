From: finley.xiao@rock-chips.com (Finlye Xiao)
Date: Thu, 11 Aug 2016 09:13:45 +0800
Subject: [PATCH v2 0/4] nvmem: rockchip-efuse: support more rockchip SoCs
Message-ID: <1470878029-11878-1-git-send-email-finley.xiao@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Finley Xiao <finley.xiao@rock-chips.com>

As the timing and organization of efuse may be different
between rockchip SoCs, so their read function mya be different.
We add different device tree compatible string for rockchip SoCs
to match their own read function.

V1->V2:
- 1/4 add a "Deprecated properties" section
- 4/4 keep the rockchip,rockchip-efuse around and restore the order of
  initcall

Finley Xiao (4):
  nvmem: rockchip-efuse: update compatible strings for Rockchip efuse
  ARM: dts: rockchip: update compatible strings for Rockchip efuse
  arm64: dts: rockchip: add efuse0 device node for rk3399
  nvmem: rockchip-efuse: add rk3399-efuse support

 .../devicetree/bindings/nvmem/rockchip-efuse.txt   |  13 ++-
 arch/arm/boot/dts/rk3066a.dtsi                     |   2 +-
 arch/arm/boot/dts/rk3188.dtsi                      |   2 +-
 arch/arm/boot/dts/rk3288.dtsi                      |   2 +-
 arch/arm64/boot/dts/rockchip/rk3399.dtsi           |  29 +++++
 drivers/nvmem/rockchip-efuse.c                     | 130 ++++++++++++++++++---
 6 files changed, 154 insertions(+), 24 deletions(-)

-- 
1.9.1
