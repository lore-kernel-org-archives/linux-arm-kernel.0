From: ludovic.Barre@st.com (Ludovic Barre)
Date: Fri, 8 Dec 2017 15:11:11 +0100
Subject: [PATCH 0/6] ARM: stm32: add initial STM32MPU support
Message-ID: <1512742277-28205-1-git-send-email-ludovic.Barre@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ludovic Barre <ludovic.barre@st.com>

This patch series extends the existing STM32 microcontrollers (MCUs)
family to microprocessors (MPUs). The MPU platform (based on
Arm Cortex-A) is a continuation of the MCU one (based on Arm
Cortex-M) in that it shares a wide number of hardware blocks.

Ludovic Barre (6):
  ARM: stm32: prepare stm32 family to welcome armv7 architecture
  ARM: stm32: add initial support for STM32MP157
  pinctrl: stm32: Add STM32MP157 MPU support
  ARM: configs: multi_v7: add stm32 support
  ARM: dts: stm32: add stm32mp157c initial support
  ARM: dts: stm32: add initial support of stm32mp157c eval board

 Documentation/arm/stm32/overview.txt               |   21 +-
 Documentation/arm/stm32/stm32mp157-overview.txt    |   12 +
 Documentation/devicetree/bindings/arm/stm32.txt    |    1 +
 .../bindings/pinctrl/st,stm32-pinctrl.txt          |    2 +
 arch/arm/boot/dts/Makefile                         |    5 +-
 arch/arm/boot/dts/stm32mp157-pinctrl.dtsi          |  185 ++
 arch/arm/boot/dts/stm32mp157c-ed1.dts              |   29 +
 arch/arm/boot/dts/stm32mp157c-ev1.dts              |   19 +
 arch/arm/boot/dts/stm32mp157c.dtsi                 |  139 ++
 arch/arm/configs/multi_v7_defconfig                |    2 +
 arch/arm/mach-stm32/Kconfig                        |   48 +-
 arch/arm/mach-stm32/Makefile                       |    3 +-
 arch/arm/mach-stm32/{board-dt.c => board-mcu-dt.c} |    0
 arch/arm/mach-stm32/board-mpu-dt.c                 |   16 +
 drivers/pinctrl/stm32/Kconfig                      |    6 +
 drivers/pinctrl/stm32/Makefile                     |    1 +
 drivers/pinctrl/stm32/pinctrl-stm32mp157.c         | 2188 ++++++++++++++++++++
 17 files changed, 2656 insertions(+), 21 deletions(-)
 create mode 100644 Documentation/arm/stm32/stm32mp157-overview.txt
 create mode 100644 arch/arm/boot/dts/stm32mp157-pinctrl.dtsi
 create mode 100644 arch/arm/boot/dts/stm32mp157c-ed1.dts
 create mode 100644 arch/arm/boot/dts/stm32mp157c-ev1.dts
 create mode 100644 arch/arm/boot/dts/stm32mp157c.dtsi
 rename arch/arm/mach-stm32/{board-dt.c => board-mcu-dt.c} (100%)
 create mode 100644 arch/arm/mach-stm32/board-mpu-dt.c
 create mode 100644 drivers/pinctrl/stm32/pinctrl-stm32mp157.c

-- 
2.7.4
