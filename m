From: ben-linux@fluff.org (Ben Dooks)
Date: Fri, 28 May 2010 08:10:57 +0100
Subject: [PATCH 2/4] ARM: S5PV210: Assign clock rate for clk_xusbxti clock.
In-Reply-To: <1275014477-23133-3-git-send-email-kgene.kim@samsung.com>
References: <1275014477-23133-1-git-send-email-kgene.kim@samsung.com>
	<1275014477-23133-3-git-send-email-kgene.kim@samsung.com>
Message-ID: <20100528071057.GX4720@trinity.fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 28, 2010 at 11:41:15AM +0900, Kukjin Kim wrote:
> From: Thomas Abraham <thomas.ab@samsung.com>
> 
> The input clock frequency for USB Phy is 24 Mhz on the S5PV210
> platform. This patch initializes the clk_xusbxti clock rate to 24Mhz.

is this all s5pv210/s5pc110 machines, or are there any current/likely
machines with non 24M clocks?
 
> Signed-off-by: Thomas Abraham <thomas.ab@samsung.com>
> Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
> ---
>  arch/arm/mach-s5pv210/clock.c |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-s5pv210/clock.c b/arch/arm/mach-s5pv210/clock.c
> index 154bca4..4ef09d4 100644
> --- a/arch/arm/mach-s5pv210/clock.c
> +++ b/arch/arm/mach-s5pv210/clock.c
> @@ -954,6 +954,8 @@ void __init_or_cpufreq s5pv210_setup_clocks(void)
>  
>  	printk(KERN_DEBUG "%s: registering clocks\n", __func__);
>  
> +	clk_xusbxti.rate = 24 * MHZ;
> +
>  	clkdiv0 = __raw_readl(S5P_CLK_DIV0);
>  	clkdiv1 = __raw_readl(S5P_CLK_DIV1);
>  
> -- 
> 1.6.3.3
> 

-- 
-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.
