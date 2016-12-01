From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Thu,  1 Dec 2016 21:09:23 +0100
Subject: [PATCH v2 0/7] drm/vc4: VEC (SDTV) output support
Message-ID: <1480622970-8714-1-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Here is the 2nd version of the VC4/VEC series.

We still miss the two clock patches mentioned by Eric in the first
version to make the encoder work no matter the setting applied by the
bootloader.

Regards,

Boris

Boris Brezillon (7):
  drm/vc4: Fix ->clock_select setting for the VEC encoder
  drm: Turn DRM_MODE_SUBCONNECTOR_xx definitions into an enum
  drm: Add TV connector states to drm_connector_state
  drm/vc4: Add support for the VEC (Video Encoder) IP
  drm/vc4: Document VEC DT binding
  ARM: bcm/dt: Add VEC node in bcm283x.dtsi
  ARM: bcm/dt: Enable the VEC IP on all RaspeberryPi boards

 .../devicetree/bindings/display/brcm,bcm-vc4.txt   |  14 +
 arch/arm/boot/dts/bcm2835-rpi.dtsi                 |   5 +
 arch/arm/boot/dts/bcm283x.dtsi                     |   8 +
 drivers/gpu/drm/drm_atomic.c                       |  50 ++
 drivers/gpu/drm/vc4/Makefile                       |   1 +
 drivers/gpu/drm/vc4/vc4_crtc.c                     |  38 +-
 drivers/gpu/drm/vc4/vc4_debugfs.c                  |   1 +
 drivers/gpu/drm/vc4/vc4_drv.c                      |   1 +
 drivers/gpu/drm/vc4/vc4_drv.h                      |   6 +
 drivers/gpu/drm/vc4/vc4_regs.h                     |   3 +-
 drivers/gpu/drm/vc4/vc4_vec.c                      | 657 +++++++++++++++++++++
 include/drm/drm_connector.h                        |  32 +
 include/uapi/drm/drm_mode.h                        |  18 +-
 13 files changed, 810 insertions(+), 24 deletions(-)
 create mode 100644 drivers/gpu/drm/vc4/vc4_vec.c

-- 
2.7.4
