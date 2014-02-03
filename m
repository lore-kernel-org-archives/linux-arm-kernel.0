From: lee.jones@linaro.org (Lee Jones)
Date: Mon, 3 Feb 2014 09:30:13 +0000
Subject: [PATCH 05/18] mfd: max14577: Use of_match_ptr() in i2c_driver
In-Reply-To: <1390911522-28209-6-git-send-email-k.kozlowski@samsung.com>
References: <1390911522-28209-1-git-send-email-k.kozlowski@samsung.com>
 <1390911522-28209-6-git-send-email-k.kozlowski@samsung.com>
Message-ID: <20140203093013.GG13529@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Use of_match_ptr() in assignment of i2c_driver.of_match_table.
> 
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> Cc: Kyungmin Park <kyungmin.park@samsung.com>
> Cc: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>  drivers/mfd/max14577.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mfd/max14577.c b/drivers/mfd/max14577.c
> index 2ac2f2d7cea6..75b37082a3fe 100644
> --- a/drivers/mfd/max14577.c
> +++ b/drivers/mfd/max14577.c
> @@ -224,7 +224,7 @@ static struct i2c_driver max14577_i2c_driver = {
>  		.name = "max14577",
>  		.owner = THIS_MODULE,
>  		.pm = &max14577_pm,
> -		.of_match_table = max14577_dt_match,
> +		.of_match_table = of_match_ptr(max14577_dt_match),

Are you sure this is required?

>  	},
>  	.probe = max14577_i2c_probe,
>  	.remove = max14577_i2c_remove,

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
