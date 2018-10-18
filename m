From: lokeshvutla@ti.com (Lokesh Vutla)
Date: Thu, 18 Oct 2018 21:10:07 +0530
Subject: [PATCH v2 00/10] Add support for TISCI irqchip drivers
Message-ID: <20181018154017.7112-1-lokeshvutla@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

TISCI abstracts the handling of IRQ routes where interrupt sources
are not directly connected to host interrupt controller. This series
adds support for:
- TISCI commands needed for IRQ configuration
- Interrupt Router(INTR) and Interrupt Aggregator(INTA) drivers

More information on TISCI IRQ management can be found here[1].
Complete TISCI resource management information can be found here[2].
AM65x SoC related TISCI information can be found here[3].
INTR and INTA related information can be found in TRM[4].

[1] http://downloads.ti.com/tisci/esd/latest/2_tisci_msgs/rm/rm_irq.html
[2] http://downloads.ti.com/tisci/esd/latest/2_tisci_msgs/index.html#resource-management-rm
[3] http://downloads.ti.com/tisci/esd/latest/5_soc_doc/index.html#am6-soc-family
[4] http://www.ti.com/lit/pdf/spruid7

Changes since v1:
- Consolidated both TISCI and irqchip drivers as suggested by Marc.
- Each patch contains respective changes.

Grygorii Strashko (1):
  firmware: ti_sci: Add support to get TISCI handle using of_phandle

Lokesh Vutla (8):
  firmware: ti_sci: Add support for RM core ops
  firmware: ti_sci: Add support for IRQ management
  firmware: ti_sci: Add helper apis to manage resources
  dt-bindings: irqchip: Introduce TISCI Interrupt router bindings
  irqchip: ti-sci-intr: Add support for Interrupt Router driver
  dt-bindings: irqchip: Introduce TISCI Interrupt Aggregator bindings
  irqchip: ti-sci-inta: Add support for Interrupt Aggregator driver
  soc: ti: am6: Enable interrupt controller drivers

Peter Ujfalusi (1):
  firmware: ti_sci: Add RM mapping table for am654

 .../bindings/arm/keystone/ti,sci.txt          |   3 +-
 .../interrupt-controller/ti,sci-inta.txt      |  74 ++
 .../interrupt-controller/ti,sci-intr.txt      |  81 ++
 MAINTAINERS                                   |   4 +
 drivers/firmware/ti_sci.c                     | 850 ++++++++++++++++++
 drivers/firmware/ti_sci.h                     | 102 +++
 drivers/irqchip/Kconfig                       |  22 +
 drivers/irqchip/Makefile                      |   2 +
 drivers/irqchip/irq-ti-sci-inta.c             | 613 +++++++++++++
 drivers/irqchip/irq-ti-sci-intr.c             | 302 +++++++
 drivers/soc/ti/Kconfig                        |   3 +
 include/linux/irqchip/irq-ti-sci-inta.h       |  35 +
 include/linux/soc/ti/ti_sci_protocol.h        | 169 ++++
 13 files changed, 2259 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/ti,sci-inta.txt
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/ti,sci-intr.txt
 create mode 100644 drivers/irqchip/irq-ti-sci-inta.c
 create mode 100644 drivers/irqchip/irq-ti-sci-intr.c
 create mode 100644 include/linux/irqchip/irq-ti-sci-inta.h

-- 
2.19.1
