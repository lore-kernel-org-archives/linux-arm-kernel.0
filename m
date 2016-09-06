From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue,  6 Sep 2016 16:46:11 +0200
Subject: [PATCH v2 0/9] drm/sun4i: Introduce A33 display driver
Message-ID: <20160906144620.6322-1-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi everyone,

This serie introduces the support in the sun4i-drm driver for the A33.

Beside the new IPs and special cases for the A33 new IPs, there's
nothing really outstanding, and is now at feature parity with the A13.

This serie is based on my A33 CCU patches posted earlier today here:
http://lists.infradead.org/pipermail/linux-arm-kernel/2016-September/453208.html

Let me know what you think,
Maxime

Changes from v1:
  - Changed the TCON pins label
  - Changed the TCON compatible as it's different from A23's
  - Merged the SAT into the backend, as it really is part of the same
    block in hardware.
  - Reworded the DRC bindings description
  - Added the backend interrupt to the DT
  - Changed the name of the LCD panel to the actual brand and model
    found on the ribbon

Maxime Ripard (9):
  drm/sun4i: support TCONs without channel 1
  drm/sun4i: support A33 tcon
  drm/sun4i: backend: Handle the SAT
  drm/sun4i: Add a DRC driver
  of: Add vendor prefix for Netron DY
  drm/panel: Add Netron DY E231732
  ARM: sun8i: a33: Add display pipeline
  ARM: sun8i: a23/a33: Add RGB666 pins
  ARM: sun8i: sina33: Enable display

 .../bindings/display/sunxi/sun4i-drm.txt           |  39 +++++-
 .../devicetree/bindings/vendor-prefixes.txt        |   1 +
 arch/arm/boot/dts/sun8i-a23-a33.dtsi               |  10 ++
 arch/arm/boot/dts/sun8i-a33-sinlinx-sina33.dts     |  34 +++++
 arch/arm/boot/dts/sun8i-a33.dtsi                   | 152 +++++++++++++++++++++
 drivers/gpu/drm/panel/panel-simple.c               |  26 ++++
 drivers/gpu/drm/sun4i/Makefile                     |   2 +-
 drivers/gpu/drm/sun4i/sun4i_backend.c              |  61 +++++++++
 drivers/gpu/drm/sun4i/sun4i_backend.h              |   3 +
 drivers/gpu/drm/sun4i/sun4i_drv.c                  |   8 +-
 drivers/gpu/drm/sun4i/sun4i_tcon.c                 |  42 ++++--
 drivers/gpu/drm/sun4i/sun4i_tcon.h                 |   2 +
 drivers/gpu/drm/sun4i/sun6i_drc.c                  | 118 ++++++++++++++++
 13 files changed, 479 insertions(+), 19 deletions(-)
 create mode 100644 drivers/gpu/drm/sun4i/sun6i_drc.c

-- 
2.9.3
