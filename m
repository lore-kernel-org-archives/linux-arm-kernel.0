From: alexandre.torgue@st.com (Alexandre TORGUE)
Date: Wed, 26 Oct 2016 17:11:18 +0200
Subject: [PATCH 0/5] ADD STM32F746 MCU and STM32746G-Eval board supports 
Message-ID: <1477494683-29890-1-git-send-email-alexandre.torgue@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series adds basic support for STM32F746 MCU and stm32746g-eval board.
With it, you can boot stm32746g-eval board successfully.
In this series timer, usart/uart, exti, rng, basic rcc IPs are supported.
Other Ips (Ethernet, dma, ...) will come later.

For your information:

The STMicrolectornics's STM32F746 MCU has the following main features:
 - Cortex-M7 core running up to @216MHz
 - 1MB internal flash, 320KBytes internal RAM (+4KB of backup SRAM)
 - FMC controller to connect SDRAM, NOR and NAND memories
 - Dual mode QSPI
 - SD/MMC/SDIO support
 - Ethernet controller
 - USB OTFG FS & HS controllers
 - I2C, SPI, CAN busses support
 - Several 16 & 32 bits general purpose timers
 - Serial Audio interface
 - LCD controller
 - HDMI-CEC
 - SPDIFRX 

Regards

Alex

Alexandre TORGUE (5):
  ARM: mach-stm32: Add a new SOC - STM32F746
  ARM: Kconfig: Introduce MACH_STM32F746 flag
  ARM: dts: Add STM32F746 MCU and STM32746g-EVAL board
  ARM: configs: Add new config fragment to change RAM start point
  ARM: configs: Add new config fragment to change RAM size

 Documentation/arm/stm32/overview.txt           |   3 +-
 Documentation/arm/stm32/stm32f746-overview.txt |  34 +++
 arch/arm/Kconfig                               |   5 +
 arch/arm/boot/dts/Makefile                     |   3 +-
 arch/arm/boot/dts/stm32746g-eval.dts           |  96 ++++++++
 arch/arm/boot/dts/stm32f746.dtsi               | 304 +++++++++++++++++++++++++
 arch/arm/configs/dram_0xc0000000.config        |   1 +
 arch/arm/configs/dram_size_0x2000000.config    |   1 +
 arch/arm/mach-stm32/board-dt.c                 |   1 +
 9 files changed, 446 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/arm/stm32/stm32f746-overview.txt
 create mode 100644 arch/arm/boot/dts/stm32746g-eval.dts
 create mode 100644 arch/arm/boot/dts/stm32f746.dtsi
 create mode 100644 arch/arm/configs/dram_0xc0000000.config
 create mode 100644 arch/arm/configs/dram_size_0x2000000.config

-- 
1.9.1
