From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 10 Apr 2014 23:04:54 +0200
Subject: Fixing PCIe issues on Armada XP
In-Reply-To: <20140410201201.GA12661@obsidianresearch.com>
References: <20140410181953.50ccfcc3@skate>
 <20140410165733.GB23104@obsidianresearch.com>
 <20140410200153.46669e0c@skate>
 <20140410201201.GA12661@obsidianresearch.com>
Message-ID: <20140410230454.3f761715@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Jason Gunthorpe,

On Thu, 10 Apr 2014 14:12:01 -0600, Jason Gunthorpe wrote:

> > But I'm not entirely convinced by this, because in my testing, I saw:
> > 
> >  * Enable the clock
> >  * Values in the PCI configuration space are correct (like
> >    vendor/product ID)
> >  * mvebu_pcie_set_local_dev_nr()
> >  * Values in the PCI configuration space are no longer correct, unless
> >    you wait a little bit.
> 
> Were you reading the configuation space through the MMIO mapping or
> through the configuration indirection?

I was simply calling the mvebu_pcie_hw_rd_conf() function, so I guess
it goes through what you call the "configuration indirection".

> In any event, turning on the clock should almost certainly be
> accompanied by a phy reset sequence to get both link ends on the same
> page.
> 
> Attached is a rough, untested patch along those lines.

I'll try tomorrow, if I manage to reproduce the initial bug to start
with.

> > > That does sound like more mbus troubles.
> > 
> > Interestingly, the problem occurred when I was plugging a SATA PCIe
> > card. And regardless of whether the SATA PCIe card is present or not,
> > the MBus mappings for the IGB are exactly the same.
> 
> Maybe something wrong with mbus window index 13?
> 
> Any change if you use other windows?

Don't know, will try tomorrow and report back :-)

Thanks for the suggestions!

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
