From: stu.hsieh@mediatek.com (stu.hsieh at mediatek.com)
Date: Fri, 25 May 2018 10:34:17 +0800
Subject: [PATCH v3 0/8] Add support for mediatek SOC MT2712
Message-ID: <1527215665-11937-1-git-send-email-stu.hsieh@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stu Hsieh <stu.hsieh@mediatek.com>

This patch add support for the Mediatek MT2712 DISP subsystem.
MT2712 is base on MT8173, there are some difference as following:
MT2712 support three disp output(two ovl and one rdma)

Change in v3:
- Added patch for ddp component AAL1
- Added patch for ddp component OD1
- Added patch for ddp component PWM2
- Added patch to create third ddp path
- Rebase patch "support maximum 64 mutex mod" before
  "Add support for mediatek SOC MT2712"
- Rebase patch "add connection from OD1 to RDMA1" before
  "Add support for mediatek SOC MT2712"
- Remove two definition about RDMA0 and RDMA2
- Change the definition about mutex module from
  bitwise to index

Changes in v2:
- update dt-bindings for mt2712
- Added patch to connection from OD1 to RDMA1
- Added patch to support maximum 64 mutex mod
- rewrite mutex mod condition for reducing one byte
- Change the component name AAL/OD to AAL0/OD0 for naming consistency
- Move the compatible infomation about dpi to other patch which modify
  the dpi driver for mt2712


Stu Hsieh (8):
  drm/mediatek: update dt-bindings for mt2712
  drm/mediatek: support maximum 64 mutex mod
  drm/mediatek: add connection from OD1 to RDMA1
  drm/mediatek: add ddp component AAL1
  drm/mediatek: add ddp component OD1
  drm/mediatek: add ddp component PWM2
  drm/mediatek: Add support for mediatek SOC MT2712
  drm/mediatek: add third ddp path

 .../bindings/display/mediatek/mediatek,disp.txt    |   2 +-
 drivers/gpu/drm/mediatek/mtk_drm_ddp.c             | 124 +++++++++++++++------
 drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c        |   8 +-
 drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h        |   7 +-
 drivers/gpu/drm/mediatek/mtk_drm_drv.c             |  47 +++++++-
 drivers/gpu/drm/mediatek/mtk_drm_drv.h             |   7 +-
 6 files changed, 155 insertions(+), 40 deletions(-)

-- 
2.12.5
