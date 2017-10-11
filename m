From: jim2101024@gmail.com (Jim Quinlan)
Date: Wed, 11 Oct 2017 18:34:20 -0400
Subject: PCI: brcmstb: Add Broadcom Settopbox PCIe support
Message-ID: <1507761269-7017-1-git-send-email-jim2101024@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series adds support for the Broadcom Settopbox PCIe host
controller.  It is targeted to Broadcom Settopbox chips running on ARM,
ARM64, and MIPS platforms.  As the HW of the controller is intimately
tied to the memory subsystem, there are some patches required that are
not typical of a PCIe host controller driver.

pci-brcmstb.c -- is the core functionality of the RC driver.
pci-brcmstb-msi.c -- provides the driver for the PCIe's built-in
	MSI controller.
pci-brcmstb-dma.c -- provides the non-standard mapping between
	system memory and the PCIe address space.
drivers/soc/bcm/brcmstb/memory.c -- provides a single call to inform
	the PCIe controller about the size of populated memory in
	the memory controllers.
