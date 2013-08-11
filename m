From: josh.wu@atmel.com (Josh Wu)
Date: Sun, 11 Aug 2013 19:04:27 +0800
Subject: [PATCH v2 0/4] iio: at91: Add touch screen support in at91 adc
Message-ID: <1376219071-29946-1-git-send-email-josh.wu@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series will add touch screen support for at91 adc driver.
To enable touch screen you need add the touch screen related dt properties.

v1 --> v2:
  1. use multiple compatible string for different ADC IP.
  2. drop the patch that add the adc-clock in dt since we will move to clock
     common framework.
  3. don't expose the driver configuration to dt. Such like sample period,
     pen detect debounce time and etc.
  4. add a new dt parameter: ts-pressure-threshold.

Josh Wu (4):
  iio: at91: fix adc_clk overflow
  iio: at91: Use different prescal, startup mask in MR for different IP
  iio: at91: ADC start-up time calculation changed since at91sam9x5
  iio: at91: introduce touch screen support in iio adc driver

 .../devicetree/bindings/arm/atmel-adc.txt          |   10 +-
 arch/arm/mach-at91/include/mach/at91_adc.h         |   41 +-
 drivers/iio/adc/at91_adc.c                         |  468 ++++++++++++++++++--
 3 files changed, 479 insertions(+), 40 deletions(-)

-- 
1.7.10
