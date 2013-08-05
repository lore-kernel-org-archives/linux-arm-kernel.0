From: baozich@gmail.com (Chen Baozi)
Date: Mon, 5 Aug 2013 23:26:28 +0800
Subject: [PATCH] ARM: fix wrong address when loading
 PRM_FRAC_INCREMENTOR_DENUMERATOR_RELOAD
In-Reply-To: <1375356474-24203-1-git-send-email-baozich@gmail.com>
References: <1375356474-24203-1-git-send-email-baozich@gmail.com>
Message-ID: <C635EF21-CD18-4633-AA39-16209F8EE231@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ping?

On Aug 1, 2013, at 7:27 PM, Chen Baozi <baozich@gmail.com> wrote:

> The denominator should be load from INCREMENTOR_DENUMERATOR_RELOAD_OFFSET
> rather than INCREMENTER_NUMERATOR_OFFSET.
> 
> Signed-off-by: Chen Baozi <baozich@gmail.com>
> ---
> arch/arm/mach-omap2/timer.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-omap2/timer.c b/arch/arm/mach-omap2/timer.c
> index b37e1fc..9265e03 100644
> --- a/arch/arm/mach-omap2/timer.c
> +++ b/arch/arm/mach-omap2/timer.c
> @@ -537,7 +537,7 @@ static void __init realtime_counter_init(void)
> 	reg |= num;
> 	__raw_writel(reg, base + INCREMENTER_NUMERATOR_OFFSET);
> 
> -	reg = __raw_readl(base + INCREMENTER_NUMERATOR_OFFSET) &
> +	reg = __raw_readl(base + INCREMENTER_DENUMERATOR_RELOAD_OFFSET) &
> 			NUMERATOR_DENUMERATOR_MASK;
> 	reg |= den;
> 	__raw_writel(reg, base + INCREMENTER_DENUMERATOR_RELOAD_OFFSET);
> -- 
> 1.8.1.4
> 
