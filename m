From: majun258@huawei.com (MaJun)
Date: Wed, 19 Aug 2015 10:55:18 +0800
Subject: [PATCH v4 0/2] Support Mbigen interrupt controller
Message-ID: <1439952920-2296-1-git-send-email-majun258@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ma Jun <majun258@huawei.com>

This patch adds the driver of mbigen and binding document for Hisilicon
Mbigen chips.

Compared with previous version, this version changed much.

Because during the time between V3 and V4 of my patch, there are two
related patches were committed by Mr.Marc Zyngier and Mr. Mark Rutland.

First, Mr. Marc Zyngier changed MSI frame and added supporting for
platform MSI.

https://lkml.org/lkml/2015/7/28/552

Second, Mr.Mark Rutland changed Generic PCI MSI + IOMMU topology bindings

https://lkml.org/lkml/2015/7/23/558 

Changes since v3:
--- Re-based mbigen driver on kernel 4.2.0-rc2 and Marc's patch
--- Changed the binding document based on Mark's patch.


Ma Jun (2):
  Add the driver of mbigen interrupt controller
  dt-binding:Documents of the mbigen bindings

 Documentation/devicetree/bindings/arm/mbigen.txt |   97 +++
 drivers/irqchip/Kconfig                          |    8 +
 drivers/irqchip/Makefile                         |    1 +
 drivers/irqchip/irq-mbigen.c                     |  732 ++++++++++++++++++++++
 4 files changed, 838 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/mbigen.txt
 create mode 100644 drivers/irqchip/irq-mbigen.c
