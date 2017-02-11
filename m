From: plaes@plaes.org (Priit Laes)
Date: Sat, 11 Feb 2017 19:43:57 +0200
Subject: [PATCH 0/8] drm/sun4i: Add basic LVDS support for A10
Message-ID: <20170211174405.28395-1-plaes@plaes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series adds initial LVDS functionality for A10 SoC and includes
display blocks (TCON, backend and frontend) for A10 dtsi and implements 
of mode property for TCON to allow switching between rgb/lvds output.

This series has been tested on Gemei G9 A10 tablet, but still relies
on u-boot to properly set up LVDS reset controller.

---

Jonathan Liu (1):
  ARM: sunxi_defconfig: Enable simple panel

Priit Laes (7):
  ARM: sun4i: Add display blocks for the sun4i dtsi.
  drm/panel: simple: Add support for LG LP097x02-slq2 panel
  drm/sun4i: Add optional 'mode' property to TCON
  drm/sun4i: Add encoder type argument to sun4i_tcon0_mode_set
  drm/sun4i: Add initial LVDS stub
  drm/sun4i: Add various bits and pieces to enable LVDS support on sun4i
  ARM: dts: sun4i: gemei-g9: Add LVDS display support

 .../bindings/display/sunxi/sun4i-drm.txt           |   3 +
 arch/arm/boot/dts/sun4i-a10-gemei-g9.dts           |  95 ++++++-
 arch/arm/boot/dts/sun4i-a10.dtsi                   | 104 ++++++++
 arch/arm/configs/sunxi_defconfig                   |   4 +
 drivers/gpu/drm/panel/panel-simple.c               |  25 ++
 drivers/gpu/drm/sun4i/Makefile                     |   1 +
 drivers/gpu/drm/sun4i/sun4i_lvds.c                 | 276 +++++++++++++++++++++
 drivers/gpu/drm/sun4i/sun4i_lvds.h                 |  15 ++
 drivers/gpu/drm/sun4i/sun4i_rgb.c                  |   2 +-
 drivers/gpu/drm/sun4i/sun4i_tcon.c                 |  57 ++++-
 drivers/gpu/drm/sun4i/sun4i_tcon.h                 |  18 +-
 11 files changed, 580 insertions(+), 20 deletions(-)
 create mode 100644 drivers/gpu/drm/sun4i/sun4i_lvds.c
 create mode 100644 drivers/gpu/drm/sun4i/sun4i_lvds.h

-- 
2.9.3
