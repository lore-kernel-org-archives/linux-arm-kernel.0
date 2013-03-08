From: ludovic.desroches@atmel.com (ludovic.desroches at atmel.com)
Date: Fri, 8 Mar 2013 16:13:54 +0100
Subject: [PATCH 0/4] SAMA5D3 support
Message-ID: <1362755638-20092-1-git-send-email-ludovic.desroches@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ludovic Desroches <ludovic.desroches@atmel.com>

Hi,

This set of patches introduces basic support for the SAMA5D3 family. It is
based on Jean-Christophe Kconfig cleanup patch series available at:

  git://github.com/at91linux/linux-at91.git delivery/at91_3.9_dt_cleanup

Regards

Ludovic Desroches (4):
  ARM: at91: add AT91_SAM9_TIME entry to select at91sam926x_time.c
    compilation
  ARM: at91: introduce the core type choice to split ARMv4/5 and ARMv7
    arch
  ARM: at91: fix infinite loop in at91_irq_suspend/resume
  ARM: at91: introduce SAMA5 support

 arch/arm/boot/dts/Makefile                 |    5 +
 arch/arm/boot/dts/sama5d3.dtsi             | 1031 ++++++++++++++++++++++++++++
 arch/arm/boot/dts/sama5d31ek.dts           |   51 ++
 arch/arm/boot/dts/sama5d33ek.dts           |   44 ++
 arch/arm/boot/dts/sama5d34ek.dts           |   61 ++
 arch/arm/boot/dts/sama5d35ek.dts           |   56 ++
 arch/arm/boot/dts/sama5d3xcm.dtsi          |   91 +++
 arch/arm/boot/dts/sama5d3xdm.dtsi          |   42 ++
 arch/arm/boot/dts/sama5d3xmb.dtsi          |  166 +++++
 arch/arm/configs/sama5_defconfig           |  181 +++++
 arch/arm/mach-at91/Kconfig                 |   60 +-
 arch/arm/mach-at91/Makefile                |    7 +-
 arch/arm/mach-at91/board-dt-sama5.c        |   86 +++
 arch/arm/mach-at91/clock.c                 |  109 ++-
 arch/arm/mach-at91/clock.h                 |    2 +
 arch/arm/mach-at91/include/mach/at91_pmc.h |   18 +-
 arch/arm/mach-at91/include/mach/cpu.h      |   20 +
 arch/arm/mach-at91/include/mach/sama5d3.h  |   73 ++
 arch/arm/mach-at91/irq.c                   |   20 +-
 arch/arm/mach-at91/sama5d3.c               |  377 ++++++++++
 arch/arm/mach-at91/setup.c                 |   27 +
 arch/arm/mach-at91/soc.h                   |    5 +
 22 files changed, 2486 insertions(+), 46 deletions(-)
 create mode 100644 arch/arm/boot/dts/sama5d3.dtsi
 create mode 100644 arch/arm/boot/dts/sama5d31ek.dts
 create mode 100644 arch/arm/boot/dts/sama5d33ek.dts
 create mode 100644 arch/arm/boot/dts/sama5d34ek.dts
 create mode 100644 arch/arm/boot/dts/sama5d35ek.dts
 create mode 100644 arch/arm/boot/dts/sama5d3xcm.dtsi
 create mode 100644 arch/arm/boot/dts/sama5d3xdm.dtsi
 create mode 100644 arch/arm/boot/dts/sama5d3xmb.dtsi
 create mode 100644 arch/arm/configs/sama5_defconfig
 create mode 100644 arch/arm/mach-at91/board-dt-sama5.c
 create mode 100644 arch/arm/mach-at91/include/mach/sama5d3.h
 create mode 100644 arch/arm/mach-at91/sama5d3.c

-- 
1.7.11.3
