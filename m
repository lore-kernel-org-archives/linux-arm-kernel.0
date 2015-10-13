From: Suravee.Suthikulpanit@amd.com (Suravee Suthikulpanit)
Date: Tue, 13 Oct 2015 13:46:19 -0700
Subject: [PATCH 0/4] gicv2m: acpi: Add ACPI support for GICv2m MSI
Message-ID: <1444769183-12374-1-git-send-email-Suravee.Suthikulpanit@amd.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series has been forked from the following patch series since
it no longer depends on the rest of the patches.

  [PATCH v4 00/10] ACPI GIC Self-probing, GICv2m and GICv3 support
  https://lkml.org/lkml/2015/7/29/234

It has been ported to use the newly introduced device fwnode_handle 
for ACPI irqdmain introduced by Marc in the following patch series:

  [PATCH v2 00/17] Divorcing irqdomain and device_node
  http://git.kernel.org/cgit/linux/kernel/git/maz/arm-platforms.git irq/irq-domain-fwnode-v2

The following git branch contains the submitted patches along with
the pre-requsite patches (mainly for ARM64 PCI support for ACPI).

  https://github.com/ssuthiku/linux.git	irq-domain-fwnode-v2-v2m

This has been tested on AMD Seattle (Overdrive) RevB system. 

Suravee Suthikulpanit (4):
  pci: msi: Add support to query MSI domain for pci device
  acpi: pci: Setup MSI domain for ACPI based pci devices
  gicv2m: Refactor to prepare for ACPI support
  gicv2m: acpi: Introducing GICv2m ACPI support

 drivers/irqchip/irq-gic-v2m.c   | 157 +++++++++++++++++++++++++++++++++++-----
 drivers/irqchip/irq-gic.c       |   3 +
 drivers/pci/msi.c               |  30 ++++++++
 drivers/pci/pci-acpi.c          |  13 ++++
 drivers/pci/probe.c             |   2 +
 include/linux/irqchip/arm-gic.h |   6 ++
 include/linux/msi.h             |   7 ++
 include/linux/pci.h             |   7 ++
 8 files changed, 205 insertions(+), 20 deletions(-)

-- 
2.1.0
