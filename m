From: gabriel.fernandez@st.com (gabriel.fernandez at st.com)
Date: Thu, 8 Mar 2018 17:53:53 +0100
Subject: [PATCH v2 00/12] Introduce STM32MP1 clock driver
Message-ID: <1520528045-18330-1-git-send-email-gabriel.fernandez@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Gabriel Fernandez <gabriel.fernandez@st.com>

v2:
  - Don't use MFD, use existing binding of STM32 RCC.
  - Rework Peripheral and Kernel clocks
  - cosmetic changes

This patch-set introduces clock driver for STM32MP157 based on Arm Cortex-A7.
The driver patch is split in several patches (by kind of clock) to facilitate
code reviewing.

Gabriel Fernandez (12):
  dt-bindings: Document STM32MP1 Reset Clock Controller (RCC) bindings
  clk: stm32mp1: Introduce STM32MP1 clock driver
  clk: stm32mp1: add MP1 gate for hse/hsi/csi oscillators
  clk: stm32mp1: add Source Clocks for PLLs
  clk: stm32mp1: add PLL clocks
  clk: stm32mp1: add Post-dividers for PLL
  clk: stm32mp1: add Sub System clocks
  clk: stm32mp1: add Kernel timers
  clk: stm32mp1: add Peripheral & Kernel Clocks
  clk: stm32mp1: add RTC clock
  clk: stm32mp1: add MCO clocks
  clk: stm32mp1: add Debug clocks

 .../devicetree/bindings/clock/st,stm32mp1-rcc.txt  |   60 +
 drivers/clk/Kconfig                                |    6 +
 drivers/clk/Makefile                               |    1 +
 drivers/clk/clk-stm32mp1.c                         | 2117 ++++++++++++++++++++
 include/dt-bindings/clock/stm32mp1-clks.h          |  254 +++
 5 files changed, 2438 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/st,stm32mp1-rcc.txt
 create mode 100644 drivers/clk/clk-stm32mp1.c
 create mode 100644 include/dt-bindings/clock/stm32mp1-clks.h

-- 
1.9.1
