From: arnd@arndb.de (Arnd Bergmann)
Date: Thu,  8 May 2014 16:46:51 +0200
Subject: [PATCH 00/22] Random ARM randconfig fixes in drivers
Message-ID: <1399560433-1402630-1-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These are a bunch of fixes I had to do to get all randconfig
configurations on ARM working. Most of these are really old
bugs, but there are also some new ones. I don't think any of
them require a backport to linux-stable.

I have checked that they are all still required on yesterday's
linux-next kernel. Please apply on the appropriate trees unless
there are objections.

Patch numbers are per subsystem, which I thought is less confusing
than numbering them 1-22 when they are all totall independent.

Arnd Bergmann (22):
  mdio_bus: fix devm_mdiobus_alloc_size export
  phy: kona2: use 'select GENERIC_PHY' in Kconfig
  phy: exynos: fix SATA phy license typo
  dmaengine: omap: hide filter_fn for built-in drivers
  dmaengine: sa11x0: remove broken #ifdef
  mtd/onenand: fix build warning for dma type
  mtd: orion-nand: fix build error with ARMv4
  clk/versatile: export symbols for impd1
  bus/omap_l3: avoid sync initcall for modules
  bus/arm-cci: add dependency on OF && CPU_V7
  watchdog: iop_wdt only builds for mach-iop13xx
  mpilib: use 'static inline' for mpi-inline.h
  ata: pata_at91 only works on sam9
  i2c/nuc900: fix ancient build error
  iio: always select ANON_INODES
  iio:adc: at91 requires the input subsystem
  pci: rcar host needs OF
  input: fix ps2/serio module dependency
  input: atmel-wm97xx: only build for AVR32
  misc: atmel_pwm: only build for supported platforms
  remoteproc: da8xx: don't select CMA on no-MMU
  regulator: arizona-ldo1: add missing #include

 drivers/ata/Kconfig               | 2 +-
 drivers/bus/Kconfig               | 2 +-
 drivers/bus/omap_l3_noc.c         | 4 ++++
 drivers/bus/omap_l3_smx.c         | 4 ++++
 drivers/clk/versatile/clk-icst.c  | 1 +
 drivers/clk/versatile/clk-impd1.c | 2 ++
 drivers/dma/sa11x0-dma.c          | 4 ----
 drivers/i2c/busses/i2c-nuc900.c   | 2 +-
 drivers/iio/Kconfig               | 1 +
 drivers/iio/adc/Kconfig           | 1 +
 drivers/input/keyboard/Kconfig    | 2 +-
 drivers/input/mouse/Kconfig       | 2 +-
 drivers/input/touchscreen/Kconfig | 2 +-
 drivers/misc/Kconfig              | 3 ++-
 drivers/mtd/nand/orion_nand.c     | 5 +++++
 drivers/mtd/onenand/samsung.c     | 8 ++++----
 drivers/net/phy/mdio_bus.c        | 2 +-
 drivers/pci/host/Kconfig          | 2 +-
 drivers/phy/Kconfig               | 2 +-
 drivers/phy/phy-exynos5250-sata.c | 2 +-
 drivers/regulator/arizona-ldo1.c  | 1 +
 drivers/remoteproc/Kconfig        | 2 +-
 drivers/watchdog/Kconfig          | 2 +-
 include/linux/omap-dma.h          | 2 +-
 lib/mpi/mpi-inline.h              | 2 +-
 lib/mpi/mpi-internal.h            | 8 --------
 26 files changed, 39 insertions(+), 31 deletions(-)

-- 
1.8.3.2

Cc: bhelgaas at google.com
Cc: dwmw2 at infradead.org
Cc: dmitry.torokhov at gmail.com
Cc: balbi at ti.com
Cc: gregkh at linuxfoundation.org
Cc: plagnioj at jcrosoft.com
Cc: jic23 at kernel.org
Cc: josh.wu at atmel.com
Cc: kishon at ti.com
Cc: linus.walleij at linaro.org
Cc: broonie at kernel.org
Cc: mturquette at linaro.org
Cc: nicolas.ferre at atmel.com
Cc: ohad at wizery.com
Cc: linux at arm.linux.org.uk
Cc: tony at atomide.com
Cc: vinod.koul at intel.com
Cc: wim at iguana.be
Cc: wsa at the-dreams.de
Cc: dmaengine at vger.kernel.org
Cc: linux-i2c at vger.kernel.org
Cc: linux-ide at vger.kernel.org
Cc: linux-iio at vger.kernel.org
Cc: linux-input at vger.kernel.org
Cc: linux-mtd at lists.infradead.org
Cc: linux-pci at vger.kernel.org
Cc: linux-samsung-soc at vger.kernel.org
Cc: linux-sh at vger.kernel.org
Cc: linux-watchdog at vger.kernel.org
Cc: netdev at vger.kernel.org
