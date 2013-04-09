From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 9 Apr 2013 21:09:43 +0200
Subject: [PATCHv7 08/17] pci: PCIe driver for Marvell Armada 370/XP systems
In-Reply-To: <20130409210652.3bc1958b@skate>
References: <1364395234-11195-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <201304090014.06959.arnd@arndb.de> <20130409210652.3bc1958b@skate>
Message-ID: <201304092109.43404.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 09 April 2013, Thomas Petazzoni wrote:
> Dear Arnd Bergmann,
> 
> On Tue, 9 Apr 2013 00:14:06 +0200, Arnd Bergmann wrote:
> 
> >       pcie->realio.type = IORESOURCE_IO;
> >       pcie->realio.start = max(PCIBIOS_MIN_IO, range->pci_addr);
> >       pcie->realio.end = max(IO_SPACE_LIMIT, range->pci_addr + range->size);
> 
> Shouldn't this last line be using "min()" so that we guarantee we don't
> have an I/O region that goes beyond IO_SPACE_LIMIT?
> 

Yes, of course. Sorry for not typing what I was thinking ;-)

	Arnd
