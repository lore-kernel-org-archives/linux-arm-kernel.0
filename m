From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 20 Dec 2013 22:21:50 -0800
Subject: [PATCH 2/7] ARM: msm: Add support for APQ8074 Dragonboard
In-Reply-To: <201312202134.42027.arnd@arndb.de>
References: <1387566560-23948-1-git-send-email-davidb@codeaurora.org>
 <1387566560-23948-3-git-send-email-davidb@codeaurora.org>
 <201312202134.42027.arnd@arndb.de>
Message-ID: <20131221062150.GE31766@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/20, Arnd Bergmann wrote:
> On Friday 20 December 2013, David Brown wrote:
> > diff --git a/arch/arm/mach-msm/board-dt.c b/arch/arm/mach-msm/board-dt.c
> > index 16e6183..1f11d93 100644
> > --- a/arch/arm/mach-msm/board-dt.c
> > +++ b/arch/arm/mach-msm/board-dt.c
> > @@ -26,7 +26,16 @@ static const char * const msm_dt_match[] __initconst = {
> >         NULL
> >  };
> >  
> > +static const char * const apq8074_dt_match[] __initconst = {
> > +       "qcom,apq8074-dragonboard",
> > +       NULL
> > +};
> > +
> >  DT_MACHINE_START(MSM_DT, "Qualcomm MSM (Flattened Device Tree)")
> >         .smp = smp_ops(msm_smp_ops),
> >         .dt_compat = msm_dt_match,
> >  MACHINE_END
> > +
> > +DT_MACHINE_START(APQ_DT, "Qualcomm MSM (Flattened Device Tree)")
> > +       .dt_compat = apq8074_dt_match,
> > +MACHINE_END
> > -- 
> 
> Why can't you reuse the MSM_DT definition and just add the dragonboard
> to the list of compatible machines? The presence of the smp_ops pointer
> should not matter if you don't support SMP.
> 

If the smp_ops are present we'll try to boot the secondary CPUs
with the Scorpion boot sequence instead of the Krait boot
sequence. This will quickly hang the system. We can properly
handle this with my SMP patches[1]. In fact, we can delete this
entire file if those patches are accepted. Please take a look.
I'll Cc you on them when I resend.

[1] https://lkml.org/lkml/2013/11/1/622

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
