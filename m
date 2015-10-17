From: mcoquelin.stm32@gmail.com (Maxime Coquelin)
Date: Sat, 17 Oct 2015 19:23:49 +0200
Subject: [PATCH 0/9] Add STM32 EXTI interrupt controller support
Message-ID: <1445102638-11575-1-git-send-email-mcoquelin.stm32@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series adds support to EXTI interrupt controller and GPIO IRQ support in
STM32 pinctrl driver.

The STM32 external interrupt controller consists of edge detectors that
generate interrupts requests or wake-up events.

Each line can be independently configured as interrupt or wake-up source,
and triggers either on rising, fallin or both edges. Each line can also
be masked independently.

This series applies on top of STM32 pinctrl v2 series.

Regards,
Maxime

Maxime Coquelin (9):
  Documentation: dt-bindings: Document STM32 EXTI controller bindings
  drivers: irqchip: Add STM32 external interrupts support
  ARM: STM32: Select external interrupts controller
  ARM: dts: Add EXTI controller node to stm32f429
  Documentation: dt-bindings: Add IRQ related properties of STM32
    pinctrl
  pinctrl: Add IRQ support to STM32 gpios
  ARM: dts: Add GPIO irq support to STM2F429
  ARM: dts: Declare push button as GPIO key on stm32f429 Disco board
  ARM: config: Enable GPIO Key driver in stm32_defconfig

 .../interrupt-controller/st,stm32-exti.txt         |  20 +++
 .../bindings/pinctrl/st,stm32-pinctrl.txt          |   3 +
 arch/arm/Kconfig                                   |   1 +
 arch/arm/boot/dts/stm32429i-eval.dts               |  19 +++
 arch/arm/boot/dts/stm32f429-disco.dts              |  13 ++
 arch/arm/boot/dts/stm32f429.dtsi                   |  15 ++
 arch/arm/configs/stm32_defconfig                   |   6 +-
 drivers/irqchip/Kconfig                            |   4 +
 drivers/irqchip/Makefile                           |   1 +
 drivers/irqchip/irq-stm32-exti.c                   | 169 +++++++++++++++++++++
 drivers/pinctrl/stm32/Kconfig                      |   1 +
 drivers/pinctrl/stm32/pinctrl-stm32.c              |  68 +++++++++
 12 files changed, 319 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/st,stm32-exti.txt
 create mode 100644 drivers/irqchip/irq-stm32-exti.c

-- 
1.9.1
