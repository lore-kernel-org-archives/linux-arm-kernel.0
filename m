From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Wed, 10 Sep 2014 18:06:41 +0100
Subject: [PATCH v10 08/10] OF: PCI: Add support for parsing PCI host
 bridge resources from DT
In-Reply-To: <20140910165347.GJ27864@e106497-lin.cambridge.arm.com>
References: <1410184472-17630-1-git-send-email-Liviu.Dudau@arm.com>
 <1410184472-17630-9-git-send-email-Liviu.Dudau@arm.com>
 <20140909133546.GB2636@e102568-lin.cambridge.arm.com>
 <20140910142241.GD27864@e106497-lin.cambridge.arm.com>
 <20140910151026.GB11640@e102568-lin.cambridge.arm.com>
 <20140910153233.GG27864@e106497-lin.cambridge.arm.com>
 <20140910163746.GB19662@e102568-lin.cambridge.arm.com>
 <20140910165347.GJ27864@e106497-lin.cambridge.arm.com>
Message-ID: <20140910170641.GC19662@e102568-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 10, 2014 at 05:53:47PM +0100, Liviu Dudau wrote:

[...]

> > > > > > > +		if (resource_type(res) == IORESOURCE_IO) {
> > > > > > > +			if (*io_base)
> > > > > > 
> > > > > > You do not zero io_base in the first place so you should ask the API
> > > > > > user to do that. Is 0 a valid value BTW ? If it is you've got to resort
> > > > > > to something else to detect multiple IO resources.
> > > 
> > > No, zero is not a valid value. It is the cpu_addr value from the IO range, I'm
> > > hopying that no one is crazy enough to map PCI address space at CPU address zero.
> > > Thanks for spotting the lack of initialisation though, I need to fix it.
> > 
> > Mmm...wasn't a trick question sorry :D
> > 
> > PCI host bridge /pci ranges:
> >    IO 0x00000000..0x0000ffff -> 0x00000000
> >    More than one I/O resource converted. CPU offset for old range lost!
> >      MEM 0x41000000..0x7fffffff -> 0x41000000
> >      pci-host-generic 40000000.pci: PCI host bridge to bus 0000:00
> >      pci_bus 0000:00: root bus resource [bu-01]
> >      pci_bus 0000:00: root bus resource [io  0x0000-0xffff]
> >      pci_bus 0000:00: root bus resource [mem 0x41000000-0x7fffffff]
> > 
> 
> Your DT puts the IO space at CPU address zero? Could you copy the relevant
> host bridge node from DT here?

It is kvmtools generated dts, may not be representative of real HW but
that's what it is. For the whole story:

http://comments.gmane.org/gmane.linux.kernel.pci/29199

Lorenzo
