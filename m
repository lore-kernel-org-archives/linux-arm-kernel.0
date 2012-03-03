From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 3 Mar 2012 10:08:53 +0000
Subject: [PATCH 5/5 v2] ARM: kirkwood: convert orion-wdt to fdt.
In-Reply-To: <201203021832.34901.arnd@arndb.de>
References: <cover.1330709314.git.jason@lakedaemon.net>
 <e2fe5e97a83fc753559bbb18d5d111ed01b89034.1330709314.git.jason@lakedaemon.net>
 <201203021832.34901.arnd@arndb.de>
Message-ID: <20120303100853.GK7363@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 02, 2012 at 06:32:33PM +0000, Arnd Bergmann wrote:
> On Friday 02 March 2012, Jason Cooper wrote:
> > +       wdt_reg = (void __iomem *)TIMER_VIRT_BASE;
> > +
> > +       ret = of_address_to_resource(np, 0, &res);
> > +       if (ret) {
> > +               printk(KERN_ERR "invalid address\n");
> > +               return ret;
> > +       }
> > +
> > +       wdt_reg = ioremap(res.start, res.end - res.start);
> > +
> 
> This will break non-dt uses because you overwrite the wdt_reg value.

Don't also forget that "res.end - res.start" is also not correct, and
resource_size() should be used to prevent that kind of error.
