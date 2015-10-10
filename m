From: zyw@rock-chips.com (Chris Zhong)
Date: Sat, 10 Oct 2015 17:55:20 +0800
Subject: [PATCH 00/10] Add mipi dsi support for rk3288
Message-ID: <1444470930-17150-1-git-send-email-zyw@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The rk3288 MIPI DSI is a Synopsys DesignWare MIPI DSI host controller
IP. This series adds support for a Synopsys DesignWare MIPI DSI host
controller DRM bridge driver and a rockchip MIPI DSI specific DRM
driver.

This series also includes a DRM panel driver for BOE TV080WUM-NL0 panel.
This panel only use the MIPI DSI video mode.

The MIPI DSI feature is tested on rk3288 evb board, backport them to
chrome os kernel v3.14, and it can display normally.

This patchset is base on the patchset from Ying.liu at freescale.com.
<http://www.spinics.net/lists/dri-devel/msg77181.html>



Chris Zhong (8):
  clk: rockchip: Add sclk_mipidsi_24m for mipi dsi
  drm/rockchip: return a true clock rate to adjusted_mode
  drm/bridge: Add Synopsys DesignWare MIPI DSI host controller driver
  drm: rockchip: Support Synopsys DesignWare MIPI DSI host controller
  Documentation: dt-bindings: Add bindings for rk3288 DW MIPI DSI driver
  ARM: dts: rockchip: add rk3288 mipi_dsi nodes
  drm/panel: simple: Add support for BOE TV080WUM-NL0
  ARM: dts: rockchip: add support mipi panel tv080wum-nl0 for rk3288-evb

Liu Ying (2):
  drm/dsi: Add a helper to get bits per pixel of MIPI DSI pixel format
  Documentation: dt-bindings: Add bindings for Synopsys DW MIPI DSI DRM
    bridge driver

 .../devicetree/bindings/drm/bridge/dw_mipi_dsi.txt |   76 ++
 .../bindings/video/dw_mipi_dsi_rockchip.txt        |   56 ++
 arch/arm/boot/dts/rk3288-evb.dtsi                  |   20 +-
 arch/arm/boot/dts/rk3288.dtsi                      |   39 +
 drivers/clk/rockchip/clk-rk3288.c                  |    2 +-
 drivers/gpu/drm/bridge/Kconfig                     |   10 +
 drivers/gpu/drm/bridge/Makefile                    |    1 +
 drivers/gpu/drm/bridge/dw_mipi_dsi.c               | 1055 ++++++++++++++++++++
 drivers/gpu/drm/panel/panel-simple.c               |   33 +
 drivers/gpu/drm/rockchip/Kconfig                   |   10 +
 drivers/gpu/drm/rockchip/Makefile                  |    1 +
 drivers/gpu/drm/rockchip/dw_mipi_dsi_rockchip.c    |  249 +++++
 drivers/gpu/drm/rockchip/rockchip_drm_vop.c        |    9 +
 include/drm/bridge/dw_mipi_dsi.h                   |   27 +
 include/drm/drm_mipi_dsi.h                         |   14 +
 include/dt-bindings/clock/rk3288-cru.h             |    1 +
 16 files changed, 1601 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/drm/bridge/dw_mipi_dsi.txt
 create mode 100644 Documentation/devicetree/bindings/video/dw_mipi_dsi_rockchip.txt
 create mode 100644 drivers/gpu/drm/bridge/dw_mipi_dsi.c
 create mode 100644 drivers/gpu/drm/rockchip/dw_mipi_dsi_rockchip.c
 create mode 100644 include/drm/bridge/dw_mipi_dsi.h

-- 
2.6.1
