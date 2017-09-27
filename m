From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 27 Sep 2017 23:16:51 +0200
Subject: [PATCH 0/4] Switch Integrator to use the new PCIv3 driver
Message-ID: <20170927211655.3687-1-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Bjorn Helgaas has merged the new V3 PCI driver into the PCI subsystem so
we just need to clean up the DTS file in accordance with the augmented
bindings, fix some long-standing bugs in the DTS and delete the old
superceded driver.

Linus Walleij (4):
  ARM: dts: add the PCI clock to the device tree
  ARM: dts: integratorap: Fix PCI windows
  ARM: dts: Update Integrator/AP PCI v3 compatible
  ARM: integrator: Delete the V3 PCI driver

 arch/arm/boot/dts/integratorap.dts       |  25 +-
 arch/arm/mach-integrator/Makefile        |   2 -
 arch/arm/mach-integrator/integrator_ap.c |   2 -
 arch/arm/mach-integrator/pci_v3.c        | 900 -------------------------------
 arch/arm/mach-integrator/pci_v3.h        |   9 -
 5 files changed, 15 insertions(+), 923 deletions(-)
 delete mode 100644 arch/arm/mach-integrator/pci_v3.c
 delete mode 100644 arch/arm/mach-integrator/pci_v3.h

-- 
2.13.5
