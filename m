From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 30 May 2017 10:29:58 +0100
Subject: [PATCH 05/15] mfd: stm32-timers: use devm_of_platform_populate
In-Reply-To: <1496072763-31209-6-git-send-email-benjamin.gaignard@linaro.org>
References: <1496072763-31209-1-git-send-email-benjamin.gaignard@linaro.org>
 <1496072763-31209-6-git-send-email-benjamin.gaignard@linaro.org>
Message-ID: <20170530092958.llo37hjt6c73eww3@dell>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 29 May 2017, Benjamin Gaignard wrote:

> Use devm_of_platform_populate() instead of of_platform_populate()
> and suppress stm32_timers_remove() which become useless.
> 
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@linaro.org>
> 
> CC: Lee Jones <lee.jones@linaro.org>
> CC: Alexandre Torgue <alexandre.torgue@st.com>
> CC: linux-arm-kernel at lists.infradead.org
> CC: linux-kernel at vger.kernel.org
> ---
>  drivers/mfd/stm32-timers.c | 10 +---------
>  1 file changed, 1 insertion(+), 9 deletions(-)

Applied, thanks.

> diff --git a/drivers/mfd/stm32-timers.c b/drivers/mfd/stm32-timers.c
> index 2182f00..a6675a4 100644
> --- a/drivers/mfd/stm32-timers.c
> +++ b/drivers/mfd/stm32-timers.c
> @@ -58,14 +58,7 @@ static int stm32_timers_probe(struct platform_device *pdev)
>  
>  	platform_set_drvdata(pdev, ddata);
>  
> -	return of_platform_populate(pdev->dev.of_node, NULL, NULL, &pdev->dev);
> -}
> -
> -static int stm32_timers_remove(struct platform_device *pdev)
> -{
> -	of_platform_depopulate(&pdev->dev);
> -
> -	return 0;
> +	return devm_of_platform_populate(&pdev->dev);
>  }
>  
>  static const struct of_device_id stm32_timers_of_match[] = {
> @@ -76,7 +69,6 @@ static int stm32_timers_remove(struct platform_device *pdev)
>  
>  static struct platform_driver stm32_timers_driver = {
>  	.probe = stm32_timers_probe,
> -	.remove = stm32_timers_remove,
>  	.driver	= {
>  		.name = "stm32-timers",
>  		.of_match_table = stm32_timers_of_match,

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
