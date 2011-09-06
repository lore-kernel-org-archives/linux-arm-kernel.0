From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue,  6 Sep 2011 17:58:34 +0800
Subject: [PATCH 0/6] add initial imx6q support
Message-ID: <1315303120-24203-1-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series adds the initial support for imx6q, which is a
Cortex-A9 MPCore (4 cores) SoC.

It's based on v3.1-rc4 with the patches below applied.

 * [PATCH v2 0/5] Convert DEBUG_LL UART selection to a Kconfig choice
   http://thread.gmane.org/gmane.linux.ports.arm.kernel/129702

 * [PATCH v4 2/2] ARM: l2x0: Add OF based initialization
   http://article.gmane.org/gmane.linux.kernel/1164401

 * [PATCH 1/7] ARM: l2x0: add empty l2x0_of_init
   http://article.gmane.org/gmane.linux.ports.arm.kernel/130878

 * [RFC PATCH 0/3] Yet another GIC OF binding series
   http://thread.gmane.org/gmane.linux.drivers.devicetree/7226

For suspend/resume support, it needs the following extra patches
applied.

 * [PATCH v2 0/2] make reinitialization of ARM core components possible
   http://thread.gmane.org/gmane.linux.ports.arm.kernel/131356

 * [PATCH v2 0/5] CPU PM notifiers
   http://thread.gmane.org/gmane.linux.ports.arm.kernel/131212/focus=131353

Thanks.

Shawn Guo (6):
      arm/imx6q: add device tree source
      arm/imx6q: add core definitions and low-level debug uart
      arm/imx6q: add core drivers clock, gpc, mmdc and src
      arm/imx6q: add smp and cpu hotplug support
      arm/imx6q: add device tree machine support
      arm/imx6q: add suspend/resume support

 Documentation/devicetree/bindings/arm/fsl.txt |    6 +
 arch/arm/Kconfig                              |    2 +-
 arch/arm/Kconfig.debug                        |    7 +
 arch/arm/Makefile                             |    1 +
 arch/arm/boot/dts/imx6q-sabreauto.dts         |   49 +
 arch/arm/boot/dts/imx6q.dtsi                  |  570 +++++++
 arch/arm/mach-imx/Kconfig                     |   31 +
 arch/arm/mach-imx/Makefile                    |   11 +
 arch/arm/mach-imx/Makefile.boot               |    4 +
 arch/arm/mach-imx/clock-imx6q.c               | 1990 +++++++++++++++++++++++++
 arch/arm/mach-imx/gpc.c                       |  110 ++
 arch/arm/mach-imx/head-v7.S                   |   75 +
 arch/arm/mach-imx/hotplug.c                   |   44 +
 arch/arm/mach-imx/lluart.c                    |   33 +
 arch/arm/mach-imx/localtimer.c                |   64 +
 arch/arm/mach-imx/mach-imx6q.c                |   81 +
 arch/arm/mach-imx/mmdc.c                      |   71 +
 arch/arm/mach-imx/platsmp.c                   |   86 ++
 arch/arm/mach-imx/pm-imx6q.c                  |   63 +
 arch/arm/mach-imx/src.c                       |   52 +
 arch/arm/mm/Kconfig                           |    2 +-
 arch/arm/plat-mxc/Kconfig                     |    5 +
 arch/arm/plat-mxc/include/mach/common.h       |   28 +
 arch/arm/plat-mxc/include/mach/debug-macro.S  |    5 +
 arch/arm/plat-mxc/include/mach/entry-macro.S  |   15 +-
 arch/arm/plat-mxc/include/mach/hardware.h     |    1 +
 arch/arm/plat-mxc/include/mach/irqs.h         |    9 +-
 arch/arm/plat-mxc/include/mach/memory.h       |    3 +
 arch/arm/plat-mxc/include/mach/mx6q.h         |   29 +
 29 files changed, 3441 insertions(+), 6 deletions(-)
