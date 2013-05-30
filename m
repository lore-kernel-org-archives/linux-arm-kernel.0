From: srinidhi.kasagar@stericsson.com (Srinidhi Kasagar)
Date: Thu, 30 May 2013 12:56:13 +0530
Subject: [PATCH 6/8] ARM: ux500: use generic cpu idle function for wfi
In-Reply-To: <1369665166-13049-7-git-send-email-sanjay.rawat@linaro.org>
References: <1369665166-13049-1-git-send-email-sanjay.rawat@linaro.org>
 <1369665166-13049-7-git-send-email-sanjay.rawat@linaro.org>
Message-ID: <20130530072612.GB32244@bnru10>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 27, 2013 at 16:32:43 +0200, Sanjay Singh Rawat wrote:
> use cpu_do_idle for entering the wfi mode.
> 
> Signed-off-by: Sanjay Singh Rawat <sanjay.rawat@linaro.org>
> ---
>  arch/arm/mach-ux500/hotplug.c |    5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/mach-ux500/hotplug.c b/arch/arm/mach-ux500/hotplug.c
> index 2bc00b0..f4ded92 100644
> --- a/arch/arm/mach-ux500/hotplug.c
> +++ b/arch/arm/mach-ux500/hotplug.c
> @@ -25,8 +25,9 @@ void __ref ux500_cpu_die(unsigned int cpu)
>  {
>  	/* directly enter low power state, skipping secure registers */
>  	for (;;) {
> -		__asm__ __volatile__("dsb\n\t" "wfi\n\t"
> -				: : : "memory");
> +		/* enter WFI mode */
> +		cpu_do_idle();
> +

Acked-by: srinidhi kasagar <srinidhi.kasagar@stericsson.com>

srinidhi

>  		if (pen_release == cpu_logical_map(cpu)) {
>  			/*
>  			 * OK, proper wakeup, we're done
> -- 
> 1.7.9.5
> 
