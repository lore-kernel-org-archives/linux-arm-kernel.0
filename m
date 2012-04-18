From: andrew@lunn.ch (Andrew Lunn)
Date: Wed, 18 Apr 2012 15:30:16 +0200
Subject: [RFC 00/14] Convert Orion to generic clk framework
Message-ID: <1334755830-17581-1-git-send-email-andrew@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The generic clock framework is still exhibiting some flux, so these
patches are RFC, against 3.4.0-rc3. The changes to the drivers will be
least effected by clk flux, while the last patch will probably be most
affected. There will also be minor merge conflicts with the DT work.

Andrew Lunn (14):
  [ARM: Orion] Add clocks using the generic clk infrastructure.
  [ARM: Orion: SPI] Add clk/clkdev support.
  [ARM: Orion: Eth] Add clk/clkdev support.
  [ARM: Orion: WDT] Add clk/clkdev support
  [ARM: Orion: UART] Get the clock rate via clk_get_rate().
  [ARM: Orion: SATA] Add per channel clk/clkdev support.
  [ARM: Orion: EHCI] Add support for enabling clocks
  [ARM: Orion: NAND] Add support for clk, if there is one.
  [ARM: Orion: SDIO] Add support for clk.
  [ARM: Orion: CESA] Add support for clk
  [ARM: Orion: XOR] Add support for clk
  [ARM: Orion: PCIE] Add support for clk
  [ARM: Orion: Audio] Add clk/clkdev support
  [ARM: Kirkwood] Replace clock gating

 arch/arm/Kconfig                                  |    3 +
 arch/arm/mach-dove/common.c                       |   40 ++-
 arch/arm/mach-dove/dove-db-setup.c                |    1 -
 arch/arm/mach-kirkwood/board-dreamplug.c          |    1 -
 arch/arm/mach-kirkwood/common.c                   |  281 ++++++++++++++-------
 arch/arm/mach-kirkwood/include/mach/bridge-regs.h |   16 ++
 arch/arm/mach-kirkwood/mv88f6281gtw_ge-setup.c    |    1 -
 arch/arm/mach-kirkwood/pcie.c                     |   25 ++-
 arch/arm/mach-kirkwood/rd88f6192-nas-setup.c      |    1 -
 arch/arm/mach-kirkwood/t5325-setup.c              |    1 -
 arch/arm/mach-kirkwood/tsx1x-common.c             |    1 -
 arch/arm/mach-mv78xx0/common.c                    |   45 +++--
 arch/arm/mach-orion5x/common.c                    |   27 ++-
 arch/arm/mach-orion5x/rd88f6183ap-ge-setup.c      |    1 -
 arch/arm/plat-orion/common.c                      |  104 ++++----
 arch/arm/plat-orion/include/plat/common.h         |   34 ++--
 arch/arm/plat-orion/include/plat/orion_wdt.h      |   18 --
 arch/arm/plat-orion/pcie.c                        |    4 +-
 drivers/ata/sata_mv.c                             |   40 +++-
 drivers/crypto/mv_cesa.c                          |   14 +
 drivers/dma/mv_xor.c                              |   15 ++
 drivers/dma/mv_xor.h                              |    1 +
 drivers/mmc/host/mvsdio.c                         |   14 +
 drivers/mtd/nand/orion_nand.c                     |   18 ++
 drivers/net/ethernet/marvell/mv643xx_eth.c        |   42 +++-
 drivers/spi/spi-orion.c                           |   30 ++-
 drivers/usb/host/ehci-orion.c                     |   16 ++
 drivers/watchdog/orion_wdt.c                      |   16 +-
 include/linux/mv643xx_eth.h                       |    1 -
 include/linux/spi/orion_spi.h                     |   17 --
 sound/soc/kirkwood/kirkwood-i2s.c                 |   13 +
 sound/soc/kirkwood/kirkwood.h                     |    1 +
 32 files changed, 579 insertions(+), 263 deletions(-)
 delete mode 100644 arch/arm/plat-orion/include/plat/orion_wdt.h
 delete mode 100644 include/linux/spi/orion_spi.h

-- 
1.7.2.5
