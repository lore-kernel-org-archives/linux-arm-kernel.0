From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 13 Dec 2017 16:33:24 +0100
Subject: [PATCH 0/8] drm/sun4i: Support the Display Engine frontend
Message-ID: <cover.63722fe4aeb908cf3c6f73874bdf69b193fe43c9.1513178989.git-series.maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This is a first serie to enable the display engine frontend.

This hardware block is found in the first generation Display Engine from
Allwinner. Its role is to implement more advanced features that the
associated backend, even though the backend alone can be used (and was used
so far) for basic composition.

Among those features, we will find hardware scaling, that is supported in
this serie, colorspace conversions, or more exotic formats support such as
the one output by the VPU.

Let me know what you think,
Maxime

Maxime Ripard (8):
  drm/sun4i: backend: Move line stride setup to buffer setup function
  drm/sun4i: backend: Allow a NULL plane pointer to retrieve the format
  drm/sun4i: sun4i_layer: Add a custom plane state
  drm/sun4i: crtc: Add a custom crtc atomic_check
  drm/sun4i: Add a driver for the display frontend
  drm/sun4i: sun4i_layer: Wire in the frontend
  drm/sun4i: sun4i_layer: Add a custom atomic_check for the frontend
  ARM: dts: sun8i: a33 Enable our display frontend

 arch/arm/boot/dts/sun8i-a33.dtsi       |   1 +-
 drivers/gpu/drm/sun4i/Makefile         |   3 +-
 drivers/gpu/drm/sun4i/sun4i_backend.c  | 139 +++++++++-
 drivers/gpu/drm/sun4i/sun4i_backend.h  |   6 +-
 drivers/gpu/drm/sun4i/sun4i_crtc.c     |  14 +-
 drivers/gpu/drm/sun4i/sun4i_drv.c      |  16 +-
 drivers/gpu/drm/sun4i/sun4i_drv.h      |   1 +-
 drivers/gpu/drm/sun4i/sun4i_frontend.c | 377 ++++++++++++++++++++++++++-
 drivers/gpu/drm/sun4i/sun4i_frontend.h | 102 +++++++-
 drivers/gpu/drm/sun4i/sun4i_layer.c    |  75 ++++-
 drivers/gpu/drm/sun4i/sun4i_layer.h    |  11 +-
 drivers/gpu/drm/sun4i/sunxi_engine.h   |   2 +-
 12 files changed, 727 insertions(+), 20 deletions(-)
 create mode 100644 drivers/gpu/drm/sun4i/sun4i_frontend.c
 create mode 100644 drivers/gpu/drm/sun4i/sun4i_frontend.h

base-commit: 4fbd8d194f06c8a3fd2af1ce560ddb31f7ec8323
-- 
git-series 0.9.1
