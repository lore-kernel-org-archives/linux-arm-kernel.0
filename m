From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 21 Jan 2013 12:13:53 +0000
Subject: [PATCH] ARM: architected timers: allow dt based discovery
 using clocksource_of_init
In-Reply-To: <1358731326-2979-1-git-send-email-thomas.abraham@linaro.org>
References: <1358731326-2979-1-git-send-email-thomas.abraham@linaro.org>
Message-ID: <20130121121353.GH15707@e106331-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas,

This looks really useful, and it's going to conflict with my arch_timer /
arm_generic driver unification series [1].

I'm happy to take this as part of my series if that's ok with you?

On Mon, Jan 21, 2013 at 01:22:06AM +0000, Thomas Abraham wrote:
> Add an entry in __clksrc_of_table so that ARMv7 architected timer is
> discoverable using call to clocksource_of_init.
> 
> Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
> ---
>  arch/arm/kernel/arch_timer.c |    3 +++
>  1 files changed, 3 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/kernel/arch_timer.c b/arch/arm/kernel/arch_timer.c
> index c8ef207..d21aada 100644
> --- a/arch/arm/kernel/arch_timer.c
> +++ b/arch/arm/kernel/arch_timer.c
> @@ -504,6 +504,9 @@ int __init arch_timer_of_register(void)
>  
>  	return arch_timer_register();
>  }
> +#ifdef CONFIG_CLKSRC_OF
> +CLOCKSOURCE_OF_DECLARE(armv7_timer, "arm,armv7-timer", arch_timer_of_register)
> +#endif
>  
>  int __init arch_timer_sched_clock_init(void)
>  {
> -- 
> 1.7.5.4
> 
> _______________________________________________
> devicetree-discuss mailing list
> devicetree-discuss at lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/devicetree-discuss
> 

Thanks,
Mark.

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2013-January/142070.html
