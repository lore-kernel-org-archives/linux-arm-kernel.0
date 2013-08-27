From: josh.wu@atmel.com (Josh Wu)
Date: Tue, 27 Aug 2013 19:28:46 +0800
Subject: [PATCH v3 0/6] iio: at91: Add touch screen support in at91 adc
Message-ID: <1377602932-1899-1-git-send-email-josh.wu@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series introduce multiple compatible string for different ip.
So remove some adc dt parameters as it already included in driver code.

It also touch screen support for at91 adc driver.
To enable touch screen you need add the touch screen related dt properties.

v2 --> v3:
  1. move the dt parameters to driver itself.
  2. trival fix in touch driver.

v1 --> v2:
  1. use multiple compatible string for different ADC IP.
  2. drop the patch that add the adc-clock in dt since we will move to clock
     common framework.
  3. don't expose the driver configuration to dt. Such like sample period,
     pen detect debounce time and etc.
  4. add a new dt parameter: ts-pressure-threshold.

Josh Wu (6):
  iio: at91: fix adc_clk overflow
  iio: at91: introduce the multiple compatible string for different
    IPs.
  iio: at91: Use different prescal, startup mask in MR for different IP
  iio: at91: ADC start-up time calculation changed since at91sam9x5
  iio: at91: move the num_channels from DT to driver itself
  iio: at91: introduce touch screen support in iio adc driver

 .../devicetree/bindings/arm/atmel-adc.txt          |   15 +-
 arch/arm/mach-at91/include/mach/at91_adc.h         |   50 +-
 drivers/iio/adc/at91_adc.c                         |  550 +++++++++++++++++---
 include/linux/platform_data/at91_adc.h             |    4 +
 4 files changed, 530 insertions(+), 89 deletions(-)

-- 
1.7.10
