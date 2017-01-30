From: fabrice.gasnier@st.com (Fabrice Gasnier)
Date: Mon, 30 Jan 2017 15:33:55 +0100
Subject: [PATCH v2 0/5] Add EXTI GPIO trigger support to STM32 ADC
Message-ID: <1485786840-4557-1-git-send-email-fabrice.gasnier@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

STM32 ADC, can use GPIOs configured as EXTI line (external interrupt)
as trigger source for conversions.
This patchset is based on latest IIO testing branch, and adds support
for EXTi GPIO triggers in IIO.
It also adds a dt option to configure default trigger polarity in
STM32 ADC driver.

---
Changes in V2:
- Fixed Kconfig dependencies

Fabrice Gasnier (5):
  Documentation: dt: iio: document stm32 adc trigger polarity
  iio: adc: stm32: add dt option to set default trigger polarity
  Documentation: dt: iio: document stm32 exti trigger
  iio: trigger: add support for STM32 EXTI triggers
  iio: adc: stm32: add exti gpio trigger source

 .../devicetree/bindings/iio/adc/st,stm32-adc.txt   |   3 +
 .../bindings/iio/trigger/st,stm32-exti-trigger.txt |  17 +++
 drivers/iio/adc/stm32-adc.c                        |  14 +++
 drivers/iio/trigger/Kconfig                        |  11 ++
 drivers/iio/trigger/Makefile                       |   1 +
 drivers/iio/trigger/stm32-exti-trigger.c           | 124 +++++++++++++++++++++
 include/linux/iio/trigger/stm32-exti-trigger.h     |  26 +++++
 7 files changed, 196 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/trigger/st,stm32-exti-trigger.txt
 create mode 100644 drivers/iio/trigger/stm32-exti-trigger.c
 create mode 100644 include/linux/iio/trigger/stm32-exti-trigger.h

-- 
1.9.1
