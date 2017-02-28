From: fabrice.gasnier@st.com (Fabrice Gasnier)
Date: Tue, 28 Feb 2017 17:51:13 +0100
Subject: [PATCH v3 0/6] Add EXTI GPIO trigger support to STM32 ADC
Message-ID: <1488300679-3259-1-git-send-email-fabrice.gasnier@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

STM32 ADC, can use EXTI line (external interrupt) as trigger source
for conversions.
This patchset introduces:
- IIO trigger providers / consumers that can be configured from DT
- DT support for IIO interrupt trigger
- STM32 ADC EXTI trigger selection, configured by DT.

---
Changes in V3:
- Rework most of it, to use generic iio-interrupt-trigger
- Drop GPIO trigger, use generic interrupt binding instead
- Comments from V2 and RFC: iio: trigger: Add OF support and GPIO based trigger
  https://lkml.org/lkml/2017/2/17/478

---
Changes in V2:
- Fixed Kconfig dependencies

Fabrice Gasnier (5):
  dt-bindings: iio: introduce trigger providers, consumers
  iio: trigger: add OF support
  dt-bindings: iio: document interrupt trigger support
  dt-bindings: iio: stm32-adc: add external interrupt trigger
  iio: adc: stm32: add support for EXTI trigger

Gr?gor Boirie (1):
  iio: iio-interrupt-trigger: device-tree support

 .../devicetree/bindings/iio/adc/st,stm32-adc.txt   |  21 +++++
 .../devicetree/bindings/iio/iio-bindings.txt       |  38 ++++++++
 .../bindings/iio/trigger/iio-trig-interrupt.txt    |  22 +++++
 drivers/iio/adc/stm32-adc.c                        |  27 +++++-
 drivers/iio/industrialio-trigger.c                 | 100 +++++++++++++++++++++
 drivers/iio/trigger/iio-trig-interrupt.c           |  10 +++
 include/linux/iio/trigger.h                        |   4 +
 7 files changed, 219 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/trigger/iio-trig-interrupt.txt

-- 
1.9.1
