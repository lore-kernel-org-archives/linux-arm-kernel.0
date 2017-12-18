From: ludovic.Barre@st.com (Ludovic Barre)
Date: Mon, 18 Dec 2017 16:17:43 +0100
Subject: [PATCH V2 0/9] ARM: stm32: add initial STM32MPU support
Message-ID: <1513610272-7824-1-git-send-email-ludovic.Barre@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ludovic Barre <ludovic.barre@st.com>

change V2:
-Add stm32 documentation in this serie to avoid merge conflict
thread: "https://patchwork.kernel.org/patch/10102573/"
-Split bindings (stm32.txt) to separate patches.
-Remove ARCH_STM32_MCU/MPU flags
-Adopt rst format for Documentation/arm/stm32 files
-s/STMicrolectronics/STMicroelectronics/g

Ludovic Barre (9):
  devicetree: bindings: Document supported STM32 SoC family
  Documentation: arm: stm32: move to rst format
  ARM: stm32: prepare stm32 family to welcome armv7 architecture
  devicetree: bindings: stm32: add support of STM32MP157
  ARM: stm32: add initial support for STM32MP157
  pinctrl: stm32: Add STM32MP157 MPU support
  ARM: configs: multi_v7: add stm32 support
  ARM: dts: stm32: add stm32mp157c initial support
  ARM: dts: stm32: add initial support of stm32mp157c eval board

 Documentation/arm/stm32/overview.rst               |   34 +
 Documentation/arm/stm32/overview.txt               |   33 -
 Documentation/arm/stm32/stm32f429-overview.rst     |   26 +
 Documentation/arm/stm32/stm32f429-overview.txt     |   22 -
 Documentation/arm/stm32/stm32f746-overview.rst     |   33 +
 Documentation/arm/stm32/stm32f746-overview.txt     |   34 -
 Documentation/arm/stm32/stm32h743-overview.rst     |   34 +
 Documentation/arm/stm32/stm32h743-overview.txt     |   30 -
 Documentation/arm/stm32/stm32mp157-overview.rst    |   19 +
 Documentation/devicetree/bindings/arm/stm32.txt    |   10 +
 .../bindings/pinctrl/st,stm32-pinctrl.txt          |    2 +
 arch/arm/boot/dts/Makefile                         |    6 +-
 arch/arm/boot/dts/stm32mp157-pinctrl.dtsi          |  185 ++
 arch/arm/boot/dts/stm32mp157c-ed1.dts              |   29 +
 arch/arm/boot/dts/stm32mp157c-ev1.dts              |   19 +
 arch/arm/boot/dts/stm32mp157c.dtsi                 |  139 ++
 arch/arm/configs/multi_v7_defconfig                |    3 +
 arch/arm/mach-stm32/Kconfig                        |   35 +-
 arch/arm/mach-stm32/Makefile                       |    3 +-
 arch/arm/mach-stm32/{board-dt.c => board-mcu-dt.c} |    0
 arch/arm/mach-stm32/board-mpu-dt.c                 |   16 +
 drivers/pinctrl/stm32/Kconfig                      |    6 +
 drivers/pinctrl/stm32/Makefile                     |    1 +
 drivers/pinctrl/stm32/pinctrl-stm32mp157.c         | 2188 ++++++++++++++++++++
 24 files changed, 2773 insertions(+), 134 deletions(-)
 create mode 100644 Documentation/arm/stm32/overview.rst
 delete mode 100644 Documentation/arm/stm32/overview.txt
 create mode 100644 Documentation/arm/stm32/stm32f429-overview.rst
 delete mode 100644 Documentation/arm/stm32/stm32f429-overview.txt
 create mode 100644 Documentation/arm/stm32/stm32f746-overview.rst
 delete mode 100644 Documentation/arm/stm32/stm32f746-overview.txt
 create mode 100644 Documentation/arm/stm32/stm32h743-overview.rst
 delete mode 100644 Documentation/arm/stm32/stm32h743-overview.txt
 create mode 100644 Documentation/arm/stm32/stm32mp157-overview.rst
 create mode 100644 Documentation/devicetree/bindings/arm/stm32.txt
 create mode 100644 arch/arm/boot/dts/stm32mp157-pinctrl.dtsi
 create mode 100644 arch/arm/boot/dts/stm32mp157c-ed1.dts
 create mode 100644 arch/arm/boot/dts/stm32mp157c-ev1.dts
 create mode 100644 arch/arm/boot/dts/stm32mp157c.dtsi
 rename arch/arm/mach-stm32/{board-dt.c => board-mcu-dt.c} (100%)
 create mode 100644 arch/arm/mach-stm32/board-mpu-dt.c
 create mode 100644 drivers/pinctrl/stm32/pinctrl-stm32mp157.c

-- 
2.7.4
