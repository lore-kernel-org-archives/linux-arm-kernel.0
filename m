From: baruch@tkos.co.il (Baruch Siach)
Date: Thu,  6 May 2010 16:09:38 +0300
Subject: [PATCH 0/3] Driver for the i.MX2x CMOS Sensor Interface
Message-ID: <cover.1273150585.git.baruch@tkos.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series contains a soc_camera driver for the i.MX25/i.MX27 CSI device, and 
platform code for the i.MX25 and i.MX27 chips. This driver is based on a driver 
for i.MX27 CSI from Sascha Hauer, that  Alan Carvalho de Assis has posted in 
linux-media last December[1]. Since all I have is a i.MX25 PDK paltform I can't 
test the mx27 specific code. Testers and comment are welcome.

[1] https://patchwork.kernel.org/patch/67636/

Baruch Siach (3):
  mx2_camera: Add soc_camera support for i.MX25/i.MX27
  mx27: add support for the CSI device
  mx25: add support for the CSI device

 arch/arm/mach-mx2/clock_imx27.c          |    2 +-
 arch/arm/mach-mx2/devices.c              |   31 +
 arch/arm/mach-mx2/devices.h              |    1 +
 arch/arm/mach-mx25/clock.c               |   14 +-
 arch/arm/mach-mx25/devices.c             |   22 +
 arch/arm/mach-mx25/devices.h             |    1 +
 arch/arm/plat-mxc/include/mach/memory.h  |    4 +-
 arch/arm/plat-mxc/include/mach/mx25.h    |    2 +
 arch/arm/plat-mxc/include/mach/mx2_cam.h |   41 +
 drivers/media/video/Kconfig              |   14 +
 drivers/media/video/Makefile             |    1 +
 drivers/media/video/mx2_camera.c         | 1396 ++++++++++++++++++++++++++++++
 12 files changed, 1524 insertions(+), 5 deletions(-)
 create mode 100644 arch/arm/plat-mxc/include/mach/mx2_cam.h
 create mode 100644 drivers/media/video/mx2_camera.c
