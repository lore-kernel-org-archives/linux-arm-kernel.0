From: davidb@codeaurora.org (David Brown)
Date: Wed, 02 Mar 2011 12:32:38 -0800
Subject: [RFC PATCH 13/20] ARM: msm: dynamically register local timer
	setup function
In-Reply-To: <1299084806-16546-14-git-send-email-marc.zyngier@arm.com> (Marc
	Zyngier's message of "Wed, 2 Mar 2011 16:53:19 +0000")
References: <1299084806-16546-1-git-send-email-marc.zyngier@arm.com>
	<1299084806-16546-14-git-send-email-marc.zyngier@arm.com>
Message-ID: <8ya39n5ntzt.fsf@huya.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 02 2011, Marc Zyngier wrote:

> ---
>  arch/arm/mach-msm/timer.c |   22 +++++++++++++++++++---
>  1 files changed, 19 insertions(+), 3 deletions(-)
>
> diff --git a/arch/arm/mach-msm/timer.c b/arch/arm/mach-msm/timer.c
> index 56f920c..e029363 100644
> --- a/arch/arm/mach-msm/timer.c
> +++ b/arch/arm/mach-msm/timer.c
> @@ -228,6 +243,8 @@ static void __init msm_timer_init(void)
>  	writel(DGT_CLK_CTL_DIV_4, MSM_TMR_BASE + DGT_CLK_CTL);
>  #endif
>  
> +	percpu_timer_register(msm_timer_ops_ptr);
> +
>  	for (i = 0; i < ARRAY_SIZE(msm_clocks); i++) {
>  		struct msm_clock *clock = &msm_clocks[i];
>  		struct clock_event_device *ce = &clock->clockevent;

I'm having difficulty figuring out what tree/branch these patches are
based off of, so I haven't been able to test this, yet.  But, so far,
the MSM changes look coherent.

If you can give me a ref for your source tree, I can try to do some
testing of these changes to make sure nothing is broken by it.

Thanks,
David

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
