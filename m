From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 9 Apr 2013 21:06:52 +0200
Subject: [PATCHv7 08/17] pci: PCIe driver for Marvell Armada 370/XP systems
In-Reply-To: <201304090014.06959.arnd@arndb.de>
References: <1364395234-11195-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <201304082334.13186.arnd@arndb.de> <20130408235341.7012b791@skate>
 <201304090014.06959.arnd@arndb.de>
Message-ID: <20130409210652.3bc1958b@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Arnd Bergmann,

On Tue, 9 Apr 2013 00:14:06 +0200, Arnd Bergmann wrote:

> 	pcie->realio.type = IORESOURCE_IO;
> 	pcie->realio.start = max(PCIBIOS_MIN_IO, range->pci_addr);
> 	pcie->realio.end = max(IO_SPACE_LIMIT, range->pci_addr + range->size);

Shouldn't this last line be using "min()" so that we guarantee we don't
have an I/O region that goes beyond IO_SPACE_LIMIT?

Thanks,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
