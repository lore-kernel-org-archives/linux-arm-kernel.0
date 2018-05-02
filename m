From: fabrice.gasnier@st.com (Fabrice Gasnier)
Date: Wed, 2 May 2018 09:44:48 +0200
Subject: [PATCH v2 0/3] Add support for STM32MP1 ADC
Message-ID: <1525247091-18143-1-git-send-email-fabrice.gasnier@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for STM32MP1 Analog to Digital Converter variant.
It's quite similar to STM32H7 ADC and re-use most of existing driver.

---
Changes in v2:
- Update dt-bindings following Rob's remark: STM32MP1 ADC has two
  interrupt lines

Fabrice Gasnier (3):
  dt-bindings: iio: stm32-adc: add support for STM32MP1
  iio: adc: stm32-adc: add support for STM32MP1
  ARM: dts: stm32: Add ADC support to stm32mp157c

 .../devicetree/bindings/iio/adc/st,stm32-adc.txt   |  6 +-
 arch/arm/boot/dts/stm32mp157c.dtsi                 | 32 +++++++++++
 drivers/iio/adc/stm32-adc-core.c                   | 66 ++++++++++++++++------
 drivers/iio/adc/stm32-adc.c                        | 47 +++++++++++++--
 4 files changed, 128 insertions(+), 23 deletions(-)

-- 
1.9.1
