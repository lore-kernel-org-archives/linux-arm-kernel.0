From: carlo.caione@gmail.com (Carlo Caione)
Date: Sun,  5 Jan 2014 16:39:03 +0100
Subject: [PATCH 0/2] ARM: sun7i: irqchip driver for NMI 
Message-ID: <1388936345-5009-1-git-send-email-carlo.caione@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Allwinner A20 SoCs have a special interrupt controller for managing NMI.
Three register are present to (un)mask, control and acknowledge NMI.
These two patches add a new irqchip driver in cascade with GIC.

Carlo Caione (2):
  ARM: sun7i: Add irqchip driver for NMI controller
  ARM: sun7i: dts: Add NMI irqchip support

 arch/arm/boot/dts/sun7i-a20.dtsi |   9 ++
 drivers/irqchip/Makefile         |   1 +
 drivers/irqchip/irq-sun7i-nmi.c  | 192 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 202 insertions(+)
 create mode 100644 drivers/irqchip/irq-sun7i-nmi.c

-- 
1.8.5.2
