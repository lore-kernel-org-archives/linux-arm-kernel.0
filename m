From: khilman@kernel.org (Kevin Hilman)
Date: Thu,  2 Jul 2015 11:02:11 -0700
Subject: [GIT PULL] ARM: SoC: late fixes and dependencies
Message-ID: <1435860131-32747-1-git-send-email-khilman@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is a collection of a few late fixes and other misc. stuff that
had dependencies on things being merged from other trees.

Other than the fixes, the primary feature being added is the
conversion of some OMAP drivers to the new generic wakeirq interface.

----------------------------------------------------------------

The following changes since commit 7adf12b87f45a77d364464018fb8e9e1ac875152:

  Merge tag 'for-linus-4.2-rc0-tag' of git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git tags/armsoc-late

for you to fetch changes up to ae41a0b7ed7740009b9ec87c7dc05b23f01d361a:

  ARM: multi_v7_defconfig: Enable BRCMNAND driver

----------------------------------------------------------------

Boris Brezillon (1):
      ARM: at91/dt: update udc compatible strings

Florian Fainelli (2):
      ARM: BCM: Do not select CONFIG_MTD_NAND_BRCMNAND
      ARM: multi_v7_defconfig: Enable BRCMNAND driver

Kevin Hilman (8):
      Merge tag 'armsoc-cleanup' into test-merge
      Merge tag 'armsoc-soc' into test-merge
      Merge tag 'armsoc-dt' into test-merge
      Merge tag 'armsoc-drivers' into test-merge
      Merge tag 'armsoc-defconfig' into test-merge
      Merge tag 'omap-for-v4.2/wakeirq-drivers-v2' of git://git.kernel.org/.../tmlind/linux-omap into next/late
      Merge tag 'mvebu-dt-4.2-3' of git://git.infradead.org/linux-mvebu into next/late
      Merge tag 'mvebu-fixes-4.2-0' of git://git.infradead.org/linux-mvebu into next/late

Nicolas Ferre (1):
      ARM: at91/dt: trivial: fix USB udc compatible string

Russell King (1):
      ARM: dove: fix legacy dove IRQ numbers

Stephen Boyd (1):
      soc: qcom: spm: Fix idle on THUMB2 kernels

Thomas Petazzoni (2):
      ARM: mvebu: adjust Armada XP DT spi muxing after pinctrl function rename
      ARM: mvebu: fix suspend to RAM on big-endian configurations

Tony Lindgren (4):
      mmc: omap_hsmmc: Change wake-up interrupt to use generic wakeirq
      serial: omap: Switch wake-up interrupt to generic wakeirq
      serial: 8250_omap: Move wake-up interrupt to generic wakeirq
      Merge branch 'wakeirq-8250' into omap-for-v4.2/wakeirq-v2

Y Vo (1):
      arm64: dts: Add APM X-Gene standby GPIO controller DTS entries


 .../devicetree/bindings/usb/atmel-usb.txt       |   6 +-
 arch/arm/boot/dts/armada-xp.dtsi                |   2 +-
 arch/arm/boot/dts/at91sam9g45.dtsi              |   2 +-
 arch/arm/boot/dts/at91sam9x5.dtsi               |   2 +-
 arch/arm/boot/dts/sama5d3.dtsi                  |   2 +-
 arch/arm/boot/dts/sama5d4.dtsi                  |   2 +-
 arch/arm/configs/multi_v7_defconfig             |   1 +
 arch/arm/mach-bcm/Kconfig                       |   1 -
 arch/arm/mach-dove/include/mach/irqs.h          | 118 +++++++++----------
 arch/arm/mach-dove/irq.c                        |   8 +-
 arch/arm/mach-mvebu/pm-board.c                  |   3 +
 arch/arm64/boot/dts/apm/apm-storm.dtsi          |  13 ++
 drivers/mmc/host/omap_hsmmc.c                   |  49 +-------
 drivers/soc/qcom/spm.c                          |   2 +-
 drivers/tty/serial/8250/8250_omap.c             |  58 +--------
 drivers/tty/serial/omap-serial.c                |  35 +-----
 16 files changed, 103 insertions(+), 201 deletions(-)
