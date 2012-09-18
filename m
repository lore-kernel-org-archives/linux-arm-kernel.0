From: sjg@chromium.org (Simon Glass)
Date: Tue, 18 Sep 2012 11:21:52 -0700
Subject: [PATCH 0/7] Add support for Exynos5 ISP SPI ports
Message-ID: <1347992519-6904-1-git-send-email-sjg@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series adds support for the two additional SPI ports on exynos,
attached to the ISP.

I have included a required PM patch as well, so that it compiles.

This has been tested using flashrom on SPI1, and a chip to chip SPI
interface (with an STM32 micro) on ISP SPI1.

This series may need more work, but I think it is worth sending out as is.


Prathyush K (1):
  PM / Domains: add generic function 'pm_genpd_of_add_device_by_name'

Simon Glass (6):
  spi: s3c64xx: Fix enum dma_data_direction warning
  spi: s3c64xx: Add support for ISP SPI ports
  spi: s3c64xx: Use jiffies instead of loops for timeout
  spi: s3c64xx: Allow use with SPI ports without dma
  spi: s3c64xx: Tidy up SPI chip select handling
  spi: s3c64xx: Write to PACKET_CNT after reset

 .../devicetree/bindings/spi/spi-samsung.txt        |    7 +
 arch/arm/mach-exynos/clock-exynos5.c               |   69 +++++++++
 arch/arm/mach-exynos/include/mach/map.h            |    2 +
 arch/arm/mach-exynos/include/mach/regs-clock.h     |    1 +
 arch/arm/mach-exynos/mach-exynos5-dt.c             |    4 +
 arch/arm/plat-samsung/include/plat/s3c64xx-spi.h   |    6 +-
 drivers/spi/spi-s3c64xx.c                          |  150 +++++++++++++-------
 include/linux/pm_domain.h                          |   19 +++
 8 files changed, 202 insertions(+), 56 deletions(-)

-- 
1.7.7.3
