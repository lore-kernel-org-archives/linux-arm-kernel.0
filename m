From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 8 Feb 2017 12:19:23 +0000
Subject: [PATCH] mfd: stm32-timers: fix driver removal
In-Reply-To: <1485967306-30589-1-git-send-email-fabrice.gasnier@st.com>
References: <1485967306-30589-1-git-send-email-fabrice.gasnier@st.com>
Message-ID: <20170208121923.p6mpt55n554zcead@dell>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 01 Feb 2017, Fabrice Gasnier wrote:

> Add missing of_platform_depopulate() upon driver removal.
> 
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
> ---
>  drivers/mfd/stm32-timers.c | 8 ++++++++
>  1 file changed, 8 insertions(+)

Applied, thanks.

> diff --git a/drivers/mfd/stm32-timers.c b/drivers/mfd/stm32-timers.c
> index 41bd901..192cbb6 100644
> --- a/drivers/mfd/stm32-timers.c
> +++ b/drivers/mfd/stm32-timers.c
> @@ -61,6 +61,13 @@ static int stm32_timers_probe(struct platform_device *pdev)
>  	return of_platform_populate(pdev->dev.of_node, NULL, NULL, &pdev->dev);
>  }
>  
> +static int stm32_timers_remove(struct platform_device *pdev)
> +{
> +	of_platform_depopulate(&pdev->dev);
> +
> +	return 0;
> +}
> +
>  static const struct of_device_id stm32_timers_of_match[] = {
>  	{ .compatible = "st,stm32-timers", },
>  	{ /* end node */ },
> @@ -69,6 +76,7 @@ static int stm32_timers_probe(struct platform_device *pdev)
>  
>  static struct platform_driver stm32_timers_driver = {
>  	.probe = stm32_timers_probe,
> +	.remove = stm32_timers_remove,
>  	.driver	= {
>  		.name = "stm32-timers",
>  		.of_match_table = stm32_timers_of_match,

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
