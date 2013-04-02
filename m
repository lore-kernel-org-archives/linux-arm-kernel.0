From: pawel.moll@arm.com (Pawel Moll)
Date: Tue, 02 Apr 2013 17:41:10 +0100
Subject: [PATCH v2 06/13] ARM: vexpress: remove sp804 OF init
In-Reply-To: <1364854883-5961-7-git-send-email-robherring2@gmail.com>
References: <1364854883-5961-1-git-send-email-robherring2@gmail.com>
 <1364854883-5961-7-git-send-email-robherring2@gmail.com>
Message-ID: <1364920870.3019.31.camel@hornet>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2013-04-01 at 23:21 +0100, Rob Herring wrote:
> From: Rob Herring <rob.herring@calxeda.com>
> 
> Remove the vexpress specific setup for the sp804 timer now that
> clocksource_of_init will do it.
> 
> Signed-off-by: Rob Herring <rob.herring@calxeda.com>
> ---
>  arch/arm/mach-vexpress/v2m.c |   11 -----------
>  1 file changed, 11 deletions(-)
> 
> diff --git a/arch/arm/mach-vexpress/v2m.c b/arch/arm/mach-vexpress/v2m.c
> index 6215717..cdc29d8 100644
> --- a/arch/arm/mach-vexpress/v2m.c
> +++ b/arch/arm/mach-vexpress/v2m.c
> @@ -431,20 +431,9 @@ void __init v2m_dt_init_early(void)
>  
>  static void __init v2m_dt_timer_init(void)
>  {
> -	struct device_node *node = NULL;
> -
>  	vexpress_clk_of_init();
>  
>  	clocksource_of_init();
> -	do {
> -		node = of_find_compatible_node(node, NULL, "arm,sp804");
> -	} while (node && vexpress_get_site_by_node(node) != VEXPRESS_SITE_MB);
> -	if (node) {
> -		pr_info("Using SP804 '%s' as a clock & events source\n",
> -				node->full_name);
> -		v2m_sp804_init(of_iomap(node, 0),
> -				irq_of_parse_and_map(node, 0));
> -	}
>  
>  	versatile_sched_clock_init(vexpress_get_24mhz_clock_base(),
>  				24000000);

Acked-by: Pawel Moll <pawel.moll@arm.com>

Thanks!

Pawel
