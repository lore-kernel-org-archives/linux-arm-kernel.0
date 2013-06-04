From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 4 Jun 2013 14:43:21 +0200
Subject: [GIT PULL 5/5]: ux500 devicetree changes for v3.11
Message-ID: <CACRpkdb3sjtPXmbXNPMSreRj_ExHJLEKyv20T8oENTbUTpuARw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi ARM SoC folks,

here are the ux500 devicetree changes for v3.11. See the signed
tag for details.

As mentioned this thing has a merge conflict with pull request 4/5
(the DMA40 changes) because they both stir around in the
auxdata population. I would consider merging them into one
place, like the next/dt branch, but you may have better ideas.

After this the ux500 device trees actually look like something you
can feel proud of. We're only missing the clocks for a complete,
self-contained device tree boot.

Yours,
Linus Walleij

The following changes since commit e4aa937ec75df0eea0bee03bffa3303ad36c986b:

  Linux 3.10-rc3 (2013-05-26 16:00:47 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-stericsson.git
tags/ux500-dt-for-arm-soc

for you to fetch changes up to d594224ae6bbc8b7e84b3309ce5e2697eb27fc8b:

  ARM: ux500: drop any 0x prefix from I2C DT devices (2013-06-04 11:50:32 +0200)

----------------------------------------------------------------
Device tree patches for ux500, basically trees and auxdata:
- Fix for the thermal node to be contained in the PRCMU node
- Add the DTS and auxdata needed to boot the U8540 platform
- Various regulators added and renamed
- Rename base SoC node
- A bunch of DMA patches adding channels for DT boots
- A bunch of crypto+hash patches adding config for DT boots
- A bunch of patches fixing the ALSA SoC support to work
- Register the LP5521 LEDs
- Fix a number of typos and naming errors

----------------------------------------------------------------
Fabio Baltieri (5):
      ARM: ux500: Fix intcore regulator name
      ARM: ux500: Fix trivial typo in v-anamic1 comment
      ARM: ux500: Correct anamic2 typo in DT files
      ARM: ux500: Add DT regulators for ab8500-codec
      ARM: ux500: Provide auxdata to ux500 ASoC driver

Gabriel Fernandez (2):
      ARM: ux500: DT: Rename root node "soc-u9500" into "soc"
      ARM: ux500: use #include syntax to include *.dtsi.

Lee Jones (24):
      ARM: ux500: Move Snowball's thermal DT node into existing PRCMU one
      ARM: ux500: Create a new of_dev_auxdata structure for u8540 enablement
      ARM: ux500: Add a VQMMC (level-shifting) regulator DT node for Snowball
      ARM: ux500: Supply address location names for the DMA40 DMA controller
      ARM: ux500: Setup the DMA40 driver's DT node using the new DMA API
      ARM: ux500: Supply UART's DMA configuration via Device Tree
      ARM: ux500: Supply MMC DMA configuration via Device Tree
      ARM: ux500: Populate the ux500-musb Device Tree entry
      ARM: ux500: Pass DMA memcpy channels though Device Tree
      ARM: ux500: Supply a DTS file for the u8540 platform
      ARM: ux500: Over-ride TCDM size when booting the DB8540 platform
      ARM: ux500: Add Device Tree nodes for the ux500 Crypt device
      ARM: ux500: Add Device Tree nodes for the ux500 Hash device
      ARM: ux500: Provide an AUXDATA entry for ux500-crypt
      ARM: ux500: Provide an AUXDATA entry for ux500-hash
      crypto: ux500/cryp - Enable DT probing of the driver
      crypto: ux500/hash - Enable DT probing of the driver
      ARM: ux500: Standardise DBx5x0 based Pinctrl compat string in the DTS
      ARM: ux500: Standardise Pinctrl compatible string for DBx5x
based platforms
      pinctrl/nomadik: Standardise Pinctrl compat string for DBx5x
based platforms
      ARM: ux500: Apply other compatible name to the u8540 DTS file
      ARM: ux500: Add an auxdata entry for MUSB for clock-name look-up
      ARM: ux500: Reduce PRCMU reg-names to shorter form for u8540 DT
      ARM: ux500: Allocate correct amount of memory for the u8540 in DT

Linus Walleij (8):
      ARM: ux500: build ccu8540 device tree blob
      ARM: ux500: fix typo in STUIB device tree
      ARM: ux500: register LP5521 LEDs in the device tree
      ARM: ux500: enable the crypto and hash on all dbx500
      ARM: ux500: bump MMC/SD max frequency for DT boots
      ARM: ux500: use symbolic names for interrupt flags
      ARM: ux500: cut chip-select GPIOs from SSP device
      ARM: ux500: drop any 0x prefix from I2C DT devices

 Documentation/devicetree/bindings/mfd/ab8500.txt |   2 +-
 arch/arm/boot/dts/Makefile                       |   1 +
 arch/arm/boot/dts/ccu8540.dts                    |  41 ++++
 arch/arm/boot/dts/ccu9540.dts                    |   6 +-
 arch/arm/boot/dts/dbx5x0.dtsi                    | 226 ++++++++++++++++-------
 arch/arm/boot/dts/href.dtsi                      |  61 ++++--
 arch/arm/boot/dts/hrefprev60.dts                 |  10 +-
 arch/arm/boot/dts/hrefv60plus.dts                |  20 +-
 arch/arm/boot/dts/snowball.dts                   |  80 ++++----
 arch/arm/boot/dts/stuib.dtsi                     |  26 +--
 arch/arm/mach-ux500/cpu-db8500.c                 |  26 ++-
 drivers/crypto/ux500/cryp/cryp_core.c            |   6 +
 drivers/crypto/ux500/hash/hash_core.c            |   6 +
 drivers/pinctrl/pinctrl-nomadik.c                |   4 +-
 drivers/regulator/ab8500.c                       |   8 +-
 15 files changed, 359 insertions(+), 164 deletions(-)
 create mode 100644 arch/arm/boot/dts/ccu8540.dts
