From: jic23@kernel.org (Jonathan Cameron)
Date: Sat, 30 Aug 2014 10:45:38 +0100
Subject: [PATCH] iio: adc: rockchip_saradc: remove unused variable in probe
In-Reply-To: <2134722.Yfu4MZ4klm@diego>
References: <2134722.Yfu4MZ4klm@diego>
Message-ID: <54019D42.205@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 26/08/14 23:40, Heiko St?bner wrote:
> The rate variable in the probe function of the saradc is a remnant
> of a previous patch iteration. It is unused and thus produces a
> compile time warning. Therefore remove it.
> 
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Applied to the togreg branch of iio.git - initially pushed out as testing
for the autobuilders to play.

Thanks,

Jonathan
> ---
>  drivers/iio/adc/rockchip_saradc.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/rockchip_saradc.c b/drivers/iio/adc/rockchip_saradc.c
> index 1fad964..e074a0b 100644
> --- a/drivers/iio/adc/rockchip_saradc.c
> +++ b/drivers/iio/adc/rockchip_saradc.c
> @@ -141,7 +141,6 @@ static int rockchip_saradc_probe(struct platform_device *pdev)
>  	struct resource	*mem;
>  	int ret;
>  	int irq;
> -	u32 rate;
>  
>  	if (!np)
>  		return -ENODEV;
> 
