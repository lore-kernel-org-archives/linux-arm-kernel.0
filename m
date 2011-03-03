From: Marc.Zyngier@arm.com (Marc Zyngier)
Date: Thu, 03 Mar 2011 09:17:32 +0000
Subject: [RFC PATCH 13/20] ARM: msm: dynamically register local timer
	setup function
In-Reply-To: <8ya39n5ntzt.fsf@huya.qualcomm.com>
References: <1299084806-16546-1-git-send-email-marc.zyngier@arm.com>
	<1299084806-16546-14-git-send-email-marc.zyngier@arm.com>
	<8ya39n5ntzt.fsf@huya.qualcomm.com>
Message-ID: <1299143852.10633.45.camel@e102391-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2011-03-02 at 12:32 -0800, David Brown wrote:

David,

> On Wed, Mar 02 2011, Marc Zyngier wrote:
> 
> > ---
> >  arch/arm/mach-msm/timer.c |   22 +++++++++++++++++++---
> >  1 files changed, 19 insertions(+), 3 deletions(-)
> >
> > diff --git a/arch/arm/mach-msm/timer.c b/arch/arm/mach-msm/timer.c
> > index 56f920c..e029363 100644
> > --- a/arch/arm/mach-msm/timer.c
> > +++ b/arch/arm/mach-msm/timer.c
> > @@ -228,6 +243,8 @@ static void __init msm_timer_init(void)
> >  	writel(DGT_CLK_CTL_DIV_4, MSM_TMR_BASE + DGT_CLK_CTL);
> >  #endif
> >  
> > +	percpu_timer_register(msm_timer_ops_ptr);
> > +
> >  	for (i = 0; i < ARRAY_SIZE(msm_clocks); i++) {
> >  		struct msm_clock *clock = &msm_clocks[i];
> >  		struct clock_event_device *ce = &clock->clockevent;
> 
> I'm having difficulty figuring out what tree/branch these patches are
> based off of, so I haven't been able to test this, yet.  But, so far,
> the MSM changes look coherent.
> 
> If you can give me a ref for your source tree, I can try to do some
> testing of these changes to make sure nothing is broken by it.

The whole serie is against -next as of yesterday, plus Will's multi-tile
support for Versatile Express, available from Russell's patch system:
http://www.arm.linux.org.uk/developer/patches/download.php?id=6771/1

It would be very helpful if you could give it a go on MSM.

Thanks,

	M.
-- 
Reality is an implementation detail.
