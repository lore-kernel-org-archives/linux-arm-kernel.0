From: horms@verge.net.au (Simon Horman)
Date: Wed, 27 Mar 2013 23:10:06 +0900
Subject: [PATCH 15/15] ARM: shmobile: cpuidle: use init/exit common routine
In-Reply-To: <1364234140-514-16-git-send-email-daniel.lezcano@linaro.org>
References: <1364234140-514-1-git-send-email-daniel.lezcano@linaro.org>
 <1364234140-514-16-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <20130327141006.GH4324@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 25, 2013 at 06:55:40PM +0100, Daniel Lezcano wrote:
> Remove the duplicate code and use the arm cpuidle driver's common code
> for initialization.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>

Acked-by: Simon Horman <horms+renesas@verge.net.au>

> ---
>  arch/arm/mach-shmobile/cpuidle.c |   10 +---------
>  1 file changed, 1 insertion(+), 9 deletions(-)
> 
> diff --git a/arch/arm/mach-shmobile/cpuidle.c b/arch/arm/mach-shmobile/cpuidle.c
> index c872ae8..9744d88 100644
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
> @@ -35,12 +34,5 @@ void __init shmobile_cpuidle_set_driver(struct cpuidle_driver *drv)
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
> +	return arm_cpuidle_init(cpuidle_drv);
>  }
> -- 
> 1.7.9.5
> 
