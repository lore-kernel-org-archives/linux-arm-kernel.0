From: benjamin.gaignard@linaro.org (Benjamin Gaignard)
Date: Tue, 13 Nov 2018 15:48:02 +0100
Subject: [PATCH 0/3] Make STM32 interrupt controller use hwspinlock
Message-ID: <20181113144805.1054-1-benjamin.gaignard@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series allow to protect STM32 interrupt controller configuration registers
with a hwspinlock to avoid conflicting accesses between processors. 

Benjamin Gaignard (3):
  dt-bindings: interrupt-controller: stm32: Document hwlock properties
  irqchip: stm32: protect configuration registers with hwspinlock
  ARM: dts: stm32: Add hwlock for irqchip on stm32mp157

 .../interrupt-controller/st,stm32-exti.txt         |  4 +++
 arch/arm/boot/dts/stm32mp157c.dtsi                 |  1 +
 drivers/irqchip/irq-stm32-exti.c                   | 36 ++++++++++++++++++----
 3 files changed, 35 insertions(+), 6 deletions(-)

-- 
2.15.0
