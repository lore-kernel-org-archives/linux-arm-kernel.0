From: robherring2@gmail.com (Rob Herring)
Date: Thu, 27 Mar 2014 17:46:35 -0500
Subject: [PATCH 0/3] Versatile PCI DT support
Message-ID: <1395960398-4238-1-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <robh@kernel.org>

This series adds a platform driver for Versatile PB's PCI host using
Liviu's recent patch series[1] for DT parsing and setup.

The first patch is a hack to get Liviu's current patches to work on ARM.
It at least shows we are not that far off from being able to use the
series on ARM.

I've tested PCI under QEMU, but need someone with actual h/w to test.
A branch with this series and which includes full conversion of
Versatile to DT is available here[2].

Rob

[1] https://lkml.org/lkml/2014/3/14/279
[2] git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git versatile

Rob Herring (3):
  ARM: hackup pcibios support for commmon bridge code
  dt/bindings: add versatile PCI binding
  pci: add DT based ARM Versatile PCI host driver

 .../devicetree/bindings/pci/versatile.txt          |  59 +++++
 arch/arm/kernel/bios32.c                           |  63 +++++
 drivers/pci/host/Kconfig                           |   4 +
 drivers/pci/host/Makefile                          |   1 +
 drivers/pci/host/pci-versatile.c                   | 275 +++++++++++++++++++++
 5 files changed, 402 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/versatile.txt
 create mode 100644 drivers/pci/host/pci-versatile.c

-- 
1.8.3.2
