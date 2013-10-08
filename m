From: josh.wu@atmel.com (Josh Wu)
Date: Tue, 8 Oct 2013 11:48:53 +0800
Subject: [PATCH v4 0/3] Add touch screen support in at91 adc
Message-ID: <1381204136-32322-1-git-send-email-josh.wu@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series introduce multiple compatible string for different ip.
So remove some adc dt parameters as it already included in driver code.

It also touch screen support for at91 adc driver.
To enable touch screen you need add the touch screen related dt properties.

v3 --> v4:
  Seperate these 3 patches since the others are already in mainline.

Josh Wu (3):
  iio: at91: ADC start-up time calculation changed since at91sam9x5
  iio: at91: move the num_channels from DT to driver itself
  iio: at91: introduce touch screen support in iio adc driver

 .../devicetree/bindings/arm/atmel-adc.txt          |    8 +-
 arch/arm/mach-at91/include/mach/at91_adc.h         |   34 ++
 drivers/iio/adc/at91_adc.c                         |  453 ++++++++++++++++++--
 3 files changed, 456 insertions(+), 39 deletions(-)

-- 
1.7.9.5
