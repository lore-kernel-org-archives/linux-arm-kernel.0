From: yannick.fertre@st.com (Yannick Fertre)
Date: Wed, 22 Mar 2017 14:36:21 +0100
Subject: [PATCH v1 0/5] STM32 Independant watchdog
Message-ID: <1490189786-19232-1-git-send-email-yannick.fertre@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Version 1:
- Initial commit

The purpose of this set of patches is to add a new watchdog driver for
stm32f429.
This driver was developed and tested on evaluation board stm32429i.

Yannick Fertre (5):
  dt-bindings: Document STM32 IWDG bindings
  drivers: watchdog: Add STM32 IWDG driver
  ARM: dts: stm32ap: Add watchdog support for STM32F429 SoC
  ARM: dts: stm32ap: Add watchdog support for STM32F429 eval board
  ARM: configs: Add watchdog support in STM32 defconfig

 .../devicetree/bindings/watchdog/st,stm32-iwdg.txt |  15 ++
 arch/arm/boot/dts/stm32429i-eval.dts               |   4 +
 arch/arm/boot/dts/stm32f429.dtsi                   |   9 +-
 arch/arm/configs/stm32_defconfig                   |   1 +
 drivers/watchdog/Kconfig                           |  11 +
 drivers/watchdog/Makefile                          |   1 +
 drivers/watchdog/stm32_iwdg.c                      | 289 +++++++++++++++++++++
 7 files changed, 329 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/watchdog/st,stm32-iwdg.txt
 create mode 100644 drivers/watchdog/stm32_iwdg.c

-- 
1.9.1
