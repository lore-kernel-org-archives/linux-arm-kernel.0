From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Fri, 13 Dec 2013 22:57:33 +0100
Subject: [PATCH] ARM/cpuidle: remove __init tag from Calxeda cpuidle probe
 function
In-Reply-To: <1386967759-12952-1-git-send-email-andre.przywara@linaro.org>
References: <1386967759-12952-1-git-send-email-andre.przywara@linaro.org>
Message-ID: <52AB82CD.3040100@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/13/2013 09:49 PM, Andre Przywara wrote:
> Commit 60a66e370007e8535b7a561353b07b37deaf35ba changed the Calxeda
> cpuidle driver to a platform driver, copying the __init tag from the
> _init() to the newly used _probe() function. However, "probe should
> not be __init." (Rob said ;-)
> Remove the __init tag to fix a section mismatch in the Calxeda
> cpuidle driver.
>
> Signed-off-by: Andre Przywara <andre.przywara@linaro.org>
> ---

Applied to my tree for 3.14.

Thanks for the fix.

   -- Daniel

>   drivers/cpuidle/cpuidle-calxeda.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/cpuidle/cpuidle-calxeda.c b/drivers/cpuidle/cpuidle-calxeda.c
> index 3679563..6e51114 100644
> --- a/drivers/cpuidle/cpuidle-calxeda.c
> +++ b/drivers/cpuidle/cpuidle-calxeda.c
> @@ -65,7 +65,7 @@ static struct cpuidle_driver calxeda_idle_driver = {
>   	.state_count = 2,
>   };
>
> -static int __init calxeda_cpuidle_probe(struct platform_device *pdev)
> +static int calxeda_cpuidle_probe(struct platform_device *pdev)
>   {
>   	return cpuidle_register(&calxeda_idle_driver, NULL);
>   }
>


-- 
  <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
