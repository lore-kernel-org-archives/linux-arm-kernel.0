From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 28 Jan 2015 14:53:07 +0100
Subject: [PATCH] ARM: cns3xxx: fix typo in PCI config accessor
Message-ID: <2000255.rnmr9HfSOg@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The recent patch to convert the cns3xxx PCI code added an
extraneous opening bracket, which makes the build fail,
so remove this.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: 10e2c5540d48 ("ARM: cns3xxx: Convert PCI to use generic config accessors")
---

Hi Bjorn,

The broken patch just showed up in linux-next. Please apply this one on top,
or fold it into the original patch if you don't mind rebasing.

diff --git a/arch/arm/mach-cns3xxx/pcie.c b/arch/arm/mach-cns3xxx/pcie.c
index e41fc339d100..c622c306c390 100644
--- a/arch/arm/mach-cns3xxx/pcie.c
+++ b/arch/arm/mach-cns3xxx/pcie.c
@@ -101,7 +101,7 @@ static int cns3xxx_pci_read_config(struct pci_bus *bus, unsigned int devfn,
 		 * for a PCIe bridge. So we must fixup the class code
 		 * to 0x604 here.
 		 */
-		*val = (((((*val << shift) & 0xff) | (0x604 << 16)) >> shift) & mask;
+		*val = ((((*val << shift) & 0xff) | (0x604 << 16)) >> shift) & mask;
 
 	return ret;
 }
