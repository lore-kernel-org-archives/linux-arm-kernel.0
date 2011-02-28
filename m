From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon, 28 Feb 2011 11:00:21 +0100
Subject: [PATCH] i.MX51 Framebuffer support
Message-ID: <1298887229-7987-1-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Once again, changes since last posting include:

- remove MFD_ prefix from Kconfig names
- move ipu header to include/video
- cleanup babbage framebuffer support

Sascha Hauer (8):
      fb: export fb mode db table
      ARM i.MX51: setup mipi
      Add a mfd IPUv3 driver
      Add i.MX5 framebuffer driver
      ARM i.MX51: Add IPU device support
      ARM i.MX5: Allow to increase max zone order
      ARM i.MX5: increase dma consistent size for IPU support
      ARM i.MX51 babbage: Add framebuffer support

 arch/arm/Kconfig                                |    4 +-
 arch/arm/mach-mx5/Kconfig                       |    1 +
 arch/arm/mach-mx5/board-mx51_babbage.c          |   82 ++
 arch/arm/mach-mx5/cpu.c                         |   36 +
 arch/arm/mach-mx5/devices-imx51.h               |    4 +
 arch/arm/plat-mxc/devices/Kconfig               |    4 +
 arch/arm/plat-mxc/devices/Makefile              |    1 +
 arch/arm/plat-mxc/devices/platform-imx_ipuv3.c  |   47 ++
 arch/arm/plat-mxc/include/mach/devices-common.h |   10 +
 arch/arm/plat-mxc/include/mach/ipu-v3.h         |   49 ++
 arch/arm/plat-mxc/include/mach/memory.h         |    3 +-
 drivers/video/Kconfig                           |   13 +
 drivers/video/Makefile                          |    2 +
 drivers/video/imx-ipu-v3/Kconfig                |   10 +
 drivers/video/imx-ipu-v3/Makefile               |    3 +
 drivers/video/imx-ipu-v3/ipu-common.c           |  666 ++++++++++++++++
 drivers/video/imx-ipu-v3/ipu-cpmem.c            |  612 +++++++++++++++
 drivers/video/imx-ipu-v3/ipu-dc.c               |  364 +++++++++
 drivers/video/imx-ipu-v3/ipu-di.c               |  550 ++++++++++++++
 drivers/video/imx-ipu-v3/ipu-dmfc.c             |  355 +++++++++
 drivers/video/imx-ipu-v3/ipu-dp.c               |  476 ++++++++++++
 drivers/video/imx-ipu-v3/ipu-prv.h              |  216 ++++++
 drivers/video/modedb.c                          |    8 +-
 drivers/video/mx5fb.c                           |  925 +++++++++++++++++++++++
 include/linux/fb.h                              |    3 +
 include/video/imx-ipu-v3.h                      |  219 ++++++
 26 files changed, 4658 insertions(+), 5 deletions(-)
 create mode 100644 arch/arm/plat-mxc/devices/platform-imx_ipuv3.c
 create mode 100644 arch/arm/plat-mxc/include/mach/ipu-v3.h
 create mode 100644 drivers/video/imx-ipu-v3/Kconfig
 create mode 100644 drivers/video/imx-ipu-v3/Makefile
 create mode 100644 drivers/video/imx-ipu-v3/ipu-common.c
 create mode 100644 drivers/video/imx-ipu-v3/ipu-cpmem.c
 create mode 100644 drivers/video/imx-ipu-v3/ipu-dc.c
 create mode 100644 drivers/video/imx-ipu-v3/ipu-di.c
 create mode 100644 drivers/video/imx-ipu-v3/ipu-dmfc.c
 create mode 100644 drivers/video/imx-ipu-v3/ipu-dp.c
 create mode 100644 drivers/video/imx-ipu-v3/ipu-prv.h
 create mode 100644 drivers/video/mx5fb.c
 create mode 100644 include/video/imx-ipu-v3.h
