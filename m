From: jic23@kernel.org (Jonathan Cameron)
Date: Tue, 19 Aug 2014 20:23:45 +0100
Subject: [PATCH] iio: adc: xilinx: Remove .owner field for driver
In-Reply-To: <32522124850adfda5c6cb8a7759d0e3a63893c1e.1407931250.git.michal.simek@xilinx.com>
References: <32522124850adfda5c6cb8a7759d0e3a63893c1e.1407931250.git.michal.simek@xilinx.com>
Message-ID: <53F3A441.1040103@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13/08/14 13:00, Michal Simek wrote:
> There is no need to init .owner field.
> 
> Based on the patch from Peter Griffin <peter.griffin@linaro.org>
> "mmc: remove .owner field for drivers using module_platform_driver"
> 
> This patch removes the superflous .owner field for drivers which
> use the module_platform_driver API, as this is overriden in
> platform_driver_register anyway."
> 
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
Applied to the togreg branch of iio.git

Thanks,

Jonathan
> ---
> 
>  drivers/iio/adc/xilinx-xadc-core.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/xilinx-xadc-core.c b/drivers/iio/adc/xilinx-xadc-core.c
> index fd2745c62943..92541a80b041 100644
> --- a/drivers/iio/adc/xilinx-xadc-core.c
> +++ b/drivers/iio/adc/xilinx-xadc-core.c
> @@ -1322,7 +1322,6 @@ static struct platform_driver xadc_driver = {
>  	.remove = xadc_remove,
>  	.driver = {
>  		.name = "xadc",
> -		.owner = THIS_MODULE,
>  		.of_match_table = xadc_of_match_table,
>  	},
>  };
> --
> 1.8.2.3
> 
