From: ynvich@gmail.com (Sergei Ianovich)
Date: Mon, 09 Dec 2013 19:55:30 +0400
Subject: [PATCH 9/9] ARM: pxa27x: device tree support ICP DAS LP-8x4x
In-Reply-To: <1386602213.7152.180.camel@host5.omatika.ru>
References: <1386348542-9584-1-git-send-email-ynvich@gmail.com>
 <1386543229-1542-1-git-send-email-ynvich@gmail.com>
 <1386543229-1542-10-git-send-email-ynvich@gmail.com>
 <201312090247.24978.arnd@arndb.de>
 <1386602213.7152.180.camel@host5.omatika.ru>
Message-ID: <1386604530.7152.184.camel@host5.omatika.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2013-12-09 at 19:16 +0400, Sergei Ianovich wrote:
> On Mon, 2013-12-09 at 02:47 +0100, Arnd Bergmann wrote:
> > On Sunday 08 December 2013, Sergei Ianovich wrote:
> > > +
> > > +#ifdef CONFIG_PXA27x
> > > +extern void __init pxa27x_dt_init_irq(void);
> 
> > > +static void __init pxa27x_init_early(void)
> > > +{
> > > +     pxa27x_skip_init();
> > > +}
> > 
> > I would prefer not to have an init_early function at all, and instead
> > check "if (of_have_populated_dt())" in pxa27x_init, or to split
> > that function into two.

Although this is counterintuitive, it works. Since of_populate_dt() is
not required for of_have_populated_dt() to return true, should we rename
of_have_populated_dt() to of_have_dt()?

> Device tree is populated in init_machine. However, pxa27x_init is
> executed before via postcore_initcall. The only chance to run before is
> to use init_early. What's wrong with this function?

I was wrong.
