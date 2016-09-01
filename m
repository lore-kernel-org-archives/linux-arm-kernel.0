From: wxt@rock-chips.com (Caesar Wang)
Date: Fri,  2 Sep 2016 01:49:58 +0800
Subject: [PATCH v4 0/6] Support the rk3399 gmac and pd function
Message-ID: <1472752204-8924-1-git-send-email-wxt@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch have the following changes:

7edf13e net: stmmac: dwmac-rk: add rk3366 & rk3399 specific data
26e004e net: stmmac: dwmac-rk: fixes the gmac resume after PD on/off
b216c2f net: stmmac: dwmac-rk: add pd_gmac support for rk3399
848bb71 arm64: dts: rockchip: add the gmac power domain on rk3399
508e41f arm64: dts: rockchip: add the gmac needed node for rk3399
fb26795 arm64: dts: rockchip: enable the gmac for rk3399 evb board

Hi David,
The patch 1,2,3 is related to the rockchip net/stammc driver,

Hi Heiko,
The patch 4,5,6 is related to the dts changes.

The History version:

v1: https://lkml.org/lkml/2016/8/30/668
v2: https://lkml.org/lkml/2016/8/31/27
v3: https://lkml.org/lkml/2016/8/31/981

Thanks your reviewing!

-
Caesar


Changes in v4:
- Fixes from the original patch on https://patchwork.kernel.org/patch/9274557/
- remove the Roger signed-off for domain patch.
- The Roger had posted patch on https://patchwork.kernel.org/patch/9274561/.
- re-fixup to original author.

Changes in v3:
- leave into two patches based on patchv2, and fix nits and commit, as
  comment on https://patchwork.kernel.org/patch/9306339/
- generate a patch from https://patchwork.kernel.org/patch/9306339/.

Changes in v2:
- rk_gmac_powerup instead of the rk_gmac_init.
- fixes the build error on next kernel.
- Fixes the order, ss Heiko commnets on
  https://patchwork.kernel.org/patch/9305991/

Caesar Wang (1):
  arm64: dts: rockchip: add the gmac power domain on rk3399

David Wu (1):
  net: stmmac: dwmac-rk: add pd_gmac support for rk3399

Roger Chen (4):
  net: stmmac: dwmac-rk: add rk3366 & rk3399 specific data
  net: stmmac: dwmac-rk: fixes the gmac resume after PD on/off
  arm64: dts: rockchip: add the gmac needed node for rk3399
  arm64: dts: rockchip: enable the gmac for rk3399 evb board

 .../devicetree/bindings/net/rockchip-dwmac.txt     |   8 +-
 arch/arm64/boot/dts/rockchip/rk3399-evb.dts        |  31 +++
 arch/arm64/boot/dts/rockchip/rk3399.dtsi           |  90 ++++++++
 drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c     | 254 ++++++++++++++++++++-
 4 files changed, 372 insertions(+), 11 deletions(-)

-- 
1.9.1
