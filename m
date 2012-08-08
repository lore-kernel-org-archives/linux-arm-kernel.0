From: arnd@arndb.de (Arnd Bergmann)
Date: Wed,  8 Aug 2012 16:47:17 +0200
Subject: [PATCH 00/11] recently added ARM defconfig warnings
Message-ID: <1344437248-20560-1-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These patches address problems that showed up in new warnings
when building all ARM defconfig files in v3.6-rc1 compared
with v3.5.

I can merge them through the arm-soc tree or have subsystem
maintainers pick them up if they prefer.

Arnd Bergmann (11):
  ARM: topology: mark init_cpu_topology as __init
  mfd/asic3: fix asic3_mfd_probe return value
  usb/ohci-omap: remove unused variable
  ARM: ux500: really kill snowball_of_platform_devs
  ARM: exynos: exynos_pm_add_dev_to_genpd may be unused
  gpio: em: do not discard em_gio_irq_domain_cleanup
  net/stmmac: mark probe function as __devinit
  mtd/omap2: fix dmaengine_slave_config error handling
  regulator/twl: remove fixed resource handling
  spi/s3c64xx: improve error handling
  pm/drivers: fix use of SIMPLE_DEV_PM_OPS

Cc: Alan Stern <stern@rowland.harvard.edu>
Cc: David S. Miller <davem@davemloft.net>
Cc: Giuseppe Cavallaro <peppe.cavallaro@st.com>
Cc: Grant Likely <grant.likely@secretlab.ca>
Cc: Grazvydas Ignotas <notasas@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jaswinder Singh <jaswinder.singh@linaro.org>
Cc: Kukjin Kim <kgene.kim@samsung.com>
Cc: Laxman Dewangan <ldewangan@nvidia.com>
Cc: Lee Jones <lee.jones@linaro.org>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Magnus Damm <damm@opensource.se>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Paul Parsons <lost.distance@yahoo.com>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: Philipp Zabel <philipp.zabel@gmail.com>
Cc: Rafael J. Wysocki <rjw@sisk.pl>
Cc: Richard Zhao <richard.zhao@freescale.com>
Cc: Russell King <rmk+kernel@arm.linux.org.uk>
Cc: Samuel Ortiz <sameo@linux.intel.com>
Cc: Stefan Roese <sr@denx.de>
Cc: Takashi Iwai <tiwai@suse.de>
Cc: Thomas Abraham <thomas.abraham@linaro.org>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Cc: netdev at vger.kernel.org

 arch/arm/kernel/topology.c                         |    2 +-
 arch/arm/mach-exynos/pm_domains.c                  |    2 +-
 arch/arm/mach-ux500/board-mop500.c                 |    5 -----
 drivers/char/hw_random/omap-rng.c                  |    2 +-
 drivers/gpio/gpio-em.c                             |    2 +-
 drivers/i2c/busses/i2c-tegra.c                     |    2 +-
 drivers/mfd/asic3.c                                |    1 +
 drivers/mtd/nand/omap2.c                           |    7 +++----
 .../net/ethernet/stmicro/stmmac/stmmac_platform.c  |    2 +-
 drivers/regulator/twl-regulator.c                  |   21 --------------------
 drivers/spi/spi-s3c64xx.c                          |    2 +-
 drivers/usb/host/ohci-omap.c                       |    2 --
 sound/drivers/dummy.c                              |    2 +-
 13 files changed, 12 insertions(+), 40 deletions(-)

-- 
1.7.10
