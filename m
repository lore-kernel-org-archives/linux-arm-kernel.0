From: grant.likely@secretlab.ca (Grant Likely)
Date: Fri, 10 Jun 2011 16:30:42 -0600
Subject: [PATCH v4 3/4] drivers/amba: create devices from device tree
In-Reply-To: <201106102304.06279.arnd@arndb.de>
References: <1307738923-7564-1-git-send-email-robherring2@gmail.com>
	<1307738923-7564-4-git-send-email-robherring2@gmail.com>
	<201106102304.06279.arnd@arndb.de>
Message-ID: <20110610223042.GE28994@ponder.secretlab.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 10, 2011 at 11:04:06PM +0200, Arnd Bergmann wrote:
> On Friday 10 June 2011 22:48:42 Rob Herring wrote:
> > 
> > +#ifdef CONFIG_OF
> > +int of_amba_device_create(struct device_node *node, struct device *parent);

Actually, it would probably be good to have of_amba_device_create()
return a pointer to the created amba_device.

> > +#endif
> > +
> > +#else
> > +
> > +#ifdef CONFIG_OF
> > +static inline int of_amba_device_create(struct device_node *node, 
> > +                                       struct device *parent)
> > +{
> > +       return 0;
> > +}
> > +#endif
> > +
> 
> We normally don't use #ifdef around declarations like this, it doesn't
> hurt to have them even when the code is not there. Otherwise the patch
> looks good.

Yes, this hook will never get called or referenced by anything if
CONFIG_OF is not selected.  The only real user of it will be
drivers/of/platform.c

g.
