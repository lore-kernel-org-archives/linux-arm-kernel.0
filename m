From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Mon, 17 Aug 2015 11:08:55 +1000
Subject: linux-next: manual merge of the pci tree with the arm-soc tree
Message-ID: <20150817110855.4fcf9a66@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Bjorn,

Today's linux-next merge of the pci tree got a conflict in:

  drivers/pci/host/Kconfig

between commit:

  70d334ca71b0 ("PCI: iproc: Fix BCMA dependency in Kconfig")

from the arm-soc tree and commit:

  05aa7d6a72c1 ("PCI: iproc: Allow BCMA bus driver to be built as module")

from the pci tree.

I fixed it up (see below) and can carry the fix as necessary (no action
is required).

-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au

diff --cc drivers/pci/host/Kconfig
index 48b5b3058d9d,e339a8c42f76..000000000000
--- a/drivers/pci/host/Kconfig
+++ b/drivers/pci/host/Kconfig
@@@ -135,8 -135,8 +135,8 @@@ config PCIE_IPROC_PLATFOR
  	  through the generic platform bus interface
  
  config PCIE_IPROC_BCMA
- 	bool "Broadcom iProc PCIe BCMA bus driver"
+ 	tristate "Broadcom iProc PCIe BCMA bus driver"
 -	depends on ARCH_BCM_IPROC || (ARM && COMPILE_TEST)
 +	depends on ARM && (ARCH_BCM_IPROC || COMPILE_TEST)
  	select PCIE_IPROC
  	select BCMA
  	select PCI_DOMAINS
