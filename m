From: horms@verge.net.au (Simon Horman)
Date: Mon, 15 Apr 2013 12:56:18 +0900
Subject: [V3 patch 02/19] ARM: shmobile: cpuidle: remove
 shmobile_enter_wfi prototype
In-Reply-To: <1365770165-27096-3-git-send-email-daniel.lezcano@linaro.org>
References: <1365770165-27096-1-git-send-email-daniel.lezcano@linaro.org>
 <1365770165-27096-3-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <20130415035618.GC3070@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 12, 2013 at 02:35:48PM +0200, Daniel Lezcano wrote:
> Commit 688036b538974de32ce55be8b0e013b003992abc removed the function
> 'shmobile_enter_wfi' but we forgot to remove the definition in the header file.
> 
> Note this function is just an alias to 'cpu_do_idle()' wrapped into a cpuidle
> function callback prototype which already exists with the default WFI state
> and the arm_simple_enter function.
> 
> Remove the function prototype.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>

Acked-by: Simon Horman <horms+renesas@verge.net.au>

> ---
>  arch/arm/mach-shmobile/include/mach/common.h |    3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/arch/arm/mach-shmobile/include/mach/common.h b/arch/arm/mach-shmobile/include/mach/common.h
> index e48606d..362f9b2 100644
> --- a/arch/arm/mach-shmobile/include/mach/common.h
> +++ b/arch/arm/mach-shmobile/include/mach/common.h
> @@ -13,9 +13,6 @@ extern int shmobile_clk_init(void);
>  extern void shmobile_handle_irq_intc(struct pt_regs *);
>  extern struct platform_suspend_ops shmobile_suspend_ops;
>  struct cpuidle_driver;
> -struct cpuidle_device;
> -extern int shmobile_enter_wfi(struct cpuidle_device *dev,
> -			      struct cpuidle_driver *drv, int index);
>  extern void shmobile_cpuidle_set_driver(struct cpuidle_driver *drv);
>  
>  extern void sh7372_init_irq(void);
> -- 
> 1.7.9.5
> 
