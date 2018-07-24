From: stu.hsieh@mediatek.com (Stu Hsieh)
Date: Tue, 24 Jul 2018 16:17:00 +0800
Subject: [PATCH v1 00/15] Add RDMA memory mode support for mediatek SOC MT2712
Message-ID: <1532420235-22268-1-git-send-email-stu.hsieh@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series add RDMA memory mode support for mediatek SOC MT2712.
MT2712 has three display data path, including three HW engine,
two OVL and one RDMA.

The RDMA used in third ddp and it need to be set memory mode,
then RDMA could read data from memory and output to panel.

Stu Hsieh (15):
  drm/mediatek: add connection from RDMA0 to DPI1
  drm/mediatek: add connection from RDMA0 to DSI1
  drm/mediatek: add connection from RDMA1 to DSI0
  drm/mediatek: add connection from RDMA2 to DSI0
  drm/mediatek: add RDMA memory mode for crtc created
  drm/mediatek: add memory mode for RDMA
  drm/mediatek: add layer config to set RDMA for plane setting
  drm/mediatek: add RGB color format support for RDMA
  drm/mediatek: add YUYV/UYVY color format support for RDMA
  drm/mediatek: add drm_device in RDMA for mamory mode to reaquest
    buffer
  drm/mediatek: add dummy buffer for RDMA memory mode
  drm/mediatek: add layer number condition for RDMA to control plane
  drm/mediatek: Update some variable name from ovl to comp
  drm/mediatek: fixed the error value for add DSI1 in mutex
  drm/mediatek: fixed connection from RDMA2 to DSI1

 drivers/gpu/drm/mediatek/mtk_disp_rdma.c    | 122 +++++++++++++++++++++++++++-
 drivers/gpu/drm/mediatek/mtk_drm_crtc.c     |  59 +++++++++-----
 drivers/gpu/drm/mediatek/mtk_drm_crtc.h     |   4 +-
 drivers/gpu/drm/mediatek/mtk_drm_ddp.c      |  20 ++++-
 drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h |   2 +
 5 files changed, 181 insertions(+), 26 deletions(-)

-- 
2.12.5
