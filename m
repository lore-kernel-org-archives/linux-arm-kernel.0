From: albin.tonnerre@gmail.com (Albin Tonnerre)
Date: Wed, 10 Mar 2010 23:27:31 +0100
Subject: [PATCH 1/6] ARM: perf-events: add Realview PMU IRQs to pmu.c
In-Reply-To: <20100310215918.GR2900@atomide.com>
References: <1268217690-29712-1-git-send-email-will.deacon@arm.com>
	<1268217690-29712-2-git-send-email-will.deacon@arm.com>
	<20100310215918.GR2900@atomide.com>
Message-ID: <20100310222731.GH4585@pc-ran3241>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 10 Mar 2010 13:59 -0800, Tony Lindgren wrote :
> * Will Deacon <will.deacon@arm.com> [100310 02:46]:
> > Add the PMU IRQs for the Realview boards to kernel/pmu.c so that
> > they can be used by the perf-events framework.
> > 
> > Signed-off-by: Will Deacon <will.deacon@arm.com>
> > ---
> >  arch/arm/kernel/pmu.c |   14 ++++++++++++++
> >  1 files changed, 14 insertions(+), 0 deletions(-)
> > 
> > diff --git a/arch/arm/kernel/pmu.c b/arch/arm/kernel/pmu.c
> > index a124312..11a321e 100644
> > --- a/arch/arm/kernel/pmu.c
> > +++ b/arch/arm/kernel/pmu.c
> > @@ -36,6 +36,20 @@ static const int irqs[] = {
> >  	IRQ_EB11MP_PMU_CPU1,
> >  	IRQ_EB11MP_PMU_CPU2,
> >  	IRQ_EB11MP_PMU_CPU3,
> > +#elif defined(CONFIG_MACH_REALVIEW_PB1176)
> > +	IRQ_DC1176_CORE_PMU,
> > +#elif defined(CONFIG_MACH_REALVIEW_PB11MP)
> > +	IRQ_TC11MP_PMU_CPU0,
> > +	IRQ_TC11MP_PMU_CPU1,
> > +	IRQ_TC11MP_PMU_CPU2,
> > +	IRQ_TC11MP_PMU_CPU3,
> > +#elif defined(CONFIG_MACH_REALVIEW_PBA8)
> > +	IRQ_PBA8_PMU,
> > +#elif defined(CONFIG_MACH_REALVIEW_PBX)
> > +	IRQ_PBX_PMU_CPU0,
> > +	IRQ_PBX_PMU_CPU1,
> > +	IRQ_PBX_PMU_CPU2,
> > +	IRQ_PBX_PMU_CPU3,
> >  #elif defined(CONFIG_ARCH_OMAP3)
> >  	INT_34XX_BENCH_MPU_EMUL,
> >  #elif defined(CONFIG_ARCH_IOP32X)
> 
> Just a generic comment.. It would be nice to get rid of the
> ifdef eliffery here for the interrupt. At least we can now
> compile omap2 + 3 + 4 into the same binary, so stuff like
> this caused mysterious errors easily.

That's the purpose of another patch series Will has submitted as an RFC,
see '[RFC PATCH 0/2] ARM: pmu: provide a registration mechanism for IRQs'

Cheers,
-- 
Albin Tonnerre
