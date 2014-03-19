From: carlo@caione.org (Carlo Caione)
Date: Wed, 19 Mar 2014 20:21:16 +0100
Subject: [PATCH v7 0/3] ARM: sun7i/sun6i: irqchip: Irqchip driver for NMI
 controller
Message-ID: <1395256879-8475-1-git-send-email-carlo@caione.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Allwinner A20/A31 SoCs have a special interrupt controller for managing NMI.
Three register are present to (un)mask, control and acknowledge NMI.
These two patches add a new irqchip driver in cascade with GIC.

Changes since v1:
        - added binding document

Changes since v2:
        - fixed trigger type in DTS
        - new explanations in binding documentation
        - added support for A31 (sun6i)

Changes since v3:
        - changed compatibles

Changes since v4:
        - fixed binding documentation

Changes since v5:
        - switched to handle_fasteoi_irq handler to avoid the double
          interrupts issue

Changes since v6:
	- changed node name
	- deleted defaulted interrupt-parent property

Carlo Caione (3):
  ARM: sun7i/sun6i: irqchip: Add irqchip driver for NMI controller
  ARM: sun7i/sun6i: dts: Add NMI irqchip support
  ARM: sun7i/sun6i: irqchip: Update the documentation

 .../allwinner,sun67i-sc-nmi.txt                    |  27 +++
 arch/arm/boot/dts/sun6i-a31.dtsi                   |   8 +
 arch/arm/boot/dts/sun7i-a20.dtsi                   |   8 +
 drivers/irqchip/Makefile                           |   1 +
 drivers/irqchip/irq-sunxi-nmi.c                    | 208 +++++++++++++++++++++
 5 files changed, 252 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/allwinner,sun67i-sc-nmi.txt
 create mode 100644 drivers/irqchip/irq-sunxi-nmi.c

-- 
1.8.3.2
