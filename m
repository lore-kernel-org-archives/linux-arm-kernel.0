From: kgene.kim@samsung.com (Kukjin Kim)
Date: Sat, 15 Jun 2013 11:24:38 +0900
Subject: [PATCH] ARM: exynos: remove unused code
In-Reply-To: <CAOesGMjKZGWp9J5pTj6C4K20xENCtm_G=b8oKwTTkJ-03-X=Gw@mail.gmail.com>
References: <51B791EF.9070904@samsung.com> <201306141517.24287.arnd@arndb.de>
 <CAOesGMjKZGWp9J5pTj6C4K20xENCtm_G=b8oKwTTkJ-03-X=Gw@mail.gmail.com>
Message-ID: <172501ce696f$7c346d20$749d4760$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Olof Johansson wrote:
> 
> On Fri, Jun 14, 2013 at 6:17 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> > After exynos has been converted to DT-only booting by removing
> > most a lot of the ATAGS code, I had a closer look of what is
> > left. It turns out that a number of unused files are left in
> > the tree that can be removed along with about another quarter
> > of the remaining code in mach-exynos.
> >
> > Specifically this includes:
> >
> > * all board files
> > * all setup-*.c files
> > * dev-audio.c and dev-uart.c
> > * all code testing for of_have_populated_dt
> > * the eint_irqchip
> > * almost all the mach/irqs.h constants (the remaining ones
> >   are likely bugs)
> > * Most physical address constants. The remaining ones are
> >   either bugs or used for the iotable. Both can probably
> >   get removed in the long run.
> > * regs-usb-phy.h, which was already unused before
> > * A lot of code in plat-samsung/ can be made conditional
> >   on CONFIG_ATAGS, in particular now unused device
> >   definitions.
> >
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> 
> Acked-by: Olof Johansson <olof@lixom.net>
> 
> > Hi Kukjin,
> >
> > Could you check the validity of this patch please?
> >
> > I think we should apply it on top of your series. I've generated
> > the patch using 'git format-patch -D' for brevity, so be careful
> > to actually delete the unused files if you want to apply it to
> > a local branch on your side.
> 
> Great. This is the piece that I wanted to see in the non-DT-removal
> branch before I pulled it.
> 
Yeah, I think so. But as Arnd suggested, I'm looking at Tomasz's patches and
it will be sorted out in this weekend.

Thanks,
- Kukjin
