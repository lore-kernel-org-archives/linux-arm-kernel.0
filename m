From: thomas.abraham@linaro.org (Thomas Abraham)
Date: Wed, 09 May 2012 03:34:44 +0530
Subject: [PATCH 00/10] spi: s3c64xx: add support for device tree
Message-ID: <1336514694-22393-1-git-send-email-thomas.abraham@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series adds device tree based discovery support for Samsung's
s3c64xx compatible spi controller. This is mainly tested for Exynos4210
and Exynos5250 with onboard spi nor flash device.

This patch series is based on Linux 3.4-rc5 with the following two
patch series applied.

[1] http://www.mail-archive.com/linux-samsung-soc at vger.kernel.org/msg10494.html
    [PATCH 00/20] ARM: Samsung: Add support for Exynos5250 Rev1.0

[2] http://www.mail-archive.com/linux-samsung-soc at vger.kernel.org/msg09640.html
    [PATCH 0/6] S3C24XX: Add support for HSSPI on S3C2416/S3C2443

Thomas Abraham (10):
  spi: s3c64xx: remove unused S3C64XX_SPI_ST_TRLCNTZ macro
  spi: s3c64xx: move controller information into driver data
  ARM: Samsung: Remove spi hardware controller information from platform data
  ARM: Samsung: Remove pdev pointer paremeter from spi gpio setup functions
  ARM: Samsung: Update the device names for spi clock lookup
  ARM: Samsung: Modify s3c64xx_spi{0|1|2}_set_platdata function
  spi: s3c64xx: Remove the 'set_level' callback from controller data
  ARM: Exynos4: Fix the incorrect hierarchy of spi controller bus clock
  ARM: Exynos5: Add spi clock support
  spi: s3c64xx: add device tree support

.../devicetree/bindings/spi/spi-samsung.txt        |  113 +++++
 arch/arm/mach-exynos/clock-exynos4.c               |   66 ++-
 arch/arm/mach-exynos/clock-exynos5.c               |   98 ++++
 arch/arm/mach-exynos/include/mach/regs-clock.h     |    4 +
 arch/arm/mach-exynos/setup-spi.c                   |   33 +--
 arch/arm/mach-s3c24xx/clock-s3c2416.c              |    2 +-
 arch/arm/mach-s3c24xx/clock-s3c2443.c              |    2 +-
 arch/arm/mach-s3c24xx/common-s3c2443.c             |    4 +-
 arch/arm/mach-s3c24xx/setup-spi.c                  |   10 +-
 arch/arm/mach-s3c64xx/clock.c                      |   20 +-
 arch/arm/mach-s3c64xx/mach-crag6410.c              |    2 +-
 arch/arm/mach-s3c64xx/setup-spi.c                  |   19 +-
 arch/arm/mach-s5p64x0/clock-s5p6440.c              |   12 +-
 arch/arm/mach-s5p64x0/clock-s5p6450.c              |   12 +-
 arch/arm/mach-s5p64x0/setup-spi.c                  |   21 +-
 arch/arm/mach-s5pc100/clock.c                      |   30 +-
 arch/arm/mach-s5pc100/setup-spi.c                  |   30 +--
 arch/arm/mach-s5pv210/clock.c                      |   14 +-
 arch/arm/mach-s5pv210/setup-spi.c                  |   21 +-
 arch/arm/plat-samsung/devs.c                       |   50 +--
 arch/arm/plat-samsung/include/plat/s3c64xx-spi.h   |   31 +-
 drivers/spi/spi-s3c64xx.c                          |  467 +++++++++++++++++---
 22 files changed, 753 insertions(+), 308 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/spi/spi-samsung.txt
