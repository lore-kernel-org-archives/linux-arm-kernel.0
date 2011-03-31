From: alan@lxorguk.ukuu.org.uk (Alan Cox)
Date: Thu, 31 Mar 2011 10:54:40 +0100
Subject: [GIT PULL] omap changes for v2.6.39 merge window
In-Reply-To: <alpine.LFD.2.00.1103310012500.28032@xanadu.home>
References: <20110317183048.GW7258@atomide.com>
	<AANLkTimWbb5DWiiCW821H6pRicbk1fS3PYcnGyUMznvM@mail.gmail.com>
	<20110318101512.GA15375@n2100.arm.linux.org.uk>
	<201103301906.42429.arnd@arndb.de>
	<AANLkTim578-kwM14SJd06RW_QiC4WVCmFuG+ASgGC4sq@mail.gmail.com>
	<alpine.LFD.2.00.1103301531420.28032@xanadu.home>
	<AANLkTim6zg-U6HtAQbqnENqoK7x8erXSqOuTFVC0YE5r@mail.gmail.com>
	<alpine.LFD.2.00.1103301814250.28032@xanadu.home>
	<alpine.DEB.2.00.1103301728000.15330@asgard.lang.hm>
	<alpine.LFD.2.00.1103302255280.28032@xanadu.home>
	<AANLkTikV5OMifKjWRVdtJLEcxcZ56jrjWLYJBX89pHQ0@mail.gmail.com>
	<alpine.LFD.2.00.1103310012500.28032@xanadu.home>
Message-ID: <20110331105440.42692165@lxorguk.ukuu.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Absolutely.  On Intel, it is (still) Windows the reference.  If Windows 
> doesn't boot on your motherboard you have a problem.  So motherboard 
> vendors won't make crazy incompatible things.  They are constrained to 

OLPC, Moorestown ?

> fix their hardware because they just cannot alter Windows to suit their 
> hardware differences.  That really helps keeping actual differences to a 
> minimum and only to things that are not fundamental. So Windows really 
> helped making a uniform hardware platform on X86.

That and the fact the Microsoft driver validation has driven a lot of
standardisation along the "we could write a driver and go through WHQL
and ... and ..." or we could just use a standard interface.

Thing is though - the x86 platform does change, modern PC systems are
very different to old ones (different IRQ controllers, different power
management, different processor features, different bus interfaces,
different firmware, ...) but someone bothered to make these
*discoverable*.

If I boot a Linux kernel on an AMD K6 I'm running with an 8259 interrupt
controller, 8254/5 supporting I/O, a PC style keyboard controller,
graphics via PCI or maybe AGP using memory on the card mostly, a one
command at a time ATA interface based on WD1010 registers, APM based
firmware that implements an extended version of the PC BIOS.

If I boot it on a current PC I'm booting on a multiprocessor system with
different timers, totally different IRQ controllers, different keyboard
controllers (USB), PCI Express, an IOMMU, NCQ SATA, ACPI, graphics
running in shared host memory able to give/take pages from the host,
extra instructions, etc etc

And the same kernel boots just fine on both just fine.
