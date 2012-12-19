From: kgene.kim@samsung.com (Kukjin Kim)
Date: Tue, 18 Dec 2012 19:26:07 -0800
Subject: [PATCH] ARM: EXYNOS: fix GIC using for EXYNOS5440
In-Reply-To: <50C545E8.8050301@samsung.com>
References: <030c01cdd672$cb1b6b40$615241c0$%kim@samsung.com>
 <50C545E8.8050301@samsung.com>
Message-ID: <001501cddd98$9698dba0$c3ca92e0$@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Joonyoung Shim wrote:
> 
> Hi,
> 
> On 12/10/2012 10:07 AM, Kukjin Kim wrote:
> > Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
> > ---
> >   arch/arm/mach-exynos/common.c |    3 ++-
> >   1 files changed, 2 insertions(+), 1 deletions(-)
> >
> > diff --git a/arch/arm/mach-exynos/common.c b/arch/arm/mach-
> exynos/common.c
> > index 0eb3b9a..9ecda37 100644
> > --- a/arch/arm/mach-exynos/common.c
> > +++ b/arch/arm/mach-exynos/common.c
> > @@ -684,7 +684,8 @@ void __init exynos5_init_irq(void)
> >   	 * Theses parameters should be NULL and 0 because EXYNOS4
> >   	 * uses GIC instead of VIC.
> >   	 */
> > -	s5p_init_irq(NULL, 0);
> > +	if (!of_machine_is_compatible("samsung,exynos5440"))
> > +		s5p_init_irq(NULL, 0);
> 
> How about remove to call s5p_init_irq() here because All exynos SoCs use
> GIC instead of VIC?
> 

NO, the current s5p_init_irq() is not only for VIC but also Timer which is
used on EXYNOS SoCs, I know the name is strange...

> >   	gic_arch_extn.irq_set_wake = s3c_irq_wake;
> >   }
