From: tharvey@gateworks.com (Tim Harvey)
Date: Thu, 27 Feb 2014 17:19:51 -0800
Subject: [RFC PATCH 0/3] PCI: imx6: fixup for add-in card IRQ mismapping
Message-ID: <1393550394-11071-1-git-send-email-tharvey@gateworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

An add-in card used on the Ventana IMX6 SoC based family of boards has a
TI XIO2001 PCIe-to-PCI bridge where the INTA/B/C/D mappings between the
bridge and the four mini-PCI slots are swapped (INTD/C/B/A).

This series adds legacy PCI interrupt mapping to support PCI bridges on
IMX6 PCIe host controllers, adds the ability to use a host-specific
custom swizzle function, then uses that to fix the IRQ mapping.

I'm hoping this is the right way to perform such a workaround - please provide
feedback if not.  Patch1 will likely collide with the owrk Lucas is doing
with device-tree bindings and MSI support.  I'm happy to re-base if/when
needed.

Signed-off-by: Tim Harvey <tharvey@gateworks.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Richard Zhu <r65037@freescale.com>
Cc: Shawn Guo <shawn.guo@linaro.org>
Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: Sean Cross <xobs@kosagi.com>
Cc: Jingoo Han <jg1.han@samsung.com>
---
Tim Harvey (3):
  PCI: designware: add legacy PCI interrupt mapping
  PCI: designware: add ability for custom swizzle
  PCI: imx6: ventana: fixup for IRQ mismapping

 arch/arm/boot/dts/imx6qdl.dtsi     |  2 +-
 drivers/pci/host/pci-exynos.c      |  7 ++++--
 drivers/pci/host/pci-imx6.c        | 47 ++++++++++++++++++++++++++++++++++----
 drivers/pci/host/pcie-designware.c | 11 ++++++++-
 drivers/pci/host/pcie-designware.h |  3 ++-
 include/linux/pci_ids.h            |  1 +
 6 files changed, 62 insertions(+), 9 deletions(-)

-- 
1.8.3.2
