From: eric@anholt.net (Eric Anholt)
Date: Fri, 18 Mar 2016 19:42:41 -0700
Subject: [PATCH 0/5] drm/vc4: DPI panel support
Message-ID: <1458355366-7073-1-git-send-email-eric@anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In preparation for working on DSI panel support, I wrote the much
simpler support for DPI panels.  I've tested it on the 7" DPI panel
from Adafruit, with panel-simple support included here.

Eric Anholt (5):
  of: Add vendor prefix for On Tat Industrial Company.
  panel-simple: Add the 7" DPI panel from Adafruit.
  drm: Add an encoder and connector type enum for DPI.
  drm/vc4: Add DPI driver
  ARM: bcm2835: Add the DPI hardware to the device tree.

 .../devicetree/bindings/display/brcm,bcm-vc4.txt   |  67 +++
 .../bindings/display/panel/ontat,yx700wv03.txt     |   7 +
 .../devicetree/bindings/vendor-prefixes.txt        |   1 +
 arch/arm/boot/dts/bcm283x.dtsi                     |  11 +
 drivers/gpu/drm/drm_crtc.c                         |   2 +
 drivers/gpu/drm/panel/panel-simple.c               |  33 ++
 drivers/gpu/drm/vc4/Kconfig                        |   1 +
 drivers/gpu/drm/vc4/Makefile                       |   1 +
 drivers/gpu/drm/vc4/vc4_debugfs.c                  |   1 +
 drivers/gpu/drm/vc4/vc4_dpi.c                      | 518 +++++++++++++++++++++
 drivers/gpu/drm/vc4/vc4_drv.c                      |   1 +
 drivers/gpu/drm/vc4/vc4_drv.h                      |   5 +
 include/uapi/drm/drm_mode.h                        |   2 +
 13 files changed, 650 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/ontat,yx700wv03.txt
 create mode 100644 drivers/gpu/drm/vc4/vc4_dpi.c

-- 
2.7.0
