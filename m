From: will.deacon@arm.com (Will Deacon)
Date: Wed, 12 Feb 2014 20:16:08 +0000
Subject: [PATCH v2 0/3] ARM: PCI: implement generic PCI host controller
Message-ID: <1392236171-10512-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello again,

This is version 2 of the patches I originally posted here:

  http://lists.infradead.org/pipermail/linux-arm-kernel/2014-February/229679.html

Changes since v1 include:

  - Complete rename of files, comments and compatible strings to remove
    references to a `virtual' host controller

  - Support for ECAM (depending on matched compatible string)

  - Support for multiple mem resources

  - Correct use of resource offsets (I think...)

  - Removed explicit bridge enabling from bios32.c after discussion with
    Bjorn (pending testing/feedback from rmk)

Like v1, I continue to support only a single controller and therefore a
single I/O space. I'm not sure how to represent multiple controllers in the
device-tree without inventing some horrible hacks, so any ideas in this area
would be much appreciated.

I still need to take the step of moving parts of this into a library, but
I'd like to make sure the code is correct first. Tested on TC2 running KVM
with kvmtool and virtio-pci.

All feedback welcome (and thanks to Jason and Arnd for their comments on v1),

Will


Will Deacon (3):
  ARM: mach-virt: allow PCI support to be selected
  ARM: bios32: use pci_enable_resource to enable PCI resources
  PCI: ARM: add support for generic PCI host controller

 .../devicetree/bindings/pci/arm-generic-pci.txt    |  51 ++++
 arch/arm/kernel/bios32.c                           |  37 +--
 arch/arm/mach-virt/Kconfig                         |   1 +
 drivers/pci/host/Kconfig                           |   7 +
 drivers/pci/host/Makefile                          |   1 +
 drivers/pci/host/pci-arm-generic.c                 | 318 +++++++++++++++++++++
 6 files changed, 381 insertions(+), 34 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pci/arm-generic-pci.txt
 create mode 100644 drivers/pci/host/pci-arm-generic.c

-- 
1.8.2.2
