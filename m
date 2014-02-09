From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 9 Feb 2014 20:34:12 +0000
Subject: [PATCH 2/3] PCI: ARM: add support for virtual PCI host controller
In-Reply-To: <201402092118.19701.arnd@arndb.de>
References: <1391532784-1953-1-git-send-email-will.deacon@arm.com>
 <201402060928.53310.arnd@arndb.de>
 <20140206203114.GW26684@n2100.arm.linux.org.uk>
 <201402092118.19701.arnd@arndb.de>
Message-ID: <20140209203412.GN26684@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Feb 09, 2014 at 09:18:19PM +0100, Arnd Bergmann wrote:
> On Thursday 06 February 2014, Russell King - ARM Linux wrote:
> > On Thu, Feb 06, 2014 at 09:28:52AM +0100, Arnd Bergmann wrote:
> > > It certainly seems workable. OTOH if we just manage to do a
> > > helper that scans the OF ranges, allocates the I/O window,
> > > remaps it and calls the existing pci_add_resource_offset()
> > > helper, PCI host drivers don't need to worry about the
> > > io_offsets computation either and just need to pull out the
> > > correct window locations if they need to set up the hardware
> > > translation windows (which I'd hope we can often let the boot
> > > loader take care of).
> 
> ...
> 
> > So, whenever you enumerate a PCI bus, and read the resource information
> > out of the BARs, you must know how that address region specified in
> > the BAR as a bus address maps to the host address space.
> > 
> 
> None of that contradicts what I wrote. Please try to understand what
> I suggested, which is to have a common way to communicate that
> information from DT to the PCI core without involving the PCI host
> bridge driver.

Please explain it better then.

-- 
FTTC broadband for 0.8mile line: 5.8Mbps down 500kbps up.  Estimation
in database were 13.1 to 19Mbit for a good line, about 7.5+ for a bad.
Estimate before purchase was "up to 13.2Mbit".
