From: gabriel.fernandez@st.com (gabriel.fernandez at st.com)
Date: Mon, 4 Jul 2016 15:44:57 +0200
Subject: [PATCH 0/4] Add STM32 Reset Driver
Message-ID: <1467639897-6582-1-git-send-email-gabriel.fernandez@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Gabriel Fernandez <gabriel.fernandez@st.com>

The STM32 MCUs family IPs can be reset by accessing some registers
from the RCC block.

Gabriel Fernandez (2):
  drivers: reset: Add STM32 reset driver
  ARM: dts: stm32f429: add missing #reset-cells of rcc

Maxime Coquelin (2):
  dt-bindings: mfd: Add STM32F4 RCC numeric constants into DT include
    file
  dt-bindings: Document the STM32 reset bindings

 .../devicetree/bindings/reset/st,stm32-rcc.txt     |  50 +++++++++
 arch/arm/boot/dts/stm32f429.dtsi                   |   1 +
 drivers/reset/Makefile                             |   1 +
 drivers/reset/reset-stm32.c                        | 113 +++++++++++++++++++++
 include/dt-bindings/mfd/stm32f4-rcc.h              |  92 +++++++++++++++++
 5 files changed, 257 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/reset/st,stm32-rcc.txt
 create mode 100644 drivers/reset/reset-stm32.c
 create mode 100644 include/dt-bindings/mfd/stm32f4-rcc.h

-- 
1.9.1
