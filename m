From: leif.lindholm@linaro.org (Leif Lindholm)
Date: Tue, 10 Sep 2013 14:02:07 +0200
Subject: [PATCH v2 2/2] arm: add early_ioremap support
In-Reply-To: <20130906161448.GI1946@arm.com>
References: <1378459158-2145-1-git-send-email-leif.lindholm@linaro.org>
 <1378459158-2145-3-git-send-email-leif.lindholm@linaro.org>
 <20130906161448.GI1946@arm.com>
Message-ID: <20130910120205.GW18151@rocoto.smurfnet.nu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 06, 2013 at 05:14:49PM +0100, Catalin Marinas wrote:
> On Fri, Sep 06, 2013 at 10:19:18AM +0100, Leif Lindholm wrote:
> > --- a/arch/arm/kernel/setup.c
> > +++ b/arch/arm/kernel/setup.c
> > @@ -877,6 +878,10 @@ void __init setup_arch(char **cmdline_p)
> > 
> >         parse_early_param();
> > 
> > +#ifdef CONFIG_EARLY_IOREMAP
> > +       early_ioremap_init();
> > +#endif
> 
> Better with a dummy early_ioremap_init() in the header when
> !CONFIG_EARLY_IOREMAP to avoid the #ifdef here.
 
Ok, makes sense.

> > --- /dev/null
> > +++ b/arch/arm/mm/early_ioremap.c
> > @@ -0,0 +1,271 @@
> > +/*
> > + * early_ioremap() support for ARM
> > + *
> > + * Based on existing support in arch/x86/mm/ioremap.c
> 
> At a very quick look, this looks really close to the x86 implementation.
> Any reason why this cannot be made generic and avoid duplication?

Mainly that the bits that can be easily shared aren't really the
interesting ones. Making it properly shared would require a rewrite
of ARM kmap().

/
    Leif
