From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 9 Dec 2013 17:39:27 +0100
Subject: [PATCH 9/9] ARM: pxa27x: device tree support ICP DAS LP-8x4x
In-Reply-To: <1386604530.7152.184.camel@host5.omatika.ru>
References: <1386348542-9584-1-git-send-email-ynvich@gmail.com>
 <1386602213.7152.180.camel@host5.omatika.ru>
 <1386604530.7152.184.camel@host5.omatika.ru>
Message-ID: <201312091739.27920.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 09 December 2013, Sergei Ianovich wrote:
> anovich wrote:
> > On Mon, 2013-12-09 at 02:47 +0100, Arnd Bergmann wrote:
> > > On Sunday 08 December 2013, Sergei Ianovich wrote:
> > > > +
> > > > +#ifdef CONFIG_PXA27x
> > > > +extern void __init pxa27x_dt_init_irq(void);
> > 
> > > > +static void __init pxa27x_init_early(void)
> > > > +{
> > > > +     pxa27x_skip_init();
> > > > +}
> > > 
> > > I would prefer not to have an init_early function at all, and instead
> > > check "if (of_have_populated_dt())" in pxa27x_init, or to split
> > > that function into two.
> 
> Although this is counterintuitive, it works. Since of_populate_dt() is
> not required for of_have_populated_dt() to return true, should we rename
> of_have_populated_dt() to of_have_dt()?

I don't think it's worth the change. The explanation for the current
terminoligy is that of_unflatten() populates the DT device_node structures
in the kernel from the FTD blob, while of_platform_populate populates the
platform_device infrastructure from the device nodes.

	Arnd
