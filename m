From: horms@verge.net.au (Simon Horman)
Date: Mon, 15 Apr 2013 12:56:25 +0900
Subject: [V3 patch 12/19] ARM: shmobile: cpuidle: use init/exit common
 routine
In-Reply-To: <1365770165-27096-13-git-send-email-daniel.lezcano@linaro.org>
References: <1365770165-27096-1-git-send-email-daniel.lezcano@linaro.org>
 <1365770165-27096-13-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <20130415035625.GD3070@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 12, 2013 at 02:35:58PM +0200, Daniel Lezcano wrote:
> Remove the duplicated code and use the cpuidle common code for initialization.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> Acked-by: Simon Horman <horms+renesas@verge.net.au>
> ---
>  arch/arm/mach-shmobile/cpuidle.c |   10 +---------
>  1 file changed, 1 insertion(+), 9 deletions(-)
> 
> diff --git a/arch/arm/mach-shmobile/cpuidle.c b/arch/arm/mach-shmobile/cpuidle.c
> index d671ae9..0afeb5c 100644
> --- a/arch/arm/mach-shmobile/cpuidle.c
> +++ b/arch/arm/mach-shmobile/cpuidle.c
> @@ -16,7 +16,6 @@
>  #include <asm/cpuidle.h>
>  #include <asm/io.h>
>  
> -static struct cpuidle_device shmobile_cpuidle_dev;
>  static struct cpuidle_driver shmobile_cpuidle_default_driver = {
>  	.name			= "shmobile_cpuidle",
>  	.owner			= THIS_MODULE,
> @@ -34,12 +33,5 @@ void __init shmobile_cpuidle_set_driver(struct cpuidle_driver *drv)
>  
>  int __init shmobile_cpuidle_init(void)
>  {
> -	struct cpuidle_device *dev = &shmobile_cpuidle_dev;
> -
> -	cpuidle_register_driver(cpuidle_drv);
> -
> -	dev->state_count = cpuidle_drv->state_count;
> -	cpuidle_register_device(dev);
> -
> -	return 0;
> +	return cpuidle_register(cpuidle_drv, NULL);
>  }
> -- 
> 1.7.9.5
> 
