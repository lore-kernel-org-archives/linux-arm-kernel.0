From: bibby.hsieh@mediatek.com (Bibby Hsieh)
Date: Mon, 14 May 2018 15:52:36 +0800
Subject: [PATCH v1 0/7] drm/mediatek: support hdmi output for mt2701 and mt7623
Message-ID: <20180514075243.5442-1-bibby.hsieh@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In order to support HDMI on mt2701,
we have to make some modifications.
1) Add the HDMI driver.
2) Add the DPI driver.
3) Add a mechanism that config output component by dts.

Changes since v0:
 - Correct some typos in commit message.
 - Fixup the build warning (tmp variable didn't be initialized)

Bibby Hsieh (3):
  drm/mediatek: implement connection from BLS to DPI0
  drm/mediatek: add a error return value when clock driver has been
    prepared
  drm/mediatek: config component output by device node port

chunhui dai (4):
  drm/mediatek: move dpi private data to device
  drm/mediatek: fix to get right bridge for dpi encoder
  drm/mediatek: add dpi driver for mt2701 and mt7623
  drm/mediatek: add hdmi driver for different hardware

 drivers/gpu/drm/mediatek/Makefile              |   4 +-
 drivers/gpu/drm/mediatek/mtk_dpi.c             | 125 +++++++---
 drivers/gpu/drm/mediatek/mtk_dpi_regs.h        |   2 +-
 drivers/gpu/drm/mediatek/mtk_drm_ddp.c         |  14 +-
 drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c    |   2 +-
 drivers/gpu/drm/mediatek/mtk_drm_drv.c         |  38 ++-
 drivers/gpu/drm/mediatek/mtk_drm_drv.h         |   4 +-
 drivers/gpu/drm/mediatek/mtk_hdmi.c            |  88 +++++--
 drivers/gpu/drm/mediatek/mtk_hdmi.h            |  28 +++
 drivers/gpu/drm/mediatek/mtk_hdmi_phy.c        | 157 +++++++++++++
 drivers/gpu/drm/mediatek/mtk_hdmi_regs.h       |   1 +
 drivers/gpu/drm/mediatek/mtk_mt2701_hdmi_phy.c | 307 +++++++++++++++++++++++++
 drivers/gpu/drm/mediatek/mtk_mt8173_hdmi_phy.c | 129 +----------
 13 files changed, 716 insertions(+), 183 deletions(-)
 create mode 100644 drivers/gpu/drm/mediatek/mtk_hdmi_phy.c
 create mode 100644 drivers/gpu/drm/mediatek/mtk_mt2701_hdmi_phy.c

-- 
2.12.5
