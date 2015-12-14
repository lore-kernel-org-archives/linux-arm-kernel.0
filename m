From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 14 Dec 2015 09:54:12 +0100
Subject: [PATCH 03/10] drivers/pci: make host/pci-mvebu.c explicitly
 non-modular
In-Reply-To: <1449970917-12633-4-git-send-email-paul.gortmaker@windriver.com>
References: <1449970917-12633-1-git-send-email-paul.gortmaker@windriver.com>
 <1449970917-12633-4-git-send-email-paul.gortmaker@windriver.com>
Message-ID: <3739759.V0MRsvH5Tk@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 12 December 2015 20:41:50 Paul Gortmaker wrote:
> The Kconfig currently controlling compilation of this code is:
> 
> drivers/pci/host/Kconfig:config PCI_MVEBU
> drivers/pci/host/Kconfig:       bool "Marvell EBU PCIe controller"
> 
> ...meaning that it currently is not being built as a module by anyone.

Here too. I think we should really try to let all PCI host drivers be
loadable modules if possible. The module unload path is currently
a bit iffy because of the way it interacts with the arch/arm PCI
infrastructure, but we are in the process of fixing it.

For now, I think allowing all PCIe host drivers for ARM to be
loadable but non-removably modules would be ideal.

	Arnd
