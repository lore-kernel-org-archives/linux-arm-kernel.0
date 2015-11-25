From: alexander.sverdlin@gmail.com (Alexander Sverdlin)
Date: Wed, 25 Nov 2015 12:50:16 +0100
Subject: [PATCH 0/5] iio: ADC driver for EP93xx SoC
Message-ID: <5655A078.5090201@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series prepares the necessary infrastructure for ADC platform device on
Cirrus Logic EP93xx family of SoCs and adds the driver for ADC device using
IIO subsystem.

Alexander Sverdlin (5):
  clk: ep93xx: Implement clk_get_parent()
  clk: ep93xx: Add ADC clock
  ep93xx: Add ADC platform device support to core
  edb93xx: Add ADC platform device
  iio: adc: New driver for Cirrus Logic EP93xx ADC

 arch/arm/mach-ep93xx/clock.c                 |  14 ++
 arch/arm/mach-ep93xx/core.c                  |  24 +++
 arch/arm/mach-ep93xx/edb93xx.c               |   1 +
 arch/arm/mach-ep93xx/include/mach/platform.h |   1 +
 arch/arm/mach-ep93xx/soc.h                   |   1 +
 drivers/iio/adc/Kconfig                      |  11 ++
 drivers/iio/adc/Makefile                     |   1 +
 drivers/iio/adc/ep93xx_adc.c                 | 253 +++++++++++++++++++++++++++
 8 files changed, 306 insertions(+)
 create mode 100644 drivers/iio/adc/ep93xx_adc.c
