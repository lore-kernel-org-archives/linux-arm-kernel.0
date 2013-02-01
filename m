From: jason@lakedaemon.net (Jason Cooper)
Date: Fri, 1 Feb 2013 15:51:59 +0000
Subject: [GIT PULL  4/4] ARM: mvebu: dt for v3.9
In-Reply-To: <1359733918.Bf7ecc0.22262@triton>
Message-ID: <1359733919.FeBB7DA4.22262@triton>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 949db153b6466c6f7cad5a427ecea94985927311:

  Linux 3.8-rc5

are available in the git repository at:

  git://git.infradead.org/users/jcooper/linux.git tags/dt_for_v3.9

for you to fetch changes up to 1bead82fa5a52cd21c30c0c28615157d5c3dac9f:

  arm: mvebu: add button for OpenBlocks AX3-4

----------------------------------------------------------------
mvebu dt changes for v3.9
     - mvebu
       - add rtc support
       - add sdio support
       - add button support for AX3-4
     - kirkwood
       - add sdio support
       - add twsi1 and nand to 88f6282
       - convert openblocks A6 to pinctrl
       - convert more of nsa310 to dt
       - gpio-poweroff for ns2
     - dove
       - move led pinctrl to gpio-leds node
       - use fixed regulator for usb power
    
    depends on:
     - tags/boards_for_v3.9, which pulls in:
        - tags/mvebu_fixes_for_v3.8-rc6
        - tags/cleanup_for_v3.9_round2
        - tags/drivers_for_v3.9
        - mmc/mmc-next up to:
           d293875 mmc: mvsdio: add pinctrl integration
----------------------------------------------------------------
Andrew Lunn (4):
      ARM: Kirkwood: Convert NSA310 to DT based regulators.
      ARM: Kirkwood: Convert NSA310 to use gpio-poweroff driver
      ARM: Kirkwood: Convert NSA310 I2C to device tree
      ARM: Kirkwood: Convert NS2 to gpio-poweroff.

Gregory CLEMENT (1):
      arm: mvebu: Add RTC support for Armada 370 and Armada XP

Jason Cooper (1):
      Merge tag 'tags/boards_for_v3.9' into mvebu/dt

Nobuhiro Iwamatsu (3):
      ARM: Kirkwood: Add pinctrl of TWSI1 to 88f6282
      ARM: Kirkwood: Add pinctrl of NAND to 88f6282
      ARM: Kirkwood: Convert openblocks A6 board to pinctrl

Sebastian Hesselbarth (2):
      ARM: Dove: move CuBox led pinctrl to gpio-leds node
      ARM: Dove: add fixed regulator for CuBox USB power

Thomas Petazzoni (11):
      arm: mvebu: add DT information for the SDIO interface of Armada 370/XP
      arm: mvebu: add pin muxing options for the SDIO interface on Armada 370
      arm: mvebu: add pin muxing options for the SDIO interface on Armada XP
      arm: mvebu: enable the SD card slot on Armada XP DB board
      arm: mvebu: enable the SD card slot on Armada 370 DB board
      arm: mvebu: enable the SDIO interface on the Globalscale Mirabox
      arm: kirkwood: add Device Tree informations for the SDIO controller
      arm: kirkwood: dreamplug: use Device Tree to probe SDIO
      arm: kirkwood: mplcec4: use Device Tree to probe SDIO
      arm: kirkwood: add pinmux option for the SDIO interface on 88F6282
      arm: mvebu: add button for OpenBlocks AX3-4

 .../bindings/mmc/brcm,bcm2835-sdhci.txt         |  18 ++
 .../devicetree/bindings/mmc/orion-sdio.txt      |  17 ++
 arch/arm/boot/dts/Makefile                      |   2 +
 arch/arm/boot/dts/armada-370-db.dts             |  15 +
 arch/arm/boot/dts/armada-370-mirabox.dts        |  10 +
 arch/arm/boot/dts/armada-370-rd.dts             |  61 ++++
 arch/arm/boot/dts/armada-370-xp.dtsi            |  14 +
 arch/arm/boot/dts/armada-370.dtsi               |  12 +
 arch/arm/boot/dts/armada-xp-db.dts              |   7 +
 arch/arm/boot/dts/armada-xp-mv78230.dtsi        |   6 +
 arch/arm/boot/dts/armada-xp-mv78260.dtsi        |   6 +
 arch/arm/boot/dts/armada-xp-mv78460.dtsi        |   6 +
 .../arm/boot/dts/armada-xp-openblocks-ax3-4.dts |  12 +
 arch/arm/boot/dts/armada-xp.dtsi                |   2 +-
 arch/arm/boot/dts/dove-cubox.dts                |  28 +-
 arch/arm/boot/dts/dove.dtsi                     |   2 +
 arch/arm/boot/dts/kirkwood-6282.dtsi            |  17 ++
 arch/arm/boot/dts/kirkwood-dreamplug.dts        |   7 +
 .../boot/dts/kirkwood-guruplug-server-plus.dts  |  94 +++++++
 arch/arm/boot/dts/kirkwood-mplcec4.dts          |  11 +-
 arch/arm/boot/dts/kirkwood-ns2-common.dtsi      |   6 +
 arch/arm/boot/dts/kirkwood-nsa310.dts           |  27 ++
 arch/arm/boot/dts/kirkwood-openblocks_a6.dts    | 116 ++++++++
 arch/arm/boot/dts/kirkwood.dtsi                 |   8 +
 arch/arm/configs/dove_defconfig                 |  28 +-
 arch/arm/configs/kirkwood_defconfig             |   1 +
 arch/arm/configs/mvebu_defconfig                |  16 ++
 arch/arm/mach-dove/Kconfig                      |   7 +
 arch/arm/mach-dove/Makefile                     |   4 +-
 arch/arm/mach-dove/board-dt.c                   | 102 +++++++
 arch/arm/mach-dove/common.c                     | 114 +-------
 arch/arm/mach-kirkwood/Kconfig                  |   7 +
 arch/arm/mach-kirkwood/Makefile                 |   2 +-
 arch/arm/mach-kirkwood/board-dreamplug.c        |   6 -
 arch/arm/mach-kirkwood/board-dt.c               |  15 +-
 arch/arm/mach-kirkwood/board-guruplug.c         |  39 +++
 arch/arm/mach-kirkwood/board-ib62x0.c           |   1 -
 arch/arm/mach-kirkwood/board-mplcec4.c          |   8 -
 arch/arm/mach-kirkwood/board-ns2.c              |  14 -
 arch/arm/mach-kirkwood/board-nsa310.c           |  51 +---
 arch/arm/mach-kirkwood/board-openblocks_a6.c    |  44 ---
 arch/arm/mach-kirkwood/common.c                 |  23 ++
 arch/arm/mach-kirkwood/common.h                 |   6 +
 arch/arm/mach-kirkwood/dockstar-setup.c         |   1 -
 arch/arm/mach-kirkwood/include/mach/kirkwood.h  |   3 +-
 arch/arm/mach-kirkwood/pcie.c                   |  10 +-
 arch/arm/mach-mvebu/irq-armada-370-xp.c         |  72 +++++
 arch/arm/plat-orion/mpp.c                       |   2 +-
 drivers/cpuidle/Kconfig                         |   6 +
 drivers/cpuidle/Makefile                        |   1 +
 .../cpuidle/cpuidle-kirkwood.c                  |  45 ++-
 drivers/mmc/card/block.c                        |  30 +-
 drivers/mmc/card/queue.c                        |  32 ++-
 drivers/mmc/card/queue.h                        |   3 +
 drivers/mmc/core/bus.c                          |   1 +
 drivers/mmc/core/core.c                         | 121 +++++++-
 drivers/mmc/core/core.h                         |   1 +
 drivers/mmc/core/sdio.c                         |  33 ++-
 drivers/mmc/core/slot-gpio.c                    |  57 +++-
 drivers/mmc/host/Kconfig                        |  11 +
 drivers/mmc/host/Makefile                       |   1 +
 drivers/mmc/host/mvsdio.c                       | 131 +++++----
 drivers/mmc/host/sdhci-bcm2835.c                | 227 +++++++++++++++
 drivers/mmc/host/sdhci-esdhc-imx.c              |  59 +---
 drivers/mmc/host/sdhci-pxav3.c                  |  12 +-
 drivers/mmc/host/sdhci.c                        | 117 +++++---
 drivers/mmc/host/sh_mmcif.c                     | 280 +++++++++++--------
 drivers/mmc/host/tmio_mmc_pio.c                 |   8 -
 drivers/rtc/Kconfig                             |   2 +-
 include/linux/mmc/card.h                        |  12 +
 include/linux/mmc/core.h                        |   3 +-
 include/linux/mmc/host.h                        |  25 ++
 72 files changed, 1688 insertions(+), 610 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mmc/brcm,bcm2835-sdhci.txt
 create mode 100644 Documentation/devicetree/bindings/mmc/orion-sdio.txt
 create mode 100644 arch/arm/boot/dts/armada-370-rd.dts
 create mode 100644 arch/arm/boot/dts/kirkwood-guruplug-server-plus.dts
 create mode 100644 arch/arm/mach-dove/board-dt.c
 create mode 100644 arch/arm/mach-kirkwood/board-guruplug.c
 rename arch/arm/mach-kirkwood/cpuidle.c => drivers/cpuidle/cpuidle-kirkwood.c (61%)
 create mode 100644 drivers/mmc/host/sdhci-bcm2835.c
