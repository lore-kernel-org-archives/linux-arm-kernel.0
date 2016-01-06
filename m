From: richardcochran@gmail.com (Richard Cochran)
Date: Wed, 6 Jan 2016 22:45:18 +0100
Subject: dra7xx pci driver broken on dra7xx-evm
Message-ID: <20160106214518.GA6106@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


The dra7xx-evm box freezes hard at the very first PCI bus access, the
call to in dra7xx_pcie_readl() in dra7xx_pcie_probe().

The out-of-tree 3.14.53 TI driver performs a reset via platform data,
calling omap_device_assert_hardreset() by hook and crook.

Adding the reset into the mainline driver cures the freeze.

Question: How on earth is this driver supposed to work?

Thanks,
Richard
