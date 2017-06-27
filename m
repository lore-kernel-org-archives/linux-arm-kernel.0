From: yong.deng@magewell.com (Yong Deng)
Date: Tue, 27 Jun 2017 19:07:32 +0800
Subject: [PATCH RFC 0/2] Initial Allwinner V3s CSI Support
Message-ID: <1498561654-14658-1-git-send-email-yong.deng@magewell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset add initial support for Allwinner V3s CSI.

Allwinner V3s SoC have two CSI module. CSI0 is used for MIPI interface
and CSI1 is used for parallel interface. This is not documented in
datatsheet but by testing and guess.

This patchset implement a v4l2 framework driver and add a binding 
documentation for it.

Currently, the driver only support the parallel interface. And has been
tested with a BT1120 signal which generating from FPGA. The following
fetures are not support with this patchset:
  - ISP
  - MIPI-CSI2
  - Master clock for camera sensor
  - Power regulator for the front end IC

Yong Deng (2):
  media: V3s: Add support for Allwinner CSI.
  dt-bindings: add binding documentation for Allwinner CSI

 .../devicetree/bindings/media/sunxi-csi.txt        |  51 ++
 drivers/media/platform/Kconfig                     |   1 +
 drivers/media/platform/Makefile                    |   2 +
 drivers/media/platform/sunxi-csi/Kconfig           |   8 +
 drivers/media/platform/sunxi-csi/Makefile          |   3 +
 drivers/media/platform/sunxi-csi/sunxi_csi.c       | 535 +++++++++++++
 drivers/media/platform/sunxi-csi/sunxi_csi.h       | 203 +++++
 drivers/media/platform/sunxi-csi/sunxi_csi_v3s.c   | 827 +++++++++++++++++++++
 drivers/media/platform/sunxi-csi/sunxi_csi_v3s.h   | 206 +++++
 drivers/media/platform/sunxi-csi/sunxi_video.c     | 667 +++++++++++++++++
 drivers/media/platform/sunxi-csi/sunxi_video.h     |  61 ++
 11 files changed, 2564 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/media/sunxi-csi.txt
 create mode 100644 drivers/media/platform/sunxi-csi/Kconfig
 create mode 100644 drivers/media/platform/sunxi-csi/Makefile
 create mode 100644 drivers/media/platform/sunxi-csi/sunxi_csi.c
 create mode 100644 drivers/media/platform/sunxi-csi/sunxi_csi.h
 create mode 100644 drivers/media/platform/sunxi-csi/sunxi_csi_v3s.c
 create mode 100644 drivers/media/platform/sunxi-csi/sunxi_csi_v3s.h
 create mode 100644 drivers/media/platform/sunxi-csi/sunxi_video.c
 create mode 100644 drivers/media/platform/sunxi-csi/sunxi_video.h

-- 
1.8.3.1
