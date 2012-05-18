From: thomas.abraham@linaro.org (Thomas Abraham)
Date: Fri, 18 May 2012 15:03:27 +0530
Subject: [PATCH v2 0/6] spi: s3c64xx: add support for device tree
Message-ID: <1337333613-6216-1-git-send-email-thomas.abraham@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Changes since v1:
- Incorporated changes suggested by Mark Brown
  - Merged 2nd, 3rd and 5th patch into one single patch.
  - Listed the order of gpios in the device tree support documentation.
  - Switched to generic property names for chip select gpio line and
    number of slave select lines.
- Moved the platform enablement patches for Exynos4 and Exynos5 into a
  different patch series.
- Included Ack from Jaswinder Singh <jaswinder.singh@linaro.org>.

This patch series adds device tree based discovery support for Samsung's
s3c64xx compatible spi controller. This is mainly tested for Exynos4210
and Exynos5250 with onboard spi nor flash device.

Thomas Abraham (6):
  spi: s3c64xx: remove unused S3C64XX_SPI_ST_TRLCNTZ macro
  spi: s3c64xx: move controller information into driver data
  ARM: Samsung: Remove pdev pointer paremeter from spi gpio setup functions
  ARM: Samsung: Modify s3c64xx_spi{0|1|2}_set_platdata function
  spi: s3c64xx: Remove the 'set_level' callback from controller data
  spi: s3c64xx: add device tree support

 .../devicetree/bindings/spi/spi-samsung.txt        |  113 +++++
 arch/arm/mach-exynos/clock-exynos4.c               |   18 +-
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
 20 files changed, 611 insertions(+), 300 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/spi/spi-samsung.txt
