From: john@metanate.com (John Keeping)
Date: Sun, 29 Jan 2017 13:24:20 +0000
Subject: [PATCH v3 00/24] drm/rockchip: MIPI fixes & improvements
Message-ID: <20170129132444.25251-1-john@metanate.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This re-roll mostly just gather up reviewed-by tags, although I have
also wrapped some long lines and squashed together some commits as
suggested by Chris Zhong.

Version 2 was posted here:
https://www.spinics.net/lists/arm-kernel/msg556683.html

John Keeping (24):
  drm/rockchip: dw-mipi-dsi: don't configure hardware in mode_set for
    MIPI
  drm/rockchip: dw-mipi-dsi: pass mode in where needed
  drm/rockchip: dw-mipi-dsi: remove mode_set hook
  drm/rockchip: dw-mipi-dsi: fix command header writes
  drm/rockchip: dw-mipi-dsi: fix generic packet status check
  drm/rockchip: dw-mipi-dsi: avoid out-of-bounds read on tx_buf
  drm/rockchip: dw-mipi-dsi: include bad value in error message
  drm/rockchip: dw-mipi-dsi: respect message flags
  drm/rockchip: dw-mipi-dsi: only request HS clock when required
  drm/rockchip: dw-mipi-dsi: don't assume buffer is aligned
  drm/rockchip: dw-mipi-dsi: prepare panel after phy init
  drm/rockchip: dw-mipi-dsi: allow commands in panel_disable
  drm/rockchip: dw-mipi-dsi: fix escape clock rate
  drm/rockchip: dw-mipi-dsi: ensure PHY is reset
  drm/rockchip: dw-mipi-dsi: configure PHY before enabling
  drm/rockchip: dw-mipi-dsi: properly configure PHY timing
  drm/rockchip: dw-mipi-dsi: improve PLL configuration
  drm/rockchip: dw-mipi-dsi: use specific poll helper
  drm/rockchip: dw-mipi-dsi: use positive check for N{H,V}SYNC
  drm/rockchip: vop: test for P{H,V}SYNC
  drm/rockchip: dw-mipi-dsi: defer probe if panel is not loaded
  drm/rockchip: dw-mipi-dsi: support non-burst modes
  drm/rockchip: dw-mipi-dsi: add reset control
  drm/rockchip: dw-mipi-dsi: support read commands

 drivers/gpu/drm/rockchip/dw-mipi-dsi.c      | 348 +++++++++++++++++++---------
 drivers/gpu/drm/rockchip/rockchip_drm_vop.c |   4 +-
 2 files changed, 245 insertions(+), 107 deletions(-)

-- 
2.11.0.197.gb556de5.dirty
