From: yong.deng@magewell.com (Yong Deng)
Date: Thu, 27 Jul 2017 13:01:34 +0800
Subject: [PATCH v2 0/3] Initial Allwinner V3s CSI Support
Message-ID: <1501131697-1359-1-git-send-email-yong.deng@magewell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sorry for resend the patch. Delivering to somebody in cc has failed at
last time.

This patchset add initial support for Allwinner V3s CSI.

Allwinner V3s SoC have two CSI module. CSI0 is used for MIPI interface
and CSI1 is used for parallel interface. This is not documented in
datasheet but by testing and guess.

This patchset implement a v4l2 framework driver and add a binding 
documentation for it. 

Currently, the driver only support the parallel interface. And has been
tested with a BT1120 signal which generating from FPGA. The following
fetures are not support with this patchset:
  - ISP 
  - MIPI-CSI2
  - Master clock for camera sensor
  - Power regulator for the front end IC

sun6i_csi_ops is still there. I seriously thought about it. Without 
sun6i_csi_ops, the dependency between sun6i_video and sun6i_csi_v3s
will be complicated. Comments and criticisms are welcome.

Changes in v2:
  * Change sunxi-csi to sun6i-csi
  * Rebase to media_tree master branch

Yong Deng (3):
  media: V3s: Add support for Allwinner CSI.
  dt-bindings: media: Add Allwinner V3s Camera Sensor Interface (CSI)
  media: MAINTAINERS: add entries for Allwinner V3s CSI

 .../devicetree/bindings/media/sun6i-csi.txt        |  49 ++
 MAINTAINERS                                        |   8 +
 drivers/media/platform/Kconfig                     |   1 +
 drivers/media/platform/Makefile                    |   2 +
 drivers/media/platform/sun6i-csi/Kconfig           |   9 +
 drivers/media/platform/sun6i-csi/Makefile          |   3 +
 drivers/media/platform/sun6i-csi/sun6i_csi.c       | 545 ++++++++++++++
 drivers/media/platform/sun6i-csi/sun6i_csi.h       | 203 +++++
 drivers/media/platform/sun6i-csi/sun6i_csi_v3s.c   | 827 +++++++++++++++++++++
 drivers/media/platform/sun6i-csi/sun6i_csi_v3s.h   | 206 +++++
 drivers/media/platform/sun6i-csi/sun6i_video.c     | 663 +++++++++++++++++
 drivers/media/platform/sun6i-csi/sun6i_video.h     |  61 ++
 12 files changed, 2577 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/media/sun6i-csi.txt
 create mode 100644 drivers/media/platform/sun6i-csi/Kconfig
 create mode 100644 drivers/media/platform/sun6i-csi/Makefile
 create mode 100644 drivers/media/platform/sun6i-csi/sun6i_csi.c
 create mode 100644 drivers/media/platform/sun6i-csi/sun6i_csi.h
 create mode 100644 drivers/media/platform/sun6i-csi/sun6i_csi_v3s.c
 create mode 100644 drivers/media/platform/sun6i-csi/sun6i_csi_v3s.h
 create mode 100644 drivers/media/platform/sun6i-csi/sun6i_video.c
 create mode 100644 drivers/media/platform/sun6i-csi/sun6i_video.h

-- 
1.8.3.1
