From: carlo@caione.org (Carlo Caione)
Date: Wed,  5 Mar 2014 20:45:28 +0100
Subject: [PATCH v5 0/3] ARM: sun7i/sun6i: irqchip: Irqchip driver for NMI
Message-ID: <1394048731-4570-1-git-send-email-carlo@caione.org>
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

Carlo Caione (3):
  ARM: sun7i/sun6i: irqchip: Add irqchip driver for NMI controller
  ARM: sun7i/sun6i: dts: Add NMI irqchip support
  ARM: sun7i/sun6i: irqchip: Update the documentation

 .../allwinner,sun67i-sc-nmi.txt                    |  27 +++
 arch/arm/boot/dts/sun6i-a31.dtsi                   |   9 +
 arch/arm/boot/dts/sun7i-a20.dtsi                   |   9 +
 drivers/irqchip/Makefile                           |   1 +
 drivers/irqchip/irq-sunxi-nmi.c                    | 228 +++++++++++++++++++++
 5 files changed, 274 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/allwinner,sun67i-sc-nmi.txt
 create mode 100644 drivers/irqchip/irq-sunxi-nmi.c

-- 
1.8.3.2
