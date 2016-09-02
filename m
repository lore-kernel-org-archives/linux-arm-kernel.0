From: finley.xiao@rock-chips.com (Finley Xiao)
Date: Thu,  1 Sep 2016 20:16:53 -0700
Subject: [PATCH v5 0/4] nvmem: rockchip-efuse: support more rockchip SoCs
Message-ID: <1472786217-52214-1-git-send-email-finley.xiao@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As the timing and organization of efuse may be different                  
between rockchip SoCs, so their read function may be different.           
We add different device tree compatible string for rockchip SoCs          
to match their own read function.                                         
                                                                          
V4->V5:                                                                   
- 3/4 alter the efuse node name
- 4/4 align the macro definition
  disable clk if fail to allocate memory

Finley Xiao (4):
  nvmem: rockchip-efuse: update compatible strings for Rockchip efuse
  ARM: dts: rockchip: update compatible strings for Rockchip efuse
  arm64: dts: rockchip: add efuse0 device node for rk3399
  nvmem: rockchip-efuse: add rk3399-efuse support

 .../devicetree/bindings/nvmem/rockchip-efuse.txt   |  13 +-
 arch/arm/boot/dts/rk3066a.dtsi                     |   2 +-
 arch/arm/boot/dts/rk3188.dtsi                      |   2 +-
 arch/arm/boot/dts/rk3288.dtsi                      |   2 +-
 arch/arm64/boot/dts/rockchip/rk3399.dtsi           |  29 +++++
 drivers/nvmem/rockchip-efuse.c                     | 133 ++++++++++++++++++---
 6 files changed, 157 insertions(+), 24 deletions(-)

-- 
2.7.4
