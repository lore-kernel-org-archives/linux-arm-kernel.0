From: majun258@huawei.com (MaJun)
Date: Wed, 30 Sep 2015 17:39:06 +0800
Subject: [PATCH v5 0/3] Support Mbigen interrupt controller
Message-ID: <1443605949-15396-1-git-send-email-majun258@huawei.com>
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

Changes in v5:
--- Split mbigen driver patch into 2 smaller patches.
--- Change mbigen chip and mbigen device initialzing sequence.
--- Initializing mbigen device instead of mbigen chip as interrupt controller
--- Remove mbigen node from driver to make this driver more easily read.
--- Change the mbigen chip node definition(dts).
--- Change the interrupt cells definition(dts).
Changes in v4:
--- Re-based mbigen driver on kernel 4.2.0-rc2 and Marc's patch
--- Changed the binding document based on Mark's patch.

Ma Jun (3):
  initialize each mbigen device node as a interrupt controller.
  Probe mbigen chip and initial mbigen device as platform device.
  dt-binding:Documents of the mbigen bindings

 Documentation/devicetree/bindings/arm/mbigen.txt |   85 ++++
 drivers/irqchip/irq-mbigen.c                     |  549 ++++++++++++++++++++++
 2 files changed, 634 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/mbigen.txt
 create mode 100644 drivers/irqchip/irq-mbigen.c
