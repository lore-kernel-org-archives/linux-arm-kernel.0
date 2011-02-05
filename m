From: shawn.guo@freescale.com (Shawn Guo)
Date: Sat, 5 Feb 2011 10:08:11 +0800
Subject: Add dma support for i.MX23/28
Message-ID: <1296871696-21008-1-git-send-email-shawn.guo@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch set is to add dma support for i.MX23/28, including
apbh-dma and apbx-dma.  The apbh-dma was tested with mxs-mmc driver
on mx23evk and mx28evk boards.  And mxs-mmc driver will be posted
for review later.

It's based on Sascha's imx-for-2.6.39 tree since commit:

    22cbba1b82de458028f4aa270e88492b622c1ea8
    ARM: mxs: dynamically register flexcan devices for mx28

Thanks for review.

Regards,
Shawn

Shawn Guo (5):
 [PATCH 1/5] dmaengine: mxs-dma: add dma support for i.MX23/28
 [PATCH 2/5] ARM: mxs: add dma channel definitions
 [PATCH 3/5] ARM: mxs: dynamically allocate dma device for mx23/28
 [PATCH 4/5] ARM: mxs/mx23evk: add dma device
 [PATCH 5/5] ARM: mxs/mx28evk: add dma device

 arch/arm/mach-mxs/Kconfig                       |    2 +
 arch/arm/mach-mxs/clock-mx23.c                  |    3 +-
 arch/arm/mach-mxs/clock-mx28.c                  |    4 +-
 arch/arm/mach-mxs/devices-mx23.h                |    6 +
 arch/arm/mach-mxs/devices-mx28.h                |    6 +
 arch/arm/mach-mxs/devices/Kconfig               |    3 +
 arch/arm/mach-mxs/devices/Makefile              |    1 +
 arch/arm/mach-mxs/devices/platform-dma.c        |   50 ++
 arch/arm/mach-mxs/include/mach/devices-common.h |    7 +
 arch/arm/mach-mxs/include/mach/dma.h            |   16 +
 arch/arm/mach-mxs/include/mach/mx23.h           |   24 +
 arch/arm/mach-mxs/include/mach/mx28.h           |   37 ++
 arch/arm/mach-mxs/mach-mx23evk.c                |    8 +
 arch/arm/mach-mxs/mach-mx28evk.c                |    8 +
 drivers/dma/Kconfig                             |    8 +
 drivers/dma/Makefile                            |    1 +
 drivers/dma/mxs-dma.c                           |  702 +++++++++++++++++++++++
 17 files changed, 883 insertions(+), 3 deletions(-)
