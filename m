From: magnus.damm@gmail.com (Magnus Damm)
Date: Mon, 26 Jan 2015 15:17:47 +0900
Subject: [PATCH 00/14 v2] ARM: shmobile: Remove sh7372/Mackerel and ZBOOT
 MMC/SDHI support V2
Message-ID: <20150126061747.6848.9708.sendpatchset@little-apple>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ARM: shmobile: Remove sh7372/Mackerel and ZBOOT MMC/SDHI support V2

[PATCH 01/14 v2] ARM: shmobile: mackerel: Remove ZBOOT code
[PATCH 02/14 v2] ARM: shmobile: mackerel: Remove Legacy C board code
[PATCH 03/14 v2] ARM: shmobile: mackerel dts: Remove Legacy DTS file
[PATCH 04/14 v2] ARM: shmobile: mackerel: Remove DT binding documentation
[PATCH 05/14 v2] ARM: shmobile: mackerel: Remove mach-type entry
[PATCH 06/14 v2] ARM: shmobile: mackerel: Remove defconfig
[PATCH 07/14 v2] ARM: shmobile: mackerel: Remove from MAINTAINERS
[PATCH 08/14 v2] ARM: shmobile: sh7372: Remove ZBOOT MMC/SDHI support
[PATCH 09/14 v2] ARM: shmobile: sh7372: Remove Legacy C SoC code
[PATCH 10/14 v2] ARM: shmobile: sh7372: Remove DT binding documentation
[PATCH 11/14 v2] ARM: shmobile: sh7372 dtsi: Remove Legacy DTSI file
[PATCH 12/14 v2] Documentation: Remove ZBOOT MMC/SDHI utility and docs
[PATCH 13/14 v2] pinctrl: sh-pfc: sh7372: Remove PFC support
[PATCH 14/14 v2] pinctrl: sh-pfc: sh7372: Remove DT binding documentation

Here is my latest attempt (V2) of legacy board and SoC support removal
for Mackerel and sh7372. Both the ARM mach-shmobile code base and the
PINCTRL subsystem is affected.

Also get rid of the remaining ZBOOT MMC/SDHI code, documentation and
utility that has no user once sh7372 is gone.

The Cortex-A8 based sh7372 SoC is rather old and never went into mass
production anyway, so these patches that remove SoC and board support
will only affect a few selected developers.

I wish we had some way to make use of the ZBOOT MMC/SDHI code, but
without any board or SoC code it makes little sense to keep it.

Thanks to Laurent and Geert for review!

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
---

 Built on top of renesas-devel-20150123-v3.19-rc5

 Documentation/Makefile                                            |    2 
 Documentation/arm/Makefile                                        |    1 
 Documentation/arm/SH-Mobile/Makefile                              |    7 
 Documentation/arm/SH-Mobile/vrl4.c                                |  170 
 Documentation/arm/SH-Mobile/zboot-rom-mmcif.txt                   |   29 
 Documentation/arm/SH-Mobile/zboot-rom-sdhi.txt                    |   42 
 Documentation/devicetree/bindings/arm/shmobile.txt                |    4 
 Documentation/devicetree/bindings/pinctrl/renesas,pfc-pinctrl.txt |    8 
 MAINTAINERS                                                       |    1 
 arch/arm/Kconfig                                                  |   29 
 arch/arm/Kconfig.debug                                            |    7 
 arch/arm/boot/compressed/Makefile                                 |   15 
 arch/arm/boot/compressed/head-shmobile.S                          |   30 
 arch/arm/boot/compressed/mmcif-sh7372.c                           |   88 
 arch/arm/boot/compressed/sdhi-sh7372.c                            |   95 
 arch/arm/boot/compressed/sdhi-shmobile.c                          |  449 -
 arch/arm/boot/compressed/sdhi-shmobile.h                          |   11 
 arch/arm/boot/dts/Makefile                                        |    1 
 arch/arm/boot/dts/sh7372-mackerel.dts                             |   26 
 arch/arm/boot/dts/sh7372.dtsi                                     |   35 
 arch/arm/configs/mackerel_defconfig                               |  157 
 arch/arm/mach-shmobile/Kconfig                                    |   16 
 arch/arm/mach-shmobile/Makefile                                   |    6 
 arch/arm/mach-shmobile/Makefile.boot                              |    1 
 arch/arm/mach-shmobile/board-mackerel.c                           | 1522 -----
 arch/arm/mach-shmobile/clock-sh7372.c                             |  620 --
 arch/arm/mach-shmobile/common.h                                   |    1 
 arch/arm/mach-shmobile/entry-intc.S                               |   54 
 arch/arm/mach-shmobile/include/mach/head-mackerel.txt             |   93 
 arch/arm/mach-shmobile/include/mach/mmc-mackerel.h                |   38 
 arch/arm/mach-shmobile/include/mach/mmc.h                         |   16 
 arch/arm/mach-shmobile/include/mach/sdhi-sh7372.h                 |   21 
 arch/arm/mach-shmobile/include/mach/sdhi.h                        |   16 
 arch/arm/mach-shmobile/include/mach/zboot.h                       |    5 
 arch/arm/mach-shmobile/intc-sh7372.c                              |  672 --
 arch/arm/mach-shmobile/pm-sh7372.c                                |  549 --
 arch/arm/mach-shmobile/setup-sh7372.c                             | 1016 ---
 arch/arm/mach-shmobile/sh7372.h                                   |   84 
 arch/arm/mach-shmobile/sleep-sh7372.S                             |   98 
 arch/arm/tools/mach-types                                         |    1 
 drivers/pinctrl/sh-pfc/Kconfig                                    |    5 
 drivers/pinctrl/sh-pfc/Makefile                                   |    1 
 drivers/pinctrl/sh-pfc/core.c                                     |    9 
 drivers/pinctrl/sh-pfc/core.h                                     |    1 
 drivers/pinctrl/sh-pfc/pfc-sh7372.c                               | 2645 ----------
 45 files changed, 8 insertions(+), 8689 deletions(-)
