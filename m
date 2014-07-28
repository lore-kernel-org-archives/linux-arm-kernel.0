From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Mon, 28 Jul 2014 21:43:59 +0900
Subject: [PATCHv2 0/3] iio: adc: exynos_adc: Add support for s3c64xx/s3c24xx
 ADC
Message-ID: <1406551442-15186-1-git-send-email-cw00.choi@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch add support for s3c64xx/s3c24xx ADC. s3c64xx/s3c24xx is alomost same
as ADCv1. But, s3c64xx/s3c24xx has a little difference from ADCv1 as following:
- ADCMUX register address to select channel
- ADCDAT mask (10bit or 12bit ADC resolution according to SoC version)
- s3c24xx/s3c64xx has not included ADC_PHY enable register

Changes from v1:
- Fix minor coding style.
- Remove the sentence which reading DATY register.
- Add ARCH_S3C24XX / ARCH_S3C64XX dependency for EXYNOS_ADC to Kconfig.
- Remove the function pointer of 'clear_irq' for s3c24xx becase s3c24xx
  has not included ADC_V1_INTCLR register.
- Remove un-necessary white-space in dt-binding documentation

Arnd Bergmann (1):
  iio: adc: exynos_adc: add support for s3c64xx adc

Chanwoo Choi (2):
  iio: adc: exynos_adc: Add support for s3c24xx ADC
  dt-bindings: samsung: exynos_adc: Remove un-necessary white-sapce

 .../devicetree/bindings/arm/samsung/exynos-adc.txt |  20 ++-
 drivers/iio/adc/Kconfig                            |   2 +-
 drivers/iio/adc/exynos_adc.c                       | 137 +++++++++++++++++++--
 3 files changed, 144 insertions(+), 15 deletions(-)

-- 
1.8.0
