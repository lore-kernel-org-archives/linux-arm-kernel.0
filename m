From: shawn.guo@freescale.com (Shawn Guo)
Date: Mon, 15 Nov 2010 22:36:24 +0800
Subject: [RFC][PATCH 00/11] ARM: imx: Add initial i.MX28 support
Message-ID: <1289831795-4373-1-git-send-email-shawn.guo@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset adds the initial support of i.MX28, and the target device
is i.MX28 EVK Rev C. It's based on the imx-single-kernel branch below,
and adding codes into arch/arm/mxc and arch/arm/mach-imx.

 git://git.pengutronix.de/git/imx/linux-2.6.git imx-single-kernel

Please take the time to review the patchset. Thanks.

Regards,
Shawn

Shawn Guo (11):
 arch/arm/mach-imx/Kconfig                       |   20 +
 arch/arm/mach-imx/Makefile                      |    4 +
 arch/arm/mach-imx/Makefile.boot                 |    4 +
 arch/arm/mach-imx/clock-imx28.c                 |  733 +++++++++++++++++++++++
 arch/arm/mach-imx/devices-imx28.h               |   20 +
 arch/arm/mach-imx/devices.c                     |   27 +-
 arch/arm/mach-imx/mach-mx28evk.c                |  109 ++++
 arch/arm/mach-imx/mm-imx28.c                    |   50 ++
 arch/arm/mach-imx/regs-clkctrl-mx28.h           |  662 ++++++++++++++++++++
 arch/arm/plat-mxc/Kconfig                       |   12 +
 arch/arm/plat-mxc/Makefile                      |    4 +-
 arch/arm/plat-mxc/devices/Kconfig               |    3 +
 arch/arm/plat-mxc/devices/Makefile              |    1 +
 arch/arm/plat-mxc/devices/platform-duart.c      |   42 ++
 arch/arm/plat-mxc/devices/platform-fec.c        |    5 +
 arch/arm/plat-mxc/gpio.c                        |  186 +++++-
 arch/arm/plat-mxc/icoll.c                       |   79 +++
 arch/arm/plat-mxc/include/mach/common.h         |    5 +
 arch/arm/plat-mxc/include/mach/devices-common.h |   11 +
 arch/arm/plat-mxc/include/mach/entry-macro.S    |   22 +-
 arch/arm/plat-mxc/include/mach/hardware.h       |    9 +-
 arch/arm/plat-mxc/include/mach/iomux-mx28.h     |   50 ++
 arch/arm/plat-mxc/include/mach/iomux-pinctrl.h  |   91 +++
 arch/arm/plat-mxc/include/mach/irqs.h           |   11 +-
 arch/arm/plat-mxc/include/mach/memory.h         |    5 +-
 arch/arm/plat-mxc/include/mach/mx28.h           |  232 +++++++
 arch/arm/plat-mxc/include/mach/mxc.h            |   14 +
 arch/arm/plat-mxc/include/mach/uncompress.h     |   20 +-
 arch/arm/plat-mxc/iomux-pinctrl.c               |   94 +++
 arch/arm/plat-mxc/system.c                      |  104 ++++-
 arch/arm/plat-mxc/time.c                        |  120 +++-
 31 files changed, 2674 insertions(+), 75 deletions(-)
