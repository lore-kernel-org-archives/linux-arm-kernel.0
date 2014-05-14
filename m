From: gabriel.fernandez@st.com (Gabriel FERNANDEZ)
Date: Wed, 14 May 2014 15:24:08 +0200
Subject: [PATCH v2 00/10] ARM: STi: Add Clock driver support STiH415 & STiH416
Message-ID: <1400073858-28912-1-git-send-email-gabriel.fernandez@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Changes in v2:
 - move stih415-clks.h & stih416-clks.h to include/dt-bindings/clock/
 - add clk_ignore_unused to bootargs. Interconnect clocks are not yet
   managed at the init, then we have to start the kernel with 
   clk_ignore_unused.

The goal of this series is to add DT definition for STiH415 
and STiH416 SoCs on B2000 and B2020 boards.

Gabriel Fernandez (10):
  ARM: STi: DT: STiH416: 416 DT Entry for clockgen A0/1/10/11/12
  ARM: STi: DT: STiH416: Remove unused CLK_S_ICN_REG_0 fixed clock
  ARM: STi: DT: STiH416: Remove unused CLK_S_GMAC0_PHY & CLK_S_ETH1_PHY
    fixed clocks
  ARM: STi: DT: STiH416: 416 DT Entry for clockgen B/C/D/E/F
  ARM: STi: DT: STiH416: 416 DT Entry for clockgen A9/DDR/GPU
  ARM: STi: DT: STiH415: 415 DT Entry for clockgen A0/1/10/11/12
  ARM: STi: DT: STiH415: Remove unused CLK_S_ICN_REG_0 fixed clock
  ARM: STi: DT: STiH415: Remove unused CLK_S_GMAC0_PHY & CLK_S_ETH1_PHY
    fixed clocks
  ARM: STi: DT: STiH415: 415 DT Entry for clockgen A9
  ARM: STi: DT: STiH41x Add clk_ignore_unused to bootargs

 arch/arm/boot/dts/stih415-clock.dtsi     | 517 +++++++++++++++++++++-
 arch/arm/boot/dts/stih415.dtsi           |  10 +-
 arch/arm/boot/dts/stih416-clock.dtsi     | 732 ++++++++++++++++++++++++++++++-
 arch/arm/boot/dts/stih416.dtsi           |  10 +-
 arch/arm/boot/dts/stih41x-b2000.dtsi     |   2 +-
 arch/arm/boot/dts/stih41x-b2020.dtsi     |   2 +-
 include/dt-bindings/clock/stih415-clks.h |  15 +
 include/dt-bindings/clock/stih416-clks.h |  15 +
 8 files changed, 1258 insertions(+), 45 deletions(-)
 create mode 100644 include/dt-bindings/clock/stih415-clks.h
 create mode 100644 include/dt-bindings/clock/stih416-clks.h

-- 
1.9.1
