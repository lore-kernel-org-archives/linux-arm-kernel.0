From: stu.hsieh@mediatek.com (Stu Hsieh)
Date: Fri, 3 Aug 2018 11:10:53 +0800
Subject: [PATCH v2 00/15] Add RDMA memory mode support for mediatek SOC MT2712
Message-ID: <1533265868-28110-1-git-send-email-stu.hsieh@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series add RDMA memory mode support for mediatek SOC MT2712.
MT2712 has three display data path, including three HW engine,
two OVL and one RDMA.

The RDMA used in third ddp and it need to be set memory mode,
then RDMA could read data from memory and output to panel.

Change in v2:
- Remove some modification about dummy buffer in patch
  "drm/mediatek: add memory mode for RDMA":
  Register setting about reset and MATRIX_INT_MTX_SEL_DEFAULT.
- Remove some patches about dummy buffer as folowing:
  "drm/mediatek: add drm_device in RDMA for mamory mode to reaquest buffer"
  "drm/mediatek: add dummy buffer for RDMA memory mode"
- Rename and modify the v1 patch
  "drm/mediatek: add layer number condition for RDMA to control plane"
  as following patches to get the layer number by module.
  "drm/mediatek: add function to get layer number for component"
  "drm/mediatek: add callback function to return OVL layer number"
  "drm/mediatek: add callback function to return RDMA layer number"
  "drm/mediatek: use layer_nr function to get layer number to init plane"
- Remove v1 patch
  "drm/mediatek: fixed the error value for add DSI1 in mutex"
  This patch would be send in the future.

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
  drm/mediatek: add function to get layer number for component
  drm/mediatek: add callback function to return OVL layer number
  drm/mediatek: add callback function to return RDMA layer number
  drm/mediatek: use layer_nr function to get layer number to init plane
  drm/mediatek: update some variable name from ovl to comp
  drm/mediatek: fix connection from RDMA2 to DSI1

 drivers/gpu/drm/mediatek/mtk_disp_ovl.c     | 10 +++
 drivers/gpu/drm/mediatek/mtk_disp_rdma.c    | 99 ++++++++++++++++++++++++++++-
 drivers/gpu/drm/mediatek/mtk_drm_crtc.c     | 60 +++++++++++------
 drivers/gpu/drm/mediatek/mtk_drm_crtc.h     |  4 +-
 drivers/gpu/drm/mediatek/mtk_drm_ddp.c      | 18 +++++-
 drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h |  8 +++
 6 files changed, 174 insertions(+), 25 deletions(-)

-- 
2.12.5.2.gbdf23ab
