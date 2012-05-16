From: mturquette@ti.com (Mike Turquette)
Date: Tue, 15 May 2012 23:35:52 -0700
Subject: [GIT PULL][for 3.5] clk-next update
Message-ID: <20120516063552.GA5154@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd & Olof,

Please pull my clk-next branch.  This is an update on top of the last
pull request I sent you (already in arm-soc).

This series is mostly Orion/Kirkwood support accompanied by two small
core changes

The following changes since commit f0948f59dbc8e725a96ba16da666e8f5cdd43ba8:

  clk: add a fixed factor clock (2012-05-08 14:13:25 -0700)

are available in the git repository at:

  git://git.linaro.org/people/mturquette/linux.git clk-next

for you to fetch changes up to 7e0fa1b5fa91d9aa456d102c273b2cf0f2e95d39:

  clk: Fix CLK_SET_RATE_GATE flag validation in clk_set_rate(). (2012-05-15 22:42:10 -0700)

----------------------------------------------------------------
Andrew Lunn (14):
      ARM: Orion: Add clocks using the generic clk infrastructure.
      ARM: Orion: SPI: Add clk/clkdev support.
      ARM: Orion: Eth: Add clk/clkdev support.
      ARM: Orion: WDT: Add clk/clkdev support
      ARM: Orion: UART: Get the clock rate via clk_get_rate().
      ARM: Orion: SATA: Add per channel clk/clkdev support.
      ARM: Orion: EHCI: Add support for enabling clocks
      ARM: Orion: NAND: Add support for clk, if there is one.
      ARM: Orion: SDIO: Add support for clk.
      ARM: Orion: CESA: Add support for clk
      ARM: Orion: XOR: Add support for clk
      ARM: Orion: PCIE: Add support for clk
      ARM: Orion: Audio: Add clk/clkdev support
      ARM: Kirkwood: Replace clock gating

Mark Brown (1):
      clk: Provide dummy clk_unregister()

Saravana Kannan (1):
      clk: Fix CLK_SET_RATE_GATE flag validation in clk_set_rate().

 arch/arm/Kconfig                                  |    1 +
 arch/arm/mach-dove/common.c                       |   39 +--
 arch/arm/mach-dove/dove-db-setup.c                |    1 -
 arch/arm/mach-kirkwood/board-dreamplug.c          |    1 -
 arch/arm/mach-kirkwood/board-dt.c                 |    3 +
 arch/arm/mach-kirkwood/common.c                   |  274 ++++++++++++++-------
 arch/arm/mach-kirkwood/common.h                   |    1 +
 arch/arm/mach-kirkwood/include/mach/bridge-regs.h |   16 ++
 arch/arm/mach-kirkwood/mv88f6281gtw_ge-setup.c    |    1 -
 arch/arm/mach-kirkwood/pcie.c                     |   25 +-
 arch/arm/mach-kirkwood/rd88f6192-nas-setup.c      |    1 -
 arch/arm/mach-kirkwood/t5325-setup.c              |    1 -
 arch/arm/mach-kirkwood/tsx1x-common.c             |    1 -
 arch/arm/mach-mv78xx0/common.c                    |   45 ++--
 arch/arm/mach-orion5x/common.c                    |   27 +-
 arch/arm/mach-orion5x/rd88f6183ap-ge-setup.c      |    1 -
 arch/arm/plat-orion/common.c                      |  104 ++++----
 arch/arm/plat-orion/include/plat/common.h         |   34 +--
 arch/arm/plat-orion/include/plat/orion_wdt.h      |   18 --
 arch/arm/plat-orion/pcie.c                        |    4 +-
 drivers/ata/sata_mv.c                             |   40 ++-
 drivers/clk/clk.c                                 |   11 +-
 drivers/crypto/mv_cesa.c                          |   14 ++
 drivers/dma/mv_xor.c                              |   15 ++
 drivers/dma/mv_xor.h                              |    1 +
 drivers/mmc/host/mvsdio.c                         |   14 ++
 drivers/mtd/nand/orion_nand.c                     |   18 ++
 drivers/net/ethernet/marvell/mv643xx_eth.c        |   42 +++-
 drivers/spi/spi-orion.c                           |   30 ++-
 drivers/usb/host/ehci-orion.c                     |   16 ++
 drivers/watchdog/orion_wdt.c                      |   16 +-
 include/linux/clk-provider.h                      |    2 +
 include/linux/mv643xx_eth.h                       |    1 -
 include/linux/spi/orion_spi.h                     |   17 --
 sound/soc/kirkwood/kirkwood-i2s.c                 |   13 +
 sound/soc/kirkwood/kirkwood.h                     |    1 +
 36 files changed, 585 insertions(+), 264 deletions(-)
 delete mode 100644 arch/arm/plat-orion/include/plat/orion_wdt.h
 delete mode 100644 include/linux/spi/orion_spi.h
