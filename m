From: jg1.han@samsung.com (Jingoo Han)
Date: Tue, 18 Jun 2013 14:35:54 +0900
Subject: [PATCH V5 1/3] pci: Add PCIe driver for Samsung Exynos
In-Reply-To: <7174350.I5qK0sQfHM@wuerfel>
References: <000b01ce6839$0f0455d0$2d0d0170$@samsung.com>
 <3539874.V7zkhbMg0b@wuerfel> <005e01ce6b3f$74e3c940$5eab5bc0$@samsung.com>
 <7174350.I5qK0sQfHM@wuerfel>
Message-ID: <000001ce6be5$b3fd0730$1bf71590$@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday, June 17, 2013 9:45 PM, Arnd Bergmann wrote:
> On Monday 17 June 2013 18:45:52 Jingoo Han wrote:
> > On Friday, June 14, 2013 9:54 PM, Arnd Bergmann wrote:
> > >
[.....]
> > > > > > +static int __exit exynos_pcie_remove(struct platform_device *pdev)
> > > > > > +{
> > > > > > +	struct pcie_port *pp = platform_get_drvdata(pdev);
> > > > > > +
> > > > > > +	clk_disable_unprepare(pp->bus_clk);
> > > > > > +	clk_disable_unprepare(pp->clk);
> > > > > > +
> > > > > > +	return 0;
> > > > > > +}
> > > > >
> > > > > You also don't remove the PCI devices here, as mentioned in an earlier
> > > > > review.
> > > >
> > > > I reviewed Marvell PCIe driver and Tegra PCIe driver; however,
> > > > I cannot know what you mean.
> > > >
> > > > Could let me know which additional functions are needed?
> > >
> > > The mvebu driver does not allow module unload. I haven't looked at the
> > > tegra driver. If you allow unloading the driver and provide a 'remove'
> > > callback, that callback needs to clean up the entire bus and remove
> > > all child devices that were added as well as undo everything the
> > > probe function did. I think it would be great if you can do that, although
> > > it might not be easy. The simplest solution would be to not support
> > > unloading though.
> >
> > As the mvebu driver uses platform_driver_probe(), the Exynos driver uses
> > platform_driver_probe(). Thus, I will not provide a 'remove' callback.
> 
> Well, the important part is not to provide a module_exit() function, which
> will ensure the driver cannot be unloaded.

Aha, I see.
I will not provide a module_exit() function), as the mvebu driver does.

Best regards,
Jingoo Han

> 
> 	Arnd
