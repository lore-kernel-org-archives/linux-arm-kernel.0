From: broonie@kernel.org (Mark Brown)
Date: Fri, 26 Feb 2016 12:04:11 +0900
Subject: next-20160225 build: 2 failures 44 warnings (next-20160225)
In-Reply-To: <E1aYsmb-0006qb-76@optimist>
References: <E1aYsmb-0006qb-76@optimist>
Message-ID: <20160226030411.GK18327@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 25, 2016 at 10:04:29AM +0000, Build bot for Mark Brown wrote:

Today's -next fails to build an arm64 allmodconfig due to:

> 	arm64-allmodconfig
> ../drivers/pci/host/pci-mvebu.c:755:12: error: dereferencing pointer to incomplete type 'struct pci_sys_data'
> ../drivers/pci/host/pci-mvebu.c:855:31: error: dereferencing pointer to incomplete type 'struct pci_sys_data'
> ../drivers/pci/host/pci-mvebu.c:904:16: error: storage size of 'hw' isn't known
> ../drivers/pci/host/pci-mvebu.c:919:2: error: implicit declaration of function 'pci_common_init_dev' [-Werror=implicit-function-declaration]
> ../drivers/pci/host/pci-mvebu.c:1282:3: error: implicit declaration of function 'pci_ioremap_io' [-Werror=implicit-function-declaration]

caused by b4f596b19624 (arm64: add mvebu architecture entry) which
enables MVBEU on arm64, the commit was present for a little while and
the error cropped up but didn't get reported due to other things masking
it.  This looks like the driver needs modernization and probably ought
to have a !ARM64 dependency for now.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160226/1f18ad67/attachment.sig>
