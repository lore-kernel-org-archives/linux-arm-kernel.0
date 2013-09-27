From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Fri, 27 Sep 2013 10:19:19 +0200
Subject: [PATCH 1/2] ARM: zynq: cpuidle: Remove useless compatibility
 string
In-Reply-To: <1380269867-18336-1-git-send-email-daniel.lezcano@linaro.org>
References: <1380269867-18336-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <52453F87.2090508@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/27/2013 10:17 AM, Daniel Lezcano wrote:
> All zynq platforms have this compatibility string and there is no any other
> clone.
>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>

As I don't have the hardware, this patchset is just compile tested.

> ---
>   drivers/cpuidle/cpuidle-zynq.c |    4 ----
>   1 file changed, 4 deletions(-)
>
> diff --git a/drivers/cpuidle/cpuidle-zynq.c b/drivers/cpuidle/cpuidle-zynq.c
> index 38e03a1..ab6c4b4 100644
> --- a/drivers/cpuidle/cpuidle-zynq.c
> +++ b/drivers/cpuidle/cpuidle-zynq.c
> @@ -28,7 +28,6 @@
>   #include <linux/init.h>
>   #include <linux/cpu_pm.h>
>   #include <linux/cpuidle.h>
> -#include <linux/of.h>
>   #include <asm/proc-fns.h>
>   #include <asm/cpuidle.h>
>
> @@ -72,9 +71,6 @@ static struct cpuidle_driver zynq_idle_driver = {
>   /* Initialize CPU idle by registering the idle states */
>   static int __init zynq_cpuidle_init(void)
>   {
> -	if (!of_machine_is_compatible("xlnx,zynq-7000"))
> -		return -ENODEV;
> -
>   	pr_info("Xilinx Zynq CpuIdle Driver started\n");
>
>   	return cpuidle_register(&zynq_idle_driver, NULL);
>


-- 
  <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
