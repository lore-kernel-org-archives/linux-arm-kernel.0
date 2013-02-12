From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 12 Feb 2013 19:02:14 +0000
Subject: Giving special alignment/size constraints to the Linux PCI core?
In-Reply-To: <20130212184127.GA1471@obsidianresearch.com>
References: <20130130120344.GA29490@avionic-0098.mockup.avionic-design.de>
 <201302121600.08434.arnd@arndb.de>
 <20130212184127.GA1471@obsidianresearch.com>
Message-ID: <201302121902.14276.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 12 February 2013, Jason Gunthorpe wrote:
> > My feeling is that an easier solution would be to keep separate
> > root buses for each port, which then behaves completely PCIe
> > compliant, but add a hook in the procedure above to set up the
> > address translation windows between the pci_bus_size_bridges()
> > and the pci_bus_assign_resources() calls.
> 
> This process is only done during driver initialization. How would you
> support PCI-E device hotplug (my systems rely on this)? Hotplug works
> today with the existing Marvell driver, however that relies on
> pre-allocated windows.

I did not expect hotplug to work with either approach. How does
it work with the existing driver? From my understanding, you still
assign all the top-level P2P bridge resources at bootup, and only
if that happens to have some space left before the next bridge,
it would be possible to fit in a hotplug device.

	Arnd
