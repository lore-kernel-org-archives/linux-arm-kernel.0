From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 15 Jul 2011 00:14:15 +0800
Subject: [PATCH 0/2] Add device tree probe for imx-sdma driver
Message-ID: <1310660057-17953-1-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The first patch remove the use of software defined sdma version, and
instead uses platform_device_id to handle the sdma differences from
one soc to another.  And the second one adds the actual device tree
probe support.

Shawn Guo (2):
      dmaengine: imx-sdma: use platform_device_id to identify sdma version
      dmaengine: imx-sdma: add device tree probe support

 .../devicetree/bindings/dma/fsl-imx-sdma.txt       |   55 ++++++++++++++++
 arch/arm/mach-imx/clock-imx25.c                    |    3 +-
 arch/arm/mach-imx/clock-imx31.c                    |    2 +-
 arch/arm/mach-imx/clock-imx35.c                    |    2 +-
 arch/arm/mach-imx/mm-imx25.c                       |    4 +-
 arch/arm/mach-imx/mm-imx31.c                       |    3 +-
 arch/arm/mach-imx/mm-imx35.c                       |    3 +-
 arch/arm/mach-mx5/clock-mx51-mx53.c                |    6 +-
 arch/arm/mach-mx5/mm.c                             |    8 +-
 arch/arm/plat-mxc/devices/platform-imx-dma.c       |    4 +-
 arch/arm/plat-mxc/include/mach/devices-common.h    |    2 +-
 arch/arm/plat-mxc/include/mach/dma.h               |    3 +-
 arch/arm/plat-mxc/include/mach/sdma.h              |    2 -
 drivers/dma/imx-sdma.c                             |   68 ++++++++++++++++----
 14 files changed, 131 insertions(+), 34 deletions(-)
