From: joel@jms.id.au (Joel Stanley)
Date: Fri, 13 May 2016 00:13:11 +0930
Subject: [PATCH v3 0/2] irqchip: Support Aspeed IRQ controller
In-Reply-To: <1462802317-27086-1-git-send-email-joel@jms.id.au>
References: <1462802317-27086-1-git-send-email-joel@jms.id.au>
Message-ID: <1463064193-2178-1-git-send-email-joel@jms.id.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello All,

This adds support for the IRQ controller found in the Aspeed ast2400 and
ast2500 BMC SoCs.

It's been tested on the ast2400 in an OpenPower Palmetto system, and on the
ast2500-edk developer kit.

V2 has a fix for the compatible string in the device tree bindings.

V3 drops the valid-sources bitmasks and adds a unit address to the example in
the bindings

Cheers,

Joel

Benjamin Herrenschmidt (1):
  irqchip: Add irq controller for Aspeed

Joel Stanley (1):
  doc/devicetree: Add Aspeed VIC bindings

 .../interrupt-controller/aspeed,ast2400-vic.txt    |  22 ++
 drivers/irqchip/Makefile                           |   1 +
 drivers/irqchip/irq-aspeed-vic.c                   | 230 +++++++++++++++++++++
 3 files changed, 253 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/aspeed,ast2400-vic.txt
 create mode 100644 drivers/irqchip/irq-aspeed-vic.c

-- 
2.8.1
