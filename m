From: amelie.delaunay@st.com (Amelie Delaunay)
Date: Fri, 16 Dec 2016 09:50:49 +0100
Subject: [PATCHv2 0/8] Add support for STM32 RTC
Message-ID: <1481878257-29163-1-git-send-email-amelie.delaunay@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

v2:
- remove clock-names and interrupt-names from bindings
- remove unuseful headers
- clean stm32_rtc structure
- replace stm32_rtc_readl/_writel by readl/writel_relaxed
- use threaded IRQ
- rework set_alarm
- add various comments
- select COMPILE_TEST and REGMAP_MMIO

This patchset adds support for the STM32 Real-Time Clock.
This RTC is an independent BCD timer/counter and provides a time-of-day
clock/calendar with programmable alarm interrupt.
RTC calendar can be driven by three clock sources LSE, LSI or HSE.

Amelie Delaunay (8):
  ARM: dts: stm32: set HSE_RTC clock frequency to 1 MHz on stm32f429
  dt-bindings: document the STM32 RTC bindings
  rtc: add STM32 RTC driver
  ARM: dts: stm32: Add RTC support for STM32F429 MCU
  ARM: dts: stm32: enable RTC on stm32f429-disco
  ARM: dts: stm32: enable RTC on stm32f469-disco
  ARM: dts: stm32: enable RTC on stm32429i-eval
  ARM: configs: stm32: Add RTC support in STM32 defconfig

 .../devicetree/bindings/rtc/st,stm32-rtc.txt       |  27 +
 arch/arm/boot/dts/stm32429i-eval.dts               |   4 +
 arch/arm/boot/dts/stm32f429-disco.dts              |   6 +
 arch/arm/boot/dts/stm32f429.dtsi                   |  16 +
 arch/arm/boot/dts/stm32f469-disco.dts              |   4 +
 arch/arm/configs/stm32_defconfig                   |   2 +
 drivers/rtc/Kconfig                                |  11 +
 drivers/rtc/Makefile                               |   1 +
 drivers/rtc/rtc-stm32.c                            | 776 +++++++++++++++++++++
 9 files changed, 847 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/rtc/st,stm32-rtc.txt
 create mode 100644 drivers/rtc/rtc-stm32.c

-- 
1.9.1
