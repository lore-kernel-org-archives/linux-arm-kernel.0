From: richardcochran@gmail.com (Richard Cochran)
Date: Sat, 26 Mar 2011 17:17:12 +0100
Subject: [PATCH] arm: disable non-existent prpmc1100 code.
Message-ID: <20110326161711.GA573@riccoc20.at.omicron.at>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit 6f82f4db80189281a8ac42f2e72396accb719b57 removed the prpmc110 from
the list of machine types. This commit disables a PCI fixup function for
that board, since its presence is preventing the kernel from compiling.

Signed-off-by: Richard Cochran <richard.cochran@omicron.at>
---
 arch/arm/kernel/bios32.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/kernel/bios32.c b/arch/arm/kernel/bios32.c
index d86fcd4..ba1c426 100644
--- a/arch/arm/kernel/bios32.c
+++ b/arch/arm/kernel/bios32.c
@@ -167,6 +167,7 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_DEC, PCI_DEVICE_ID_DEC_21285, pci_fixup_d
  * with an IXP4xx target device and we don't want to kill the
  * resources in that case.
  */
+#ifdef CONFIG_ARCH_PRPMC1100
 static void __devinit pci_fixup_prpmc1100(struct pci_dev *dev)
 {
 	int i;
@@ -182,6 +183,7 @@ static void __devinit pci_fixup_prpmc1100(struct pci_dev *dev)
 	}
 }
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_IXP4XX, pci_fixup_prpmc1100);
+#endif
 
 /*
  * PCI IDE controllers use non-standard I/O port decoding, respect it.
-- 
1.7.0.4
