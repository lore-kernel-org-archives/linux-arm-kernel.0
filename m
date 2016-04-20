From: mark.yao@rock-chips.com (Mark Yao)
Date: Wed, 20 Apr 2016 14:18:12 +0800
Subject: =?UTF-8?q?=5BPATCH=20v2=200/5=5D=20drm/rockchip=3A=20add=20rk3399=20display=20controller=20support?=
Message-ID: <1461133097-1478-1-git-send-email-mark.yao@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series of patches add support for rk3399 display crontroller(vop),

there are two VOP in rk3399 chip, respectively VOP_BIG and VOP_LIT.
most registers layout of this two vop is same, their framework are both
VOP_FULL, the differences of this two is VOP_LIT cut off some features.

Those patches tested on rk3399 evb board.

Changes in v2:
- sort the registers and vop compatible name
- spilt VOP_REG_MASK into a single patch
- make rk3399 vop documentation more readable(Heiko St?bner)

Mark Yao (5):
  drm/rockchip: sort registers define by chip's number
  dt-bindings: sort Rockchip vop compatible by chip's number
  drm/rockchip: vop: introduce VOP_REG_MASK
  drm/rockchip: vop: add rk3399 vop support
  dt-bindings: add documentation for Rockchip rk3399 display
    controllers

 .../bindings/display/rockchip/rockchip-vop.txt     |    7 +-
 drivers/gpu/drm/rockchip/rockchip_drm_vop.c        |   60 +++--
 drivers/gpu/drm/rockchip/rockchip_drm_vop.h        |    5 +
 drivers/gpu/drm/rockchip/rockchip_vop_reg.c        |  236 ++++++++++++-----
 drivers/gpu/drm/rockchip/rockchip_vop_reg.h        |  279 +++++++++++++++++---
 5 files changed, 447 insertions(+), 140 deletions(-)

-- 
1.7.9.5
