From: ludovic.Barre@st.com (Ludovic Barre)
Date: Fri, 7 Jul 2017 09:26:23 +0200
Subject: [PATCH 0/8] irqchip: stm32: add stm32h7 support
Message-ID: <1499412391-25480-1-git-send-email-ludovic.Barre@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ludovic Barre <ludovic.barre@st.com>

This series adds:
-management of multi-bank of external interrupts
stm32h7 has up to 96 inputs (3 banks of  32 inputs)
-fix initial value after cold/hot boot (wakeup issue)

Ludovic Barre (8):
  irqchip: stm32: select GENERIC_IRQ_CHIP
  irqchip: stm32: add multi-bank management
  dt-bindings: interrupt-controllers: add compatible string for stm32h7
  irqchip: stm32: add stm32h7 support
  irqchip: stm32: fix initial values
  irqchip: stm32: move the wakeup on interrupt mask
  ARM: dts: stm32: add exti support for stm32h743
  ARM: dts: stm32: add support of exti on stm32h743 pinctrl

 .../interrupt-controller/st,stm32-exti.txt         |   4 +-
 arch/arm/boot/dts/stm32h743-pinctrl.dtsi           |  24 +++
 arch/arm/boot/dts/stm32h743.dtsi                   |   8 +
 drivers/irqchip/Kconfig                            |   1 +
 drivers/irqchip/irq-stm32-exti.c                   | 194 +++++++++++++++------
 5 files changed, 181 insertions(+), 50 deletions(-)

-- 
2.7.4
