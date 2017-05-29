From: fabrice.gasnier@st.com (Fabrice Gasnier)
Date: Mon, 29 May 2017 11:28:15 +0200
Subject: [PATCH v2 0/5] iio: add support for STM32H7 ADC
Message-ID: <1496050100-25854-1-git-send-email-fabrice.gasnier@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for STM32H7 Analog to Digital Converter variant.
It has up to 20 external channels, resolution ranges from 8 to 16bits.
Differences are regarding clocking, registers and bitfields have also
been re-arranged, but behavior is similar. It also has additional self
calibration and power on/off procedures.

---
Changes in v2:
- update bindings with Rob's remarks, document stm32h7 resolutions
- Slightly re-arrange channels definition, remove a trivial comment

Fabrice Gasnier (5):
  dt-bindings: iio: stm32-adc: add support for STM32H7
  iio: adc: stm32: make core adc clock optional by default
  iio: adc: stm32: introduce compatible data cfg
  iio: adc: stm32: make per instance bus clock optional
  iio: adc: stm32: add support for STM32H7

 .../devicetree/bindings/iio/adc/st,stm32-adc.txt   |  28 +-
 drivers/iio/adc/stm32-adc-core.c                   | 269 +++++++-
 drivers/iio/adc/stm32-adc-core.h                   |   2 +
 drivers/iio/adc/stm32-adc.c                        | 762 +++++++++++++++++++--
 4 files changed, 972 insertions(+), 89 deletions(-)

-- 
1.9.1
