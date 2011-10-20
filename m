From: shawn.guo@freescale.com (Shawn Guo)
Date: Fri, 21 Oct 2011 01:11:59 +0800
Subject: [GIT PULL] i.MX6Q support
Message-ID: <20111020171158.GJ32007@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

Please pull imx6q series.  It's based on v3.1-rc10 with the following
branches merged plus a number of cache-l2x0 patches currently sitting
on rmk/for-next.

  rmk/devel-stable
  rmk/smp
  arnd/cross-platform/debug_ll
  arnd/next/dt
  arnd/imx/devel

I will need to send a follow-up patch to update the series if Marc's
PPI series gets in for for this merge window.

Regards,
Shawn

The following changes since commit c4a23e643f240875124d56cafd242ca9ba58e045:

  Merge branch 'unstable-tree/rmk/for-next' into imx6q/base (2011-10-21 00:21:32 +0800)

are available in the git repository at:

  git://git.linaro.org/people/shawnguo/linux-2.6.git imx6q/for-arnd

Sascha Hauer (1):
      arm/imx: merge i.MX3 and i.MX6

Shawn Guo (8):
      arm/imx6q: add device tree source
      arm/imx6q: add core definitions and low-level debug uart
      arm/imx: add gic_handle_irq function
      arm/imx6q: add core drivers clock, gpc, mmdc and src
      arm/imx6q: add smp and cpu hotplug support
      arm/imx6q: add device tree machine support
      arm/imx6q: add suspend/resume support
      MAINTAINERS: add ARM/FREESCALE IMX6 entry

 Documentation/devicetree/bindings/arm/fsl.txt |    6 +
 MAINTAINERS                                   |    7 +
 arch/arm/Kconfig                              |    2 +-
 arch/arm/Kconfig.debug                        |    7 +
 arch/arm/Makefile                             |    2 +-
 arch/arm/boot/dts/imx6q-sabreauto.dts         |   62 +
 arch/arm/boot/dts/imx6q.dtsi                  |  575 +++++++
 arch/arm/mach-imx/Kconfig                     |   30 +-
 arch/arm/mach-imx/Makefile                    |   11 +
 arch/arm/mach-imx/Makefile.boot               |   14 +-
 arch/arm/mach-imx/clock-imx6q.c               | 2012 +++++++++++++++++++++++++
 arch/arm/mach-imx/gpc.c                       |  113 ++
 arch/arm/mach-imx/head-v7.S                   |   99 ++
 arch/arm/mach-imx/hotplug.c                   |   44 +
 arch/arm/mach-imx/lluart.c                    |   32 +
 arch/arm/mach-imx/localtimer.c                |   35 +
 arch/arm/mach-imx/mach-imx6q.c                |   84 +
 arch/arm/mach-imx/mmdc.c                      |   72 +
 arch/arm/mach-imx/platsmp.c                   |   85 ++
 arch/arm/mach-imx/pm-imx6q.c                  |   70 +
 arch/arm/mach-imx/src.c                       |   49 +
 arch/arm/mm/Kconfig                           |    2 +-
 arch/arm/plat-mxc/Kconfig                     |   11 +-
 arch/arm/plat-mxc/Makefile                    |    2 +-
 arch/arm/plat-mxc/gic.c                       |   48 +
 arch/arm/plat-mxc/include/mach/common.h       |   29 +
 arch/arm/plat-mxc/include/mach/debug-macro.S  |    2 +
 arch/arm/plat-mxc/include/mach/entry-macro.S  |    6 +
 arch/arm/plat-mxc/include/mach/hardware.h     |    6 +
 arch/arm/plat-mxc/include/mach/irqs.h         |   10 +-
 arch/arm/plat-mxc/include/mach/mx6q.h         |   33 +
 31 files changed, 3546 insertions(+), 14 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/fsl.txt
 create mode 100644 arch/arm/boot/dts/imx6q-sabreauto.dts
 create mode 100644 arch/arm/boot/dts/imx6q.dtsi
 create mode 100644 arch/arm/mach-imx/clock-imx6q.c
 create mode 100644 arch/arm/mach-imx/gpc.c
 create mode 100644 arch/arm/mach-imx/head-v7.S
 create mode 100644 arch/arm/mach-imx/hotplug.c
 create mode 100644 arch/arm/mach-imx/lluart.c
 create mode 100644 arch/arm/mach-imx/localtimer.c
 create mode 100644 arch/arm/mach-imx/mach-imx6q.c
 create mode 100644 arch/arm/mach-imx/mmdc.c
 create mode 100644 arch/arm/mach-imx/platsmp.c
 create mode 100644 arch/arm/mach-imx/pm-imx6q.c
 create mode 100644 arch/arm/mach-imx/src.c
 create mode 100644 arch/arm/plat-mxc/gic.c
 create mode 100644 arch/arm/plat-mxc/include/mach/mx6q.h
