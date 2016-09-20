From: alexandre.torgue@st.com (Alexandre TORGUE)
Date: Tue, 20 Sep 2016 18:00:55 +0200
Subject: [PATCH v6 0/4] Add STM32 EXTI interrupt controller support
Message-ID: <1474387259-18926-1-git-send-email-alexandre.torgue@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This v6 fix useless mask in .free callback of stm32 exti driver (thanks
Thomas).
I resend only patches concerning STM32 EXTI driver (as pinctrl part has
already been applied by Linus W.)


The series adds support to EXTI interrupt controller and GPIO IRQ support in
STM32 pinctrl driver.

The STM32 external interrupt controller consists of edge detectors that
generate interrupts requests or wake-up events.

Each line can be independently configured as interrupt or wake-up source,
and triggers either on rising, fallin or both edges. Each line can also
be masked independently.

Regards 

Alex

Changes since v5:
-----------------
 - Fix .free callback according to Thomas

Changes since v4:
-----------------
 - Fix bad copy/paste in stm32 exti driver
 - Remove GPIOLIB_IRQCHIP config in stm32 pinctrl driver 

Changes since v3:
-----------------
 - Review domain dealloc/free irq in stm32 pinctrl driver
 - Review domain dealloc/free irq in stm32 exti driver
 - Fix remarks on coding style

Changes since v2:
-----------------
 - Define irq_chip for GPIO banks
 - Use hierarchical domain for GPIO banks
 - Improve search loop inside stm32_exti handler 
 - Rebased on top of v4.8-rc1

Changes since v1:
-----------------
 - Rebased on top of v4.6-rc1
 - Change variable name from virq to irq (Linus W.)


Alexandre TORGUE (4):
  Documentation: dt-bindings: Document STM32 EXTI controller bindings
  drivers: irqchip: Add STM32 external interrupts support
  ARM: STM32: Select external interrupts controller
  ARM: dts: Add EXTI controller node to stm32f429

 .../interrupt-controller/st,stm32-exti.txt         |  20 ++
 arch/arm/Kconfig                                   |   1 +
 arch/arm/boot/dts/stm32f429.dtsi                   |   8 +
 drivers/irqchip/Kconfig                            |   4 +
 drivers/irqchip/Makefile                           |   1 +
 drivers/irqchip/irq-stm32-exti.c                   | 201 +++++++++++++++++++++
 6 files changed, 235 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/st,stm32-exti.txt
 create mode 100644 drivers/irqchip/irq-stm32-exti.c

-- 
1.9.1
