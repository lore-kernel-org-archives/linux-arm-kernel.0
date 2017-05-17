From: icenowy@aosc.io (Icenowy Zheng)
Date: Wed, 17 May 2017 22:47:16 +0800
Subject: [PATCH v8 0/9] Initial Allwinner Display Engine 2.0 Support
Message-ID: <20170517144725.3463-1-icenowy@aosc.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset is the initial patchset for Allwinner DE2 support.

As the DE2 CCU support is already applied, this patchset now contains
only DRM changes and device tree changes. 

The SoC used to develop this patchset is V3s, as V3s is the simplest
one of the SoCs that have DE2.

(Allwinner V3s features only one mixer, and its only video output is
RGB LCD, which is already supported in our TCON driver)

The last patch is only a testing patch, it shouldn't be merged; and
for the patch to be really usable, the RFC fix of the TCON driver [1]
is needed.

No HDMI, TV encoder or other internal bridges' support is included
in this patchset, which makes it currently not usable on H3.

Thanks to Jean-Francois Moine and Jernej Skrabec for their efforts
to discover the internal of DE2!

[1] https://lists.freedesktop.org/archives/dri-devel/2016-December/126264.html

Icenowy Zheng (9):
  drm/sun4i: abstract a engine type
  drm/sun4i: add a dedicated module for sun4i-backend and sun4i-layer
  drm/sun4i: add a Kconfig option for sun4i-backend
  drm/sun4i: add support for Allwinner DE2 mixers
  drm/sun4i: Add compatible string for V3s display engine
  drm/sun4i: tcon: add support for V3s TCON
  ARM: sun8i: v3s: add device nodes for DE2 display pipeline
  ARM: sun8i: v3s: add pinmux for LCD pins of V3s SoC
  [DO NOT MERGE] ARM: sun8i: v3s: enable LCD panel of Lichee Pi Zero

 arch/arm/boot/dts/sun8i-v3s-licheepi-zero.dts |  36 +++
 arch/arm/boot/dts/sun8i-v3s.dtsi              |  96 ++++++
 drivers/gpu/drm/sun4i/Kconfig                 |  20 ++
 drivers/gpu/drm/sun4i/Makefile                |   9 +-
 drivers/gpu/drm/sun4i/sun4i_backend.c         |  78 ++---
 drivers/gpu/drm/sun4i/sun4i_backend.h         |  19 +-
 drivers/gpu/drm/sun4i/sun4i_crtc.c            |  11 +-
 drivers/gpu/drm/sun4i/sun4i_crtc.h            |   4 +-
 drivers/gpu/drm/sun4i/sun4i_drv.c             |   6 +-
 drivers/gpu/drm/sun4i/sun4i_drv.h             |   2 +-
 drivers/gpu/drm/sun4i/sun4i_layer.c           |   9 +-
 drivers/gpu/drm/sun4i/sun4i_layer.h           |   4 +-
 drivers/gpu/drm/sun4i/sun4i_tcon.c            |  43 +--
 drivers/gpu/drm/sun4i/sun4i_tv.c              |   9 +-
 drivers/gpu/drm/sun4i/sun8i_layer.c           | 134 +++++++++
 drivers/gpu/drm/sun4i/sun8i_layer.h           |  36 +++
 drivers/gpu/drm/sun4i/sun8i_mixer.c           | 414 ++++++++++++++++++++++++++
 drivers/gpu/drm/sun4i/sun8i_mixer.h           | 137 +++++++++
 drivers/gpu/drm/sun4i/sunxi_engine.h          |  98 ++++++
 19 files changed, 1077 insertions(+), 88 deletions(-)
 create mode 100644 drivers/gpu/drm/sun4i/sun8i_layer.c
 create mode 100644 drivers/gpu/drm/sun4i/sun8i_layer.h
 create mode 100644 drivers/gpu/drm/sun4i/sun8i_mixer.c
 create mode 100644 drivers/gpu/drm/sun4i/sun8i_mixer.h
 create mode 100644 drivers/gpu/drm/sun4i/sunxi_engine.h

-- 
2.12.2
