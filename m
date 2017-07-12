From: mark.yao@rock-chips.com (Mark Yao)
Date: Wed, 12 Jul 2017 10:03:11 +0800
Subject: [PATCH v2 0/5] drm/rockchip: add all full framework vop support
Message-ID: <1499824991-7391-1-git-send-email-mark.yao@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These patches try to make all current rockchip full framework vop works
on drm, The newer vop design always have some different to the old one,
So we add a register verify mechanism to distinguish those register, then
the registers table can be reused.

And people can easy to know the different for the vops from register table.

Tested on rk3399 evb board.

Changes in v2:
- rename rk322x to rk3228(Heiko St?bner)
- correct some vop registers define

Mark Yao (5):
  drm/rockchip: vop: get rid of register init table
  drm/rockchip: vop: support verify registers with vop version
  drm/rockchip: vop: move line_flag_num to interrupt registers
  drm/rockchip: vop: add a series of vop support
  dt-bindings: display: fill Documents for series of vop

 .../bindings/display/rockchip/rockchip-vop.txt     |   4 +
 drivers/gpu/drm/rockchip/rockchip_drm_vop.c        |  74 +-
 drivers/gpu/drm/rockchip/rockchip_drm_vop.h        |  32 +-
 drivers/gpu/drm/rockchip/rockchip_vop_reg.c        | 263 +++---
 drivers/gpu/drm/rockchip/rockchip_vop_reg.h        | 905 ++++++++++++++++-----
 5 files changed, 956 insertions(+), 322 deletions(-)

-- 
1.9.1
