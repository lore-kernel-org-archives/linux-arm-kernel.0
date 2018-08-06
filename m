From: stu.hsieh@mediatek.com (Stu Hsieh)
Date: Mon, 6 Aug 2018 19:58:07 +0800
Subject: [PATCH v3 00/13] Add RDMA memory mode support for mediatek SOC MT2712
Message-ID: <1533556700-26525-1-git-send-email-stu.hsieh@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series add RDMA memory mode support for mediatek SOC MT2712.
MT2712 has three display data path, including three HW engine,
two OVL and one RDMA.

The RDMA used in third ddp and it need to be set memory mode,
then RDMA could read data from memory and output to panel.

Change in v3:
- Merge patch
  "drm/mediatek: add memory mode for RDMA" and
  "drm/mediatek: add layer config to set RDMA for plane setting"
  to "drm/mediatek: add memory mode and layer_config for RDMA"
- Move the "RDMA memory mode setting" from rdma_config to
  rdma_layer_config in patch
  "drm/mediatek: add memory mode and layer_config for RDMA"
- Remove the pathch
  "drm/mediatek: add RDMA memory mode for crtc created"
- add the return statement in patch
  "drm/mediatek: add function to get layer number for component"
  to abvoid warning message in build time
- Return layer_nr is 4 in patch
  "drm/mediatek: add callback function to return OVL layer number"
- Return layer_nr is 1 in patch
  "drm/mediatek: add callback function to return RDMA layer number"
- Dynamaic define the size of planes by layer_nr in patch
  "drm/mediatek: use layer_nr function to get layer number to init plane"
- Use ?: to init crtc for OVL or RDMA in patch
  "drm/mediatek: use layer_nr function to get layer number to init plane"

Stu Hsieh (13):
  drm/mediatek: add connection from RDMA0 to DPI1
  drm/mediatek: add connection from RDMA0 to DSI1
  drm/mediatek: add connection from RDMA1 to DSI0
  drm/mediatek: add connection from RDMA2 to DSI0
  drm/mediatek: add memory mode and layer_config for RDMA
  drm/mediatek: add RGB color format support for RDMA
  drm/mediatek: add YUYV/UYVY color format support for RDMA
  drm/mediatek: add function to get layer number for component
  drm/mediatek: add callback function to return OVL layer number
  drm/mediatek: add callback function to return RDMA layer number
  drm/mediatek: use layer_nr function to get layer number to init plane
  drm/mediatek: update some variable name from ovl to comp
  drm/mediatek: fix connection from RDMA2 to DSI1

 drivers/gpu/drm/mediatek/mtk_disp_ovl.c     |  6 +++
 drivers/gpu/drm/mediatek/mtk_disp_rdma.c    | 83 +++++++++++++++++++++++++++++
 drivers/gpu/drm/mediatek/mtk_drm_crtc.c     | 63 +++++++++++++---------
 drivers/gpu/drm/mediatek/mtk_drm_crtc.h     |  3 +-
 drivers/gpu/drm/mediatek/mtk_drm_ddp.c      | 18 ++++++-
 drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h |  9 ++++
 6 files changed, 153 insertions(+), 29 deletions(-)

-- 
2.12.5.2.gbdf23ab
