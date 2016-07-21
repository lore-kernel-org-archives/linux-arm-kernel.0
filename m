From: gabriel.fernandez@st.com (gabriel.fernandez at st.com)
Date: Thu, 21 Jul 2016 11:19:24 +0200
Subject: [PATCH v2 0/4] Add STM32 Reset Driver
Message-ID: <1469092768-17489-1-git-send-email-gabriel.fernandez@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Gabriel Fernandez <gabriel.fernandez@st.com>

v2:
 - switch to the non-relaxed variants
 - describe dt-binfings in one place

The STM32 MCUs family IPs can be reset by accessing some registers
from the RCC block.

Gabriel Fernandez (1):
  ARM: dts: stm32f429: add missing #reset-cells of rcc

Maxime Coquelin (3):
  dt-bindings: mfd: Add STM32F4 RCC numeric constants into DT include
    file
  dt-bindings: Document the STM32 reset bindings
  drivers: reset: Add STM32 reset driver

 .../devicetree/bindings/clock/st,stm32-rcc.txt     |  42 ++++++--
 .../devicetree/bindings/reset/st,stm32-rcc.txt     |   6 ++
 arch/arm/boot/dts/stm32f429.dtsi                   |   1 +
 drivers/reset/Makefile                             |   1 +
 drivers/reset/reset-stm32.c                        | 113 +++++++++++++++++++++
 include/dt-bindings/mfd/stm32f4-rcc.h              |  98 ++++++++++++++++++
 6 files changed, 254 insertions(+), 7 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/reset/st,stm32-rcc.txt
 create mode 100644 drivers/reset/reset-stm32.c
 create mode 100644 include/dt-bindings/mfd/stm32f4-rcc.h

-- 
1.9.1
