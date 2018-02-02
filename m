From: gabriel.fernandez@st.com (gabriel.fernandez at st.com)
Date: Fri, 2 Feb 2018 15:03:28 +0100
Subject: [PATCH 00/14] Introduce STM32MP1 clock driver
Message-ID: <1517580222-23301-1-git-send-email-gabriel.fernandez@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Gabriel Fernandez <gabriel.fernandez@st.com>

This patch-set introduces clock driver for STM32MP157 based on Arm Cortex-A7.
The driver patch is splitted in several patches (by kind of clock) to facilitate
code reviewing.

Gabriel Fernandez (14):
  dt-bindings: Document STM32MP1 Reset Clock Controller (RCC) bindings
  dt-bindings: clock: add STM32MP1 clocks
  clk: stm32mp1: Introduce STM32MP1 clock driver
  clk: stm32mp1: add MP1 gate for osc hse/hsi/csi oscillators
  clk: stm32mp1: add Source Clocks for PLLs
  clk: stm32mp1: add PLL clocks
  clk: stm32mp1: add Post-dividers for PLL
  clk: stm32mp1: add Sub System clocks
  clk: stm32mp1: add Kernel timers
  clk: stm32mp1: add Peripheral clocks
  clk: stm32mp1: add Kernel clocks
  clk: stm32mp1: add RTC clock
  clk: stm32mp1: add MCO clocks
  clk: stm32mp1: add Debug clocks

 .../devicetree/bindings/mfd/st,stm32-rcc.txt       |   85 +
 drivers/clk/Kconfig                                |    6 +
 drivers/clk/Makefile                               |    1 +
 drivers/clk/clk-stm32mp1.c                         | 1705 ++++++++++++++++++++
 include/dt-bindings/clock/stm32mp1-clks.h          |  248 +++
 5 files changed, 2045 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/st,stm32-rcc.txt
 create mode 100644 drivers/clk/clk-stm32mp1.c
 create mode 100644 include/dt-bindings/clock/stm32mp1-clks.h

-- 
1.9.1
