From: pn@denx.de (Parthiban Nallathambi)
Date: Sun, 12 Aug 2018 14:22:12 +0200
Subject: [PATCH v2 0/3] Add Actions Semi Owl family sirq support
Message-ID: <20180812122215.1079590-1-pn@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series add support for external interrupt controller
in Actions Semi Owl famil of SoC's (S500, S700 and S900). Actions
provides support for external interrupt controller to be connected
with it's SoC's using 3 SIRQ pins.

Each line can be configures independently, i.e 3 independent external
interrupt controller can be connected and managed parallely.

Device tree node is created only for S700 after testing it in Cubieboard7.

Changelog in v2:
- Added SIRQ as hierarchical chip
        GIC <----> SIRQ <----> External interrupt controller/Child devices
- Device binding updates with vendor prefix
- Register sharing handled globally and common init sequence/data for all
actions SoC family

Thanks,
Parthiban
Saravanan

Parthiban Nallathambi (3):
  dt-bindings: interrupt-controller: Actions external interrupt
    controller
  drivers/irqchip: Add Actions external interrupts support
  arm64: dts: actions: Add sirq node for Actions Semi S700

 .../interrupt-controller/actions,owl-sirq.txt      |  46 ++++
 arch/arm64/boot/dts/actions/s700.dtsi              |   9 +
 drivers/irqchip/Makefile                           |   1 +
 drivers/irqchip/irq-owl-sirq.c                     | 305 +++++++++++++++++++++
 4 files changed, 361 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/actions,owl-sirq.txt
 create mode 100644 drivers/irqchip/irq-owl-sirq.c

-- 
2.14.4
