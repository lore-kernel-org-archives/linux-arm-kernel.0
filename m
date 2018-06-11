From: stu.hsieh@mediatek.com (Stu Hsieh)
Date: Mon, 11 Jun 2018 11:25:52 +0800
Subject: [PATCH v5 00/28] Add support for mediatek SOC MT2712
Message-ID: <1528687580-549-1-git-send-email-stu.hsieh@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch add support for the Mediatek MT2712 DISP subsystem.
MT2712 is base on MT8173, there are some difference as following:
MT2712 support three disp output(two ovl and one rdma)

Change in v5:
- Keep the value of MAX_CONNECTOR, because it is useless
- Add the new patch for component DPI1
- Add the new patch for component DSI2
- Add the new patch for component DSI3
- Add some connection from RDMA0/RDMA1/RDMA2 to 
  DPI0/DPI1/DSI1/DSI2/DSI3
- Add the new patch about DPI1/DSI2/DSI3 support for mutex
- Add the new patch about DPI1/DSI1/DSI2/DSI3 in comp_init
- Change ddp path DSI2 to DSI3 in third path

Stu Hsieh (28):
  drm/mediatek: update dt-bindings for mt2712
  drm/mediatek: support maximum 64 mutex mod
  drm/mediatek: add ddp component AAL1
  drm/mediatek: add ddp component OD1
  drm/mediatek: add ddp component PWM1
  drm/mediatek: add ddp component PWM2
  drm/mediatek: add component DPI1
  drm/mediatek: add component DSI2
  drm/mediatek: add component DSI3
  drm/mediatek: add connection from OD1 to RDMA1
  drm/mediatek: add connection from RDMA0 to DPI0
  drm/mediatek: add connection from RDMA0 to DSI2
  drm/mediatek: add connection from RDMA0 to DSI3
  drm/mediatek: add connection from RDMA1 to DPI1
  drm/mediatek: add connection from RDMA1 to DSI1
  drm/mediatek: add connection from RDMA1 to DSI2
  drm/mediatek: add connection from RDMA1 to DSI3
  drm/mediatek: add connection from RDMA2 to DPI0
  drm/mediatek: add connection from RDMA2 to DPI1
  drm/mediatek: add connection from RDMA2 to DSI1
  drm/mediatek: add connection from RDMA2 to DSI2
  drm/mediatek: add connection from RDMA2 to DSI3
  drm/mediatek: add DPI1 support for mutex
  drm/mediatek: add DSI2 support for mutex
  drm/mediatek: add DSI3 support for mutex
  drm/mediatek: add DPI1/DSI1/DSI2/DSI3 in comp_init
  drm/mediatek: add third ddp path
  drm/mediatek: Add support for mediatek SOC MT2712

 .../bindings/display/mediatek/mediatek,disp.txt    |   2 +-
 drivers/gpu/drm/mediatek/mtk_drm_crtc.c            |   3 +
 drivers/gpu/drm/mediatek/mtk_drm_ddp.c             | 227 ++++++++++++++++++---
 drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c        |  15 +-
 drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h        |  10 +-
 drivers/gpu/drm/mediatek/mtk_drm_drv.c             |  47 ++++-
 drivers/gpu/drm/mediatek/mtk_drm_drv.h             |   5 +-
 7 files changed, 270 insertions(+), 39 deletions(-)

-- 
2.12.5
