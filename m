From: b29396@freescale.com (Dong Aisheng)
Date: Wed, 18 Apr 2012 20:46:32 +0800
Subject: [PATCH 0/5] dma: mxs-dma: make driver mach-independent and add dt
 support
Message-ID: <1334753197-12032-1-git-send-email-b29396@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series make the mxs-dma driver mach-independent which can be
used by imx6q and other compatible platforms in the future and also add
the dt support.

This first patch depends on Wolfram's
[PATCH V2 1/3] lib: add support for stmp-style devices
http://www.spinics.net/lists/arm-kernel/msg166232.html
which is still not in mainline.

Dong Aisheng (5):
  dma: mxs-dma: use global stmp_device functionality
  dma: mxs-dma: make platform_device_id more generic
  dma: mxs-dma: add device tree probe support
  ARM: mxs: do not add dma device by default
  ARM: mx28evk: add mxs-dma dt support

 .../devicetree/bindings/dma/fsl-mxs-dma.txt        |   19 +++
 arch/arm/boot/dts/imx28.dtsi                       |    4 +-
 arch/arm/mach-mxs/clock-mx23.c                     |    4 +-
 arch/arm/mach-mxs/clock-mx28.c                     |    6 +-
 arch/arm/mach-mxs/devices-mx23.h                   |    2 +
 arch/arm/mach-mxs/devices-mx28.h                   |    2 +
 arch/arm/mach-mxs/devices/platform-dma.c           |   17 +-
 arch/arm/mach-mxs/include/mach/devices-common.h    |    3 +
 arch/arm/mach-mxs/mach-apx4devkit.c                |    1 +
 arch/arm/mach-mxs/mach-m28evk.c                    |    1 +
 arch/arm/mach-mxs/mach-mx23evk.c                   |    1 +
 arch/arm/mach-mxs/mach-stmp378x_devb.c             |    1 +
 arch/arm/mach-mxs/mach-tx28.c                      |    1 +
 drivers/dma/Kconfig                                |    1 +
 drivers/dma/mxs-dma.c                              |  163 +++++++++++++++-----
 include/linux/fsl/mxs-dma.h                        |   12 +--
 16 files changed, 174 insertions(+), 64 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/dma/fsl-mxs-dma.txt
