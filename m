From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 3 Jun 2013 13:09:17 +0200
Subject: [GIT PULL] Integrator/AP PCI DT support
Message-ID: <CACRpkdb8J4+QH36SYavgGWbFWaBZDg5JSYyyJELzL=mSZfMnBw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi ARM SoC folks,

here is a pull request for the Integrator/AP PCI DT support.

This is the final stepping stone making way for this development TODO:

- Preparing removal of the board files for the Integrators
- Multiplatform support
- Moving the PCIv3 driver to drivers/pci

The patches have been around on the lists for a long time now, only
waiting for the infrastructure recently added to the ARM SoC tree.

As you can see it is based on the of/pci-helpers branch in the ARM SoC
tree. I pulled this branch into my tree and rebased the patch set onto
this.

All is ACKed by Arnd except for the patch adding the function
pci_common_init_dev() to arch/arm/include/asm/mach/pci.h.
So this will be a good time for anyone who doesn't like that idea
to protest in the last minute.

Anyway: please pull it in.

Yours,
Linus Walleij


The following changes since commit 4e23d3f505e8acfeac7cc33d4113fbb5a25c3090:

  of/pci: Add of_pci_parse_bus_range() function (2013-05-19 20:30:10 +0000)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-integrator.git
tags/integrator-pci-for-arm-soc

for you to fetch changes up to 81719809c6fa914e48c4d4e739eb643a40e87034:

  ARM: integrator: get PCI device IRQs from device tree (2013-06-03
10:00:40 +0200)

----------------------------------------------------------------
This is a patch series that:
- Pulls the Integrator/AP PCI bridge driver into one file
- Adds full device tree support for it

----------------------------------------------------------------
Linus Walleij (12):
      Documentation/devicetree: add a small note on PCI
      ARM: pci: create pci_common_init_dev()
      ARM: integrator: merge PCIv3 driver into one file
      ARM: integrator: convert PCIv3 bridge to platform device
      ARM: integrator: grab PCI error IRQ in probe()
      ARM: integrator: move PCI base address grab to probe
      ARM: integrator: move V3 register definitions into driver
      ARM: integrator: remap PCIv3 base dynamically
      ARM: integrator: move VGA base assignment
      ARM: integrator: move static ioremapping into PCIv3 driver
      ARM: integrator: basic PCIv3 device tree support
      ARM: integrator: get PCI device IRQs from device tree

 Documentation/devicetree/bindings/pci/pci.txt      |   9 +
 .../devicetree/bindings/pci/v3-v360epc-pci.txt     |  15 +
 .../devicetree/bindings/vendor-prefixes.txt        |   1 +
 arch/arm/boot/dts/integratorap.dts                 |  41 ++
 arch/arm/include/asm/hardware/pci_v3.h             | 186 --------
 arch/arm/include/asm/mach/pci.h                    |  17 +-
 arch/arm/kernel/bios32.c                           |   9 +-
 arch/arm/mach-integrator/Makefile                  |   2 +-
 arch/arm/mach-integrator/include/mach/platform.h   |  23 -
 arch/arm/mach-integrator/integrator_ap.c           |  31 +-
 arch/arm/mach-integrator/pci.c                     | 113 -----
 arch/arm/mach-integrator/pci_v3.c                  | 520 +++++++++++++++++++--
 arch/arm/mach-integrator/pci_v3.h                  |   2 +
 13 files changed, 563 insertions(+), 406 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pci/pci.txt
 create mode 100644 Documentation/devicetree/bindings/pci/v3-v360epc-pci.txt
 delete mode 100644 arch/arm/include/asm/hardware/pci_v3.h
 delete mode 100644 arch/arm/mach-integrator/pci.c
 create mode 100644 arch/arm/mach-integrator/pci_v3.h
