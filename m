From: carlo.caione@gmail.com (Carlo Caione)
Date: Mon,  6 Jan 2014 18:41:34 +0100
Subject: [PATCH v2 0/3] ARM: sun7i: irqchip: Irqchip driver for NMI 
Message-ID: <1389030097-10822-1-git-send-email-carlo.caione@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Allwinner A20 SoCs have a special interrupt controller for managing NMI.
Three register are present to (un)mask, control and acknowledge NMI.
These two patches add a new irqchip driver in cascade with GIC.

Changes since v1:
	- added binding document

Carlo Caione (3):
  ARM: sun7i: irqchip: Add irqchip driver for NMI controller
  ARM: sun7i: dts: Add NMI irqchip support
  ARM: sun7i: irqchip: Update the documentation

 .../allwinner,sun7i-sc-nmi.txt                     |  25 +++
 arch/arm/boot/dts/sun7i-a20.dtsi                   |   9 +
 drivers/irqchip/Makefile                           |   1 +
 drivers/irqchip/irq-sun7i-nmi.c                    | 191 +++++++++++++++++++++
 4 files changed, 226 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/allwinner,sun7i-sc-nmi.txt
 create mode 100644 drivers/irqchip/irq-sun7i-nmi.c

-- 
1.8.5.2
