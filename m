From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Wed, 14 Aug 2013 16:18:40 +1000
Subject: linux-next: manual merge of the mvebu tree with the pci tree
Message-ID: <20130814161840.dcee2b1354579cce7ff81730@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Today's linux-next merge of the mvebu tree got a conflict in
drivers/pci/host/Kconfig between commit 5477a33b51b7 ("PCI: mvebu: Make
Marvell PCIe driver depend on OF") from the pci tree and commit
31d896ade95d ("PCI: mvebu: add support for Marvell Dove SoCs") from the
mvebu tree.

I fixed it up (see below) and can carry the fix as necessary (no action
is required).

-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au

diff --cc drivers/pci/host/Kconfig
index e5ba4eb,492eec9..0000000
--- a/drivers/pci/host/Kconfig
+++ b/drivers/pci/host/Kconfig
@@@ -3,8 -3,7 +3,8 @@@ menu "PCI host controller drivers
  
  config PCI_MVEBU
  	bool "Marvell EBU PCIe controller"
- 	depends on ARCH_MVEBU || ARCH_KIRKWOOD
+ 	depends on ARCH_MVEBU || ARCH_DOVE || ARCH_KIRKWOOD
 +	depends on OF
  
  config PCIE_DW
  	bool
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130814/ff2ab198/attachment.sig>
