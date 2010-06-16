From: will.deacon@arm.com (Will Deacon)
Date: Wed, 16 Jun 2010 13:33:22 +0100
Subject: [PATCH] OMAP3: pmu: make CPU_HAS_PMU dependent on OMAP3_EMU
In-Reply-To: <AANLkTikIiLybBr-wV_SRWFNLkZn892gwsWHCxsIYenFJ@mail.gmail.com>
References: <1274972448-10721-1-git-send-email-will.deacon@arm.com>
	<AANLkTikIiLybBr-wV_SRWFNLkZn892gwsWHCxsIYenFJ@mail.gmail.com>
Message-ID: <000c01cb0d50$1bdc7a90$53956fb0$@deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Jean,

> > diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> > index 1f254bd..98922f7 100644
> > --- a/arch/arm/Kconfig
> > +++ b/arch/arm/Kconfig
> > @@ -955,7 +955,8 @@ config XSCALE_PMU
> >        default y
> >
> >  config CPU_HAS_PMU
> > -       depends on CPU_V6 || CPU_V7 || XSCALE_PMU
> > +       depends on (CPU_V6 || CPU_V7 || XSCALE_PMU) && \
> > +                  (!ARCH_OMAP3 || OMAP3_EMU)
> >        default y
> >        bool
> >
> > --
> > 1.6.3.3
> >
> >
> 
> The patch nicely fixes the issue. Tested with Oprofile on OMAP3530
> EVM. RETention and OFF power modes succesfully tested.
> 
> Acked-by: Jean Pihet <jpihet@mvista.com>

Brilliant - thanks for testing this.
Tony: would you mind picking this patch up please or would
you prefer that I posted it to Russell's patch system?

Thanks,

Will
