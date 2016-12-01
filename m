From: gabriel.fernandez@st.com (gabriel.fernandez at st.com)
Date: Thu, 1 Dec 2016 16:27:40 +0100
Subject: [PATCH v3 0/9] STM32F4 missing clocks
Message-ID: <1480606069-5178-1-git-send-email-gabriel.fernandez@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Gabriel Fernandez <gabriel.fernandez@st.com>

v3:
 - restructure the patch series to have only one patch for all bindings changes.
   (clk: stm32f4: Update DT bindings documentation)

v2:
 - Put post divider in config structure
 - Rework patch-set
    - add update dt binding documentation
    - add clock definition file
 - Use composite for pll vco clocks
 - For auxiliary clock, allow the possiblity to enable peripheral
   clocks at same time (sugested by radek)
 - Add vco_in clock (entry frequency for all pll) to simplify the code and clarify clock tree
 - Fix missing end of divider tables

This patch-set adds:
 - I2S & SAI PLLs
 - SDIO & 48 Mhz clocks
 - LCD-TFT clock
 - I2S & SAI clocks

Gabriel Fernandez (9):
  clk: stm32f4: Update DT bindings documentation
  clk: stm32f4: Add PLL_I2S & PLL_SAI for STM32F429/469 boards
  clk: stm32f4: Add post divisor for I2S & SAI PLLs
  clk: stm32f4: Add lcd-tft clock
  clk: stm32f4: Add I2S clock
  clk: stm32f4: Add SAI clocks
  clk: stm32f4: SDIO & 48Mhz clock management for STM32F469 board
  ARM: dts: stm32f4: Add external I2S clock
  ARM: dts: stm32f4: Include auxiliary stm32f4 clock definition

 .../devicetree/bindings/clock/st,stm32-rcc.txt     |  15 +
 arch/arm/boot/dts/stm32f429.dtsi                   |   9 +-
 drivers/clk/clk-stm32f4.c                          | 585 ++++++++++++++++++++-
 include/dt-bindings/clock/stm32f4-clock.h          |  37 ++
 4 files changed, 626 insertions(+), 20 deletions(-)
 create mode 100644 include/dt-bindings/clock/stm32f4-clock.h

-- 
1.9.1
