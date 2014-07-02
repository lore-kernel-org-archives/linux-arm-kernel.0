From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 02 Jul 2014 21:09:06 +0200
Subject: [PATCH v8 8/9] pci: Add support for creating a generic
 host_bridge from device tree
In-Reply-To: <20140702173113.GJ24879@arm.com>
References: <1404240214-9804-1-git-send-email-Liviu.Dudau@arm.com>
 <20140702172355.GQ2173@e106497-lin.cambridge.arm.com>
 <20140702173113.GJ24879@arm.com>
Message-ID: <4233600.RyK6LJF6ZK@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 02 July 2014 18:31:13 Will Deacon wrote:
> > > > + err = of_pci_parse_bus_range(parent->of_node, bus_range);
> > > > + if (err) {
> > > > +         dev_info(parent, "No bus range for %s, using default [0-255]\n",
> > > > +                 parent->of_node->full_name);
> > > > +         bus_range->start = 0;
> > > > +         bus_range->end = 255;
> > > > +         bus_range->flags = IORESOURCE_BUS;
> > > 
> > > What about bus_range->name?
> > 
> > Don't know! Is anyone using it?
> 
> I guess /proc/iomem prints it out? I set it in my current driver, if you
> want to take a look.

I don't think the bus resources show up anywhere in procfs. Anyway, it's
always a good idea to give resources a name, if only for debugging purposes.

	Arnd
