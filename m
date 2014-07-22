From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Tue, 22 Jul 2014 11:11:12 +0900
Subject: [PATCH 0/2] iio: adc: exynos_adc: Add support for s3c64xx/s3c24xx ADC
Message-ID: <1405995074-3271-1-git-send-email-cw00.choi@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch add support for s3c64xx/s3c24xx ADC. s3c64xx/s3c24xx is alomost same
as ADCv1. But, s3c64xx/s3c24xx has a little difference from ADCv1 as following:
- ADCMUX register address to select channel
- ADCDAT mask (10bit or 12bit ADC resolution according to SoC version)

This patchset is implemented based on exynos3250 ADC patchset[1].
 [1] http://www.spinics.net/lists/kernel/msg1791299.html

Arnd Bergmann (1):
  iio: adc: exynos_adc: add support for s3c64xx adc

Chanwoo Choi (1):
  iio: adc: exynos_adc: Add support for S3C24xx ADC

 .../devicetree/bindings/arm/samsung/exynos-adc.txt |  12 +-
 drivers/iio/adc/exynos_adc.c                       | 121 ++++++++++++++++++++-
 2 files changed, 129 insertions(+), 4 deletions(-)

-- 
1.8.0
