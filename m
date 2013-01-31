From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 31 Jan 2013 20:57:13 +0000
Subject: [PATCH, RFC] default machine descriptor for multiplatform
In-Reply-To: <510ABD70.1020408@wwwdotorg.org>
References: <20130131092024.GN2637@n2100.arm.linux.org.uk>
 <1638002.UJ7zfj1Wn5@wuerfel> <510ABD70.1020408@wwwdotorg.org>
Message-ID: <201301312057.13913.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 31 January 2013, Stephen Warren wrote:

> With that change, we can remove the custom .init_machine() functions for
> all of Tegra, since they just do that:-)

Yes, actually quite a lot of them have the same code, and we also have
an increasing number of users of the irqchip_init and clocksource_of_init,
so those can also be cleaned up as a follow-on to this patch.

The main thing that has to remain for a lot of the platforms is SMP
support, and I don't see a good way around that yet.
 
> > diff --git a/drivers/irqchip/irqchip.c b/drivers/irqchip/irqchip.c
> 
> > +#ifdef CONFIG_IRQCHIP
> >  void __init irqchip_init(void)
> >  {
> >  	of_irq_init(__irqchip_begin);
> >  }
> > +#else
> > +static inline void irqchip_init(void)
> > +{
> > +}
> > +#endif
> 
> That'd need to go in a header file.

Yep, you're right, my mistake.

	Arnd
