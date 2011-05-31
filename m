From: Marc.Zyngier@arm.com (Marc Zyngier)
Date: Tue, 31 May 2011 09:21:00 +0100
Subject: [RFC PATCH v5 13/13] ARM: SMP: automatically select ARM_GIC_VPPI
In-Reply-To: <4DE4A100.8020009@codeaurora.org>
References: <1306749894-28749-1-git-send-email-marc.zyngier@arm.com>
	<1306749894-28749-14-git-send-email-marc.zyngier@arm.com>
	<4DE4A100.8020009@codeaurora.org>
Message-ID: <1306830060.27474.302.camel@e102391-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2011-05-31 at 01:04 -0700, Stephen Boyd wrote:
> On 5/30/2011 3:04 AM, Marc Zyngier wrote:
> > diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> > index 9adc278..60942681 100644
> > --- a/arch/arm/Kconfig
> > +++ b/arch/arm/Kconfig
> > @@ -1313,6 +1313,7 @@ config SMP
> >  		 ARCH_EXYNOS4 || ARCH_TEGRA || ARCH_U8500 || ARCH_VEXPRESS_CA9X4 || \
> >  		 ARCH_MSM_SCORPIONMP || ARCH_SHMOBILE
> >  	select USE_GENERIC_SMP_HELPERS
> > +	select ARM_GIC_VPPI
> >  	select HAVE_ARM_SCU if !ARCH_MSM_SCORPIONMP
> 
> Would it be better to select GIC_VPPI only if GIC is selected as well? So
> 
>     select ARM_GIC_VPPI if ARM_GIC

Possibly.

> Or put this select under ARM_GIC and have it be
> 
>     select ARM_GIC_VPPI if SMP
> 
> ?

No, I want to be able to select GIC_VPPI even on UP (A15x1 requires it,
for exemple).

But in the end, if everybody agrees this whole series is sensible, I'd
rather get rid of the option and make it a permanent feature (patch #11
removes gic_enable_ppi() anyway, making the use of naked PPIs tricky at
best...).

	M.
-- 
Reality is an implementation detail.
