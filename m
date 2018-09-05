From: bibby.hsieh@mediatek.com (Bibby Hsieh)
Date: Wed, 5 Sep 2018 16:31:33 +0800
Subject: [PATCH v2 00/13] drm/mediatek: support hdmi output for mt2701 and
 mt7623
Message-ID: <20180905083146.14727-1-bibby.hsieh@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In order to support HDMI on mt2701,
we have to make some modifications.
1) Add the HDMI driver.
2) Add the DPI driver.
3) Add a mechanism that config output component by dts.

Changes since v1:
 - Separate some patches to independent patch.
 - add DISP_REG_CONFIG_DSI_SEL and DISP_REG_CONFIG_DPI_SEL
   configuration in the condition of BLS&DPI0 connection.

Changes since v0:
 - Correct some typos in commit message.
 - Fixup the build warning (tmp variable didn't be initialized)

Bibby Hsieh (3):
  drm/mediatek: implement connection from BLS to DPI0
  drm/mediatek: add a error return value when clock driver has been
    prepared
  drm/mediatek: config component output by device node port

chunhui dai (10):
  drm/mediatek: add refcount for DPI power on/off
  drm/mediatek: move hardware register to node data
  drm/mediatek: adjust EDGE to match clock and data
  drm/mediatek: add clock factor for different IC
  drm/mediatek: dpi use new API for finding bridge
  drm/mediatek: add dpi driver for mt2701 and mt7623
  drm/mediatek: separae hdmi phy to different file
  drm/mediatek: register hdmi codec more earlier
  drm/mediatek: add support for SPDIF audio in HDMI
  drm/mediatek: add hdmi driver for MT2701 and MT7623

 drivers/gpu/drm/mediatek/Makefile              |  16 +-
 drivers/gpu/drm/mediatek/mtk_dpi.c             | 123 +++++++---
 drivers/gpu/drm/mediatek/mtk_dpi_regs.h        |   2 +-
 drivers/gpu/drm/mediatek/mtk_drm_ddp.c         |  19 +-
 drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c    |   2 +-
 drivers/gpu/drm/mediatek/mtk_drm_drv.c         |  39 +++-
 drivers/gpu/drm/mediatek/mtk_drm_drv.h         |   4 +-
 drivers/gpu/drm/mediatek/mtk_hdmi.c            |  51 ++--
 drivers/gpu/drm/mediatek/mtk_hdmi.h            |  27 +++
 drivers/gpu/drm/mediatek/mtk_hdmi_phy.c        | 157 +++++++++++++
 drivers/gpu/drm/mediatek/mtk_mt2701_hdmi_phy.c | 307 +++++++++++++++++++++++++
 drivers/gpu/drm/mediatek/mtk_mt8173_hdmi_phy.c | 129 +----------
 12 files changed, 690 insertions(+), 186 deletions(-)
 create mode 100644 drivers/gpu/drm/mediatek/mtk_hdmi_phy.c
 create mode 100644 drivers/gpu/drm/mediatek/mtk_mt2701_hdmi_phy.c

-- 
2.12.5.2.gbdf23ab
