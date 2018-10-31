From: benjamin.gaignard@linaro.org (Benjamin Gaignard)
Date: Wed, 31 Oct 2018 10:30:27 +0100
Subject: [PATCH 0/5] Add support of STM32 hwspinlock
Message-ID: <20181031093032.20386-1-benjamin.gaignard@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This serie adds the support of the hardware semaphore block for stm32mp1 SoC.
The last patch isn't related to the hardware itself but propose a way to test
hwspinlocks.

Benjamin Gaignard (5):
  dt-bindings: hwlock: Document STM32 hwspinlock bindings
  hwspinlock: add STM32 hwspinlock device
  ARM: dts: stm32: Add hwspinlock node for stm32mp157 SoC
  ARM: dts: stm32: enable hwspinlock on stm32mp157c-ed1
  hwspinlock: Add test module

 .../bindings/hwlock/st,stm32-hwspinlock.txt        |  23 ++++
 arch/arm/boot/dts/stm32mp157c-ed1.dts              |   4 +
 arch/arm/boot/dts/stm32mp157c.dtsi                 |   9 ++
 drivers/hwspinlock/Kconfig                         |  18 +++
 drivers/hwspinlock/Makefile                        |   2 +
 drivers/hwspinlock/hwspinlock_test.c               | 132 ++++++++++++++++++
 drivers/hwspinlock/stm32_hwspinlock.c              | 147 +++++++++++++++++++++
 7 files changed, 335 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/hwlock/st,stm32-hwspinlock.txt
 create mode 100644 drivers/hwspinlock/hwspinlock_test.c
 create mode 100644 drivers/hwspinlock/stm32_hwspinlock.c

-- 
2.15.0
