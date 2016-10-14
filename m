From: gabriel.fernandez@st.com (gabriel.fernandez at st.com)
Date: Fri, 14 Oct 2016 11:18:13 +0200
Subject: [PATCH v2 0/6] STM32F4 Add RTC & QSPI clocks
Message-ID: <1476436699-21879-1-git-send-email-gabriel.fernandez@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Gabriel Fernandez <gabriel.fernandez@st.com>

v2:
 - rename compatible property "st,stm32f46xx-rcc" into "st,stm32f469-rcc"
 - cosmetic: remove bad copy/paste

This patch-set introduce RTC and QSPI clocks for STM32F4 socs
RTC clock has 3 parents clock oscillators (lsi/lse/hse_rtc)

example to use rtc clock:

		rtc: rtc at 40002800 {
			compatible = "st,stm32-rtc";
			reg = <0x40002800 0x400>;
			...
			clocks = <&rcc 1 CLK_RTC>;

			assigned-clocks =  <&rcc 1 CLK_RTC>;
			assigned-clock-parents = <&rcc 1 CLK_LSE>;
			...
		};

Gabriel Fernandez (6):
  clk: stm32f4: Add LSI & LSE clocks
  ARM: dts: stm32f429: add LSI and LSE clocks
  arm: stmf32: Enable SYSCON
  clk: stm32f4: Add RTC clock
  clk: stm32f469: Add QSPI clock
  ARM: dts: stm32f429: Add QSPI clock

 .../devicetree/bindings/clock/st,stm32-rcc.txt     |   4 +-
 arch/arm/boot/dts/stm32f429.dtsi                   |  18 +
 arch/arm/boot/dts/stm32f469-disco.dts              |   4 +
 arch/arm/configs/stm32_defconfig                   |   1 +
 drivers/clk/clk-stm32f4.c                          | 442 ++++++++++++++++++++-
 5 files changed, 447 insertions(+), 22 deletions(-)

-- 
1.9.1
