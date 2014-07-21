From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Mon, 21 Jul 2014 11:17:44 +0900
Subject: [PATCHv7 0/4] iio: adc: exynos_adc: Support Exynos3250 ADC and code
 clean
Message-ID: <1405909068-22539-1-git-send-email-cw00.choi@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset support Exynos3250 ADC (Analog Digital Converter) because
Exynos3250 has additional special clock for ADC IP.

Changes from v6:
- Use "exynos3250-adc" compatible string instead of "exynos3250-adc-v2"
- Use "sclk" clock name instead of "sclk_adc"
- Remove un-necessary macro for exyno-adc-data-v2 structure.
- Remove '(void *)' cast and mark the exynos-adc-data structure as 'const'
- Change the number of ADC channels (Exynos3250 has only two channels for ADC)

Changes from v5:
- Add acked message by Kukjin Kim
- Add reviewed messgae by Tomasz Figa
- Fix typo (for for -> for)

Changes from v4:
- Use 'exynos_adc_data' structure instead of 'exynos_adc_ops' structure
  and remove enum variable of ADC version
- Fix wrong name of special clock (sclk_tsadc -> sclk_adc)
- Add reviewed message by Naveen Krishna Chatradhi
- Add functions for ADC clock control

Changes from v3:
- Add new 'exynos_adc_ops' structure to improve readability according to
 Tomasz Figa comment[1]
 [1] https://lkml.org/lkml/2014/4/16/238
- Add new 'exynos3250-adc-v2' compatible string to support Exynos3250 ADC
- Fix wrong compaitlbe string of ADC in Exynos3250 dtsi file

Changes from v2:
- Check return value of clock function to deal with error exception
- Fix minor coding style to improve readability

Changes from v1:
- Add new "samsung,exynos-adc-v3" compatible to support Exynos3250 ADC
- Add a patch about DT binding documentation


Chanwoo Choi (4):
  iio: adc: exynos_adc: Add exynos_adc_data structure to improve
    readability
  iio: adc: exynos_adc: Control special clock of ADC to support
    Exynos3250 ADC
  iio: devicetree: Add DT binding documentation for Exynos3250 ADC
  ARM: dts: Fix wrong compatible string for Exynos3250 ADC

 .../devicetree/bindings/arm/samsung/exynos-adc.txt |  25 +-
 arch/arm/boot/dts/exynos3250.dtsi                  |   4 +-
 drivers/iio/adc/exynos_adc.c                       | 335 +++++++++++++++------
 3 files changed, 274 insertions(+), 90 deletions(-)

-- 
1.8.0
