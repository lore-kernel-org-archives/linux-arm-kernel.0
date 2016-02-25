From: manabian@gmail.com (Joachim Eastwood)
Date: Thu, 25 Feb 2016 23:04:45 +0100
Subject: [PATCH 0/2] PINT irqchip driver for NXP LPC18xx family
Message-ID: <1456437887-24432-1-git-send-email-manabian@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The LPC1850 has no less than 3 GPIO interrupt blocks. One of these
blocks is called 'gpio pin interrupt' or just PINT. LPC1850 PINT can
handle up to 8 interrupts and these have a one-to-one relationship with
the main interrupt controller (NVIC).

The interrupts on PINT can be either level or edge trigger and supports
any polarity.

This patch set adds an irqchip driver for the PINT found on lpc18xx.

Joachim Eastwood (2):
  irqchip: add lpc18xx gpio pin interrupt driver
  devicetree: document NXP LPC1850 PINT irq controller binding

 .../interrupt-controller/nxp,lpc1850-gpio-pint.txt |  22 ++
 drivers/irqchip/Kconfig                            |   5 +
 drivers/irqchip/Makefile                           |   1 +
 drivers/irqchip/irq-lpc18xx-gpio-pint.c            | 238 +++++++++++++++++++++
 4 files changed, 266 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/nxp,lpc1850-gpio-pint.txt
 create mode 100644 drivers/irqchip/irq-lpc18xx-gpio-pint.c

-- 
1.8.0
