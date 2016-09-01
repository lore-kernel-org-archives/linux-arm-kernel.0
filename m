From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu,  1 Sep 2016 17:31:57 +0200
Subject: [PATCH 0/7] drm/sun4i: Introduce A33 display driver
Message-ID: <20160901153204.11217-1-maxime.ripard@free-electrons.com>
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

Maxime Ripard (7):
  drm/sun4i: support TCONs without channel 1
  drm/sun4i: support A33 tcon
  drm/sun4i: Add SAT and DRC drivers
  drm/panel: Add Sinlinx SinA33 7" panel
  ARM: sun8i: a33: Add display pipeline
  ARM: sun8i: a33: Add RGB666 pins
  ARM: sun8i: sina33: Enable display

 .../bindings/display/sunxi/sun4i-drm.txt           |  44 ++++-
 arch/arm/boot/dts/sun8i-a33-sinlinx-sina33.dts     |  34 ++++
 arch/arm/boot/dts/sun8i-a33.dtsi                   | 194 +++++++++++++++++++++
 drivers/gpu/drm/panel/panel-simple.c               |  26 +++
 drivers/gpu/drm/sun4i/Makefile                     |   3 +-
 drivers/gpu/drm/sun4i/sun4i_backend.c              |   1 +
 drivers/gpu/drm/sun4i/sun4i_drv.c                  |   8 +-
 drivers/gpu/drm/sun4i/sun4i_tcon.c                 |  42 +++--
 drivers/gpu/drm/sun4i/sun4i_tcon.h                 |   2 +
 drivers/gpu/drm/sun4i/sun6i_drc.c                  | 117 +++++++++++++
 drivers/gpu/drm/sun4i/sun8i_sat.c                  | 105 +++++++++++
 11 files changed, 557 insertions(+), 19 deletions(-)
 create mode 100644 drivers/gpu/drm/sun4i/sun6i_drc.c
 create mode 100644 drivers/gpu/drm/sun4i/sun8i_sat.c

-- 
2.9.2
