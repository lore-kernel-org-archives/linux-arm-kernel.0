From: Liviu.Dudau@arm.com (Liviu Dudau)
Date: Fri,  9 Oct 2015 17:57:24 +0100
Subject: [PATCH v2 0/5] arm64: Juno: Add support for PCIe on R1 board
Message-ID: <1444409849-5685-1-git-send-email-Liviu.Dudau@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Changes in v2 vs v1:
 - Add plda as OF vendor prefix
 - Add more specific compatible values to the Juno R1 DT
 

Juno R1 board has a working PCIe host bridge that can be enabled and
configured by the firmware and made use of by Linux. For UEFI, the
Linaro releases contain firmware that configure the XpressRICH3 host
bridge correctly. For U-Boot based setups, one needs the patchset
posted here[1].

This patchset adds a quirk for setting the correct class to the host
bridge device and the device tree changes that enable PCIe on Juno R1.
We also update the defconfig to enable the generic PCI host bridge driver.

Best regards,
Liviu

1. http://lists.denx.de/pipermail/u-boot/2015-October/229669.html

Andrew Murray (1):
  pci: Add PLDA's XpressRICH3 PCIe host bridge PCI ID

Liviu Dudau (4):
  PCI: Add quirk for PLDA's XpressRICH3 host bridge class.
  of: Add vendor prefix for PLDA.
  arm64: Juno: Add support for the PCIe host bridge on Juno R1
  arm64: defconfig: Enable PCI generic host bridge by default

 .../devicetree/bindings/vendor-prefixes.txt          |  1 +
 arch/arm64/boot/dts/arm/juno-r1.dts                  | 20 ++++++++++++++++++++
 arch/arm64/configs/defconfig                         |  1 +
 drivers/pci/quirks.c                                 | 10 ++++++++++
 include/linux/pci_ids.h                              |  3 +++
 5 files changed, 35 insertions(+)

-- 
2.6.0
