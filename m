From: majun258@huawei.com (MaJun)
Date: Tue, 20 Oct 2015 16:41:56 +0800
Subject: [PATCH v6 0/4] irqchip:support mbigen interrupt controller
Message-ID: <1445330520-11960-1-git-send-email-majun258@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ma Jun <majun258@huawei.com>

This patch set adds the driver of mbigen and binding document for Hisilicon
Mbigen chips.

Compared with previous version, this version changed much.

Because during the time between V3 and V4 of my patch, there are two
related patches were committed by Mr.Marc Zyngier and Mr. Mark Rutland.

First, Mr. Marc Zyngier changed MSI frame and added supporting for
platform MSI.

https://lkml.org/lkml/2015/7/28/552

Second, Mr.Mark Rutland changed Generic PCI MSI + IOMMU topology bindings

https://lkml.org/lkml/2015/7/23/558 

After V5 patch posted, Mr.Marc Zyngier posted a new patch set
"Adding core support for wire-MSI bridges"

https://lkml.org/lkml/2015/10/15/545

So, mbigen v6 patch is based on this new patch even though this patch is
still under review.

Changes in v6:
--- Re-based mbigen driver on kernel 4.3.0-rc5 and Marc's new patch
--- Change the mbigen chip node definition(dts).
--- Change the interrupt cells definition(dts).
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

Ma Jun (4):
  dt-binding:Documents of the mbigen bindings
  irqchip: add platform device driver for mbigen device
  irqchip:create irq domain for each mbigen device
  irqchip:implement the mbigen irq chip operation functions

 Documentation/devicetree/bindings/arm/mbigen.txt |   63 +++++
 drivers/irqchip/irq-mbigen.c                     |  325 ++++++++++++++++++++++
 2 files changed, 388 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/mbigen.txt
 create mode 100644 drivers/irqchip/irq-mbigen.c
