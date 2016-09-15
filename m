From: alexandre.torgue@st.com (Alexandre TORGUE)
Date: Thu, 15 Sep 2016 18:42:32 +0200
Subject: [PATCH 00/11] STM32 USART: fixes and new MCU support
Message-ID: <1473957763-30629-1-git-send-email-alexandre.torgue@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series adds some fixes for stm32 uart, add DMA support for improve IP
behaviour, and add usart support of STM32F7 MCU.

Regards

Alex

Alexandre TORGUE (11):
  serial: stm32: adding support for stm32f7
  DOCUMENTATION: dt-bindings: Document the STM32 USART bindings
  serial: stm32: header file creation
  serial: stm32: disable tx and rx during shutdown
  serial: stm32: correct flow control property spelling
  serial: stm32: clock disabling management
  dt-bindings: Add DMA bindings for STM32 USART
  serial: stm32: adding dma support
  serial: stm32: fix spin_lock management
  serial: stm32: fix uart enable management
  ARM: DT: STM32: add dma for usart1 on F429

 .../devicetree/bindings/serial/st,stm32-usart.txt  |  46 ++
 arch/arm/boot/dts/stm32f429.dtsi                   |   3 +
 drivers/tty/serial/stm32-usart.c                   | 612 ++++++++++++++++-----
 drivers/tty/serial/stm32-usart.h                   | 229 ++++++++
 4 files changed, 739 insertions(+), 151 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/serial/st,stm32-usart.txt
 create mode 100644 drivers/tty/serial/stm32-usart.h

-- 
1.9.1
