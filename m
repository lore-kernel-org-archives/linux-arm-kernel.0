From: Dave.Martin@arm.com (Dave Martin)
Date: Mon, 14 Apr 2014 12:59:11 +0100
Subject: [PATCH 3/5] ARM: EXYNOS5420: Add IO mapping for non-secure SYSRAM
In-Reply-To: <11327275.EJLfDGG21r@wuerfel>
References: <1397239311-27717-1-git-send-email-a.kesavan@samsung.com>
 <1397239311-27717-4-git-send-email-a.kesavan@samsung.com>
 <20140414112520.GC3844@e103592.cambridge.arm.com>
 <11327275.EJLfDGG21r@wuerfel>
Message-ID: <20140414115910.GD3844@e103592.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 14, 2014 at 01:47:56PM +0200, Arnd Bergmann wrote:
> On Monday 14 April 2014 12:25:20 Dave Martin wrote:
> > On Fri, Apr 11, 2014 at 11:31:49PM +0530, Abhilash Kesavan wrote:
> > > On the Exynos5420 non-secure SYSRAM is used for secondary CPU bring-up,
> > > so add a mapping for it.
> > > 
> > > Signed-off-by: Thomas Abraham <thomas.ab@samsung.com>
> > > Signed-off-by: Abhilash Kesavan <a.kesavan@samsung.com>
> > > ---
> > >  arch/arm/mach-exynos/exynos.c           |   11 +++++++++++
> > >  arch/arm/mach-exynos/include/mach/map.h |    1 +
> > >  2 files changed, 12 insertions(+)
> > > 
> > > diff --git a/arch/arm/mach-exynos/exynos.c b/arch/arm/mach-exynos/exynos.c
> > > index b32a907..b1cf9d5 100644
> > > --- a/arch/arm/mach-exynos/exynos.c
> > > +++ b/arch/arm/mach-exynos/exynos.c
> > > @@ -159,6 +159,15 @@ static struct map_desc exynos5250_iodesc[] __initdata = {
> > >       },
> > >  };
> > >  
> > > +static struct map_desc exynos5420_iodesc[] __initdata = {
> > > +     {
> > > +             .virtual        = (unsigned long)S5P_VA_SYSRAM_NS,
> > > +             .pfn            = __phys_to_pfn(EXYNOS5420_PA_SYSRAM_NS),
> > > +             .length         = SZ_4K,
> > > +             .type           = MT_DEVICE,
> > > +     },
> > > +};
> > > +
> > 
> > Regarding Arnd's NAK in
> > http://lists.infradead.org/pipermail/linux-arm-kernel/2014-April/246936.html,
> > this looks like another instance of the same thing.
> > 
> > Arnd, what was your preferred solution?  Should this be described in DT?
> 
> Yes. There are already patches on the list to do this right.

This is http://www.spinics.net/lists/linux-samsung-soc/msg27647.html,
right?

If so, it looks like exynos5420 should definitely follow the same
approach.

Cheers
---Dave
