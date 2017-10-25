From: fabrice.gasnier@st.com (Fabrice Gasnier)
Date: Wed, 25 Oct 2017 11:27:42 +0200
Subject: [PATCH v2 0/3] iio: adc: stm32: Add support for differential channels
Message-ID: <1508923665-2274-1-git-send-email-fabrice.gasnier@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for differential channels that can be found on STM32H7 ADC:
- Introduce new DT property 'st,adc-diff-channels'.
- Slightly rework single-ended channels definition in stm32-adc driver.
- Add support for differential channels to stm32-adc driver.

---
Changes in v2:
- Add an example and a note in dt-bindings to better explain
 'st,adc-diff-channels' usage (based on Jonathan & Rob remarks).
- Update variable names in stm32_adc_chan_init_one() based on Jonathan remark.

Fabrice Gasnier (3):
  dt-bindings: iio: adc: stm32: add support for diff channels
  iio: adc: stm32: remove const channel names definition
  iio: adc: stm32: add support for differential channels

 .../devicetree/bindings/iio/adc/st,stm32-adc.txt   |  24 +++
 drivers/iio/adc/stm32-adc.c                        | 181 +++++++++++++--------
 2 files changed, 137 insertions(+), 68 deletions(-)

-- 
1.9.1
