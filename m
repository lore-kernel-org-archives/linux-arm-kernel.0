From: ynvich@gmail.com (Sergei Ianovich)
Date: Mon,  9 Dec 2013 02:53:40 +0400
Subject: [PATCH 0/9] ARM: support for ICP DAS LP-8x4x (with dts)
In-Reply-To: <1386348542-9584-1-git-send-email-ynvich@gmail.com>
References: <1386348542-9584-1-git-send-email-ynvich@gmail.com>
Message-ID: <1386543229-1542-1-git-send-email-ynvich@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Except for defconfig, this is a completely new series. The first
eight patches fix outstanding issues with device tree support
in PXA. The 9th boots ICP DAS LP-8x4x.

Daniel chose to add a lot of selects for his MACH_PXA3XX_DT config
option. I feel that it will be easier to create multi-machine kernel
configurations and support per-machine workaround, if those selects
reside in separate machine options.

If Daniel agrees with my arguments, MACH_PXA3XX_DT and MACH_PXA27X_DT
could be merged into a single MACH_PXA_DT option.

CC: Daniel Mack <zonque@gmail.com>
CC: Arnd Bergmann <arnd@arndb.de>

Sergei Ianovich (9):
  ARM: dts: pxa2xx fix compatible strings
  ARM: dts: fix pxa27x-gpio interrupts
  ARM: fix ohci-pxa27x build error with OF enabled
  ARM: pxa: remove unused variable
  ARM: dts: provide DMA config to pxamci
  ARM: dts: pxa3xx: move declaration to header
  ARM: dts: pxa27x: skip static platform devices
  ARM: dts: pxa27x: device tree irq init
  ARM: pxa27x: device tree support ICP DAS LP-8x4x

 Documentation/devicetree/bindings/mmc/pxa-mmc.txt |   2 +
 arch/arm/boot/dts/Makefile                        |   1 +
 arch/arm/boot/dts/pxa27x-lp8x4x.dts               | 111 +++++++++++++++
 arch/arm/boot/dts/pxa27x.dtsi                     |  10 ++
 arch/arm/boot/dts/pxa2xx.dtsi                     |   5 +-
 arch/arm/configs/lp8x4x_defconfig                 | 162 ++++++++++++++++++++++
 arch/arm/mach-pxa/Kconfig                         |  31 +++++
 arch/arm/mach-pxa/Makefile                        |   1 +
 arch/arm/mach-pxa/include/mach/irqs.h             |   4 +
 arch/arm/mach-pxa/include/mach/pxa27x.h           |   4 +
 arch/arm/mach-pxa/irq.c                           |   2 -
 arch/arm/mach-pxa/pxa27x-dt.c                     |  97 +++++++++++++
 arch/arm/mach-pxa/pxa27x.c                        |  17 +++
 arch/arm/mach-pxa/pxa3xx.c                        |   2 -
 drivers/mmc/host/pxamci.c                         |  50 +++++--
 drivers/usb/host/ohci-pxa27x.c                    |   1 +
 16 files changed, 482 insertions(+), 18 deletions(-)
 create mode 100644 arch/arm/boot/dts/pxa27x-lp8x4x.dts
 create mode 100644 arch/arm/configs/lp8x4x_defconfig
 create mode 100644 arch/arm/mach-pxa/pxa27x-dt.c

-- 
1.8.4.3
