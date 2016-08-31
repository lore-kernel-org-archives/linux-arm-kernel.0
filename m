From: wxt@rock-chips.com (Caesar Wang)
Date: Thu,  1 Sep 2016 07:28:47 +0800
Subject: [PATCH v3 0/5] Support the rk3399 gmac pd function
Message-ID: <1472686132-27827-1-git-send-email-wxt@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch add to handle the gmac pd, and support
the rk3399 gmac for devicetree.

The History version:

v1: https://lkml.org/lkml/2016/8/30/668
v2: https://lkml.org/lkml/2016/8/31/27


Changes in v3:
- leave into two patches based on patchv2, and fix nits and commit, as
  comment on https://patchwork.kernel.org/patch/9306339/
- generate a patch from https://patchwork.kernel.org/patch/9306339/.

Changes in v2:
- rk_gmac_powerup instead of the rk_gmac_init.
- fixes the build error on next kernel.
- Fixes the order, ss Heiko commnets on
  https://patchwork.kernel.org/patch/9305991/

Caesar Wang (3):
  arm64: dts: rockchip: add the gmac power domain on rk3399
  arm64: dts: rockchip: add the gmac needed node for rk3399
  arm64: dts: rockchip: enable the gmac for rk3399 evb board

David Wu (1):
  net: stmmac: dwmac-rk: add pd_gmac support for rk3399

Roger Chen (1):
  net: stmmac: dwmac-rk: fixes the gmac resume after PD on/off

 arch/arm64/boot/dts/rockchip/rk3399-evb.dts    | 31 +++++++++
 arch/arm64/boot/dts/rockchip/rk3399.dtsi       | 90 ++++++++++++++++++++++++++
 drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c | 28 +++++---
 3 files changed, 140 insertions(+), 9 deletions(-)

-- 
1.9.1
