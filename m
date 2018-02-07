From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed,  7 Feb 2018 14:32:53 +0000
Subject: [PATCH 0/2] irqchip: GICv2m Multi-MSI support
Message-ID: <20180207143255.17003-1-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It's been recently reported that GICv2m doesn't handle the Multi-MSI
variant (it only deals with a single MSI, or the full blown
MSI-X). For better or worse, Multi-MSI is still a thing, and it'd be
better if we dealt with it.

This tiny series aims at teaching this old trick to GICv2m, together
with an extra patch that enables all the v2m regions on Juno. if
nobody objects to this, I plan to take at least the initial patch
through the irqchip tree, and potentially the DT as well if people
want me to.

Marc Zyngier (1):
  irqchip/gic-v2m: Add PCI Multi-MSI support

Robin Murphy (1):
  arm64: dts: juno: Describe the full GICv2m region

 arch/arm64/boot/dts/arm/juno-base.dtsi | 19 ++++++++++++++
 drivers/irqchip/irq-gic-v2m.c          | 46 ++++++++++++++++------------------
 2 files changed, 41 insertions(+), 24 deletions(-)

-- 
2.14.2
