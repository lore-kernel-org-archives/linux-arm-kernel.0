From: amelie.delaunay@st.com (Amelie Delaunay)
Date: Fri, 2 Dec 2016 15:09:53 +0100
Subject: [PATCH 0/8] Add support for STM32 RTC
Message-ID: <1480687801-19525-2-git-send-email-amelie.delaunay@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset adds support for the STM32 Real-Time Clock.
This RTC is an independent BCD timer/counter and provides a time-of-day
clock/calendar with programmable alarm interrupt.
RTC calendar can be driven by three clock sources LSE, LSI or HSE.

Amelie Delaunay (8):
  ARM: dts: stm32: set HSE_RTC clock frequency to 1 MHz on stm32f429
  dt-bindings: document the STM32 RTC bindings
  rtc: add STM32 RTC driver
  ARM: dts: stm32: Add STM32 RTC support for STM32F429 MCU
  ARM: dts: stm32: enable RTC on stm32f429-disco
  ARM: dts: stm32: enable RTC on stm32f469-disco
  ARM: dts: stm32: enable RTC on stm32429i-eval
  ARM: configs: stm32: Add STM32 RTC support in STM32 defconfig

 .../devicetree/bindings/rtc/st,stm32-rtc.txt       |  31 +
 arch/arm/boot/dts/stm32429i-eval.dts               |   4 +
 arch/arm/boot/dts/stm32f429-disco.dts              |   6 +
 arch/arm/boot/dts/stm32f429.dtsi                   |  16 +
 arch/arm/boot/dts/stm32f469-disco.dts              |   4 +
 arch/arm/configs/stm32_defconfig                   |   2 +
 drivers/rtc/Kconfig                                |  10 +
 drivers/rtc/Makefile                               |   1 +
 drivers/rtc/rtc-stm32.c                            | 777 +++++++++++++++++++++
 9 files changed, 851 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/rtc/st,stm32-rtc.txt
 create mode 100644 drivers/rtc/rtc-stm32.c

-- 
1.9.1
