From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 22 Sep 2015 18:52:12 +0100
Subject: [PATCH 0/4] of: Handle multi-parent version of msi-parent
Message-ID: <1442944336-11754-1-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that we have a useable and documented version of msi-parent that
can deal with multiple parenting, we can properly handle it in the
kernel. This leads to a new OF helper, some rework in the PCI and
platform layers, as well as a last patch for the ITS driver, which is
the only thing in the kernel requirering this functionality so far.

Patches on top of 4.3-rc2.

Marc Zyngier (4):
  of: Add of_parse_phandle_with_opt_args() helper function
  of: irq: Add support for the new definition of "msi-parent"
  PCI/MSI: Add support for the new definition of "msi-parent"
  irqchip/gic-v3-its: Parse new version of msi-parent property

 drivers/irqchip/irq-gic-v3-its-platform-msi.c | 18 ++++++--
 drivers/of/base.c                             | 64 ++++++++++++++++++++++++++-
 drivers/of/irq.c                              | 26 +++++++----
 drivers/pci/of.c                              | 25 ++++++++---
 include/linux/of.h                            |  3 ++
 5 files changed, 115 insertions(+), 21 deletions(-)

-- 
2.1.4
