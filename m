From: john@metanate.com (John Keeping)
Date: Sat, 21 Jan 2017 16:31:02 +0000
Subject: [PATCH v2 00/26] drm/rockchip: MIPI fixes & improvements
Message-ID: <20170121163128.22240-1-john@metanate.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is a re-roll of a series originally posted back in September [1].
It's mostly unchanged but in response to Chris and Mark's feedback I have
dropped the first two patches and replaces them with the new patches 3
and 4; it's a slightly different approach from Mark's suggestion because
it turns out that we only use the mode in the enable function and it is
safe to read from the connector state there.

[1] https://www.spinics.net/lists/arm-kernel/msg532931.html

John Keeping (26):
  drm/rockchip: dw-mipi-dsi: don't configure hardware in mode_set for
    MIPI
  drm/rockchip: dw-mipi-dsi: rename commit hook to enable
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
  drm/rockchip: dw-mipi-dsi: configure bias and bandgap before enable
  drm/rockchip: dw-mipi-dsi: don't enable PHY PLL until it's configured
  drm/rockchip: dw-mipi-dsi: properly configure PHY timing
  drm/rockchip: dw-mipi-dsi: improve PLL configuration
  drm/rockchip: dw-mipi-dsi: use specific poll helper
  drm/rockchip: dw-mipi-dsi: use positive check for N{H,V}SYNC
  drm/rockchip: vop: test for P{H,V}SYNC
  drm/rockchip: dw-mipi-dsi: defer probe if panel is not loaded
  drm/rockchip: dw-mipi-dsi: support non-burst modes
  drm/rockchip: dw-mipi-dsi: add reset control
  drm/rockchip: dw-mipi-dsi: support read commands

 drivers/gpu/drm/rockchip/dw-mipi-dsi.c      | 341 +++++++++++++++++++---------
 drivers/gpu/drm/rockchip/rockchip_drm_vop.c |   4 +-
 2 files changed, 239 insertions(+), 106 deletions(-)

-- 
2.11.0.197.gb556de5.dirty
