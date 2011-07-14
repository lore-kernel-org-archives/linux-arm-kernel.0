From: tarun.kanti@ti.com (DebBarma, Tarun Kanti)
Date: Thu, 14 Jul 2011 11:27:37 +0530
Subject: [PATCH v4 13/20] gpio/omap: cleanup omap_gpio_mod_init function
In-Reply-To: <20110714055608.GA22467@google.com>
References: <1310565259-31267-1-git-send-email-tarun.kanti@ti.com>
	<1310565259-31267-14-git-send-email-tarun.kanti@ti.com>
	<20110714055608.GA22467@google.com>
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB037BFD2AE1@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Todd Poynor [mailto:toddpoynor at google.com]
> Sent: Thursday, July 14, 2011 11:26 AM
> To: DebBarma, Tarun Kanti
> Cc: linux-omap at vger.kernel.org; Hilman, Kevin; Shilimkar, Santosh;
> tony at atomide.com; linux-arm-kernel at lists.infradead.org; Varadarajan,
> Charulatha
> Subject: Re: [PATCH v4 13/20] gpio/omap: cleanup omap_gpio_mod_init
> function
> 
> On Wed, Jul 13, 2011 at 07:24:12PM +0530, Tarun Kanti DebBarma wrote:
> > With register offsets now defined for respective OMAP versions we can
> get rid
> > of cpu_class_* checks. This function now has common initialization code
> for
> > all OMAP versions. Initialization specific to OMAP16xx has been moved
> within
> > omap16xx_gpio_init().
> >
> ...
> > -	for (i = 0; i < ARRAY_SIZE(omap16xx_gpio_dev); i++)
> > +	for (i = 0; i < ARRAY_SIZE(omap16xx_gpio_dev); i++) {
> > +		pdev = omap16xx_gpio_dev[i];
> > +		pdata = pdev->dev.platform_data;
> > +		res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > +		base = ioremap(res->start, resource_size(res));
> 
> 
> Should check platform_get_resource and ioremap error returns.
Ok, thanks.
--
Tarun
> 
> > +
> > +		__raw_writel(0x0014, base + OMAP1610_GPIO_SYSCONFIG);
> 
> 
> Todd
