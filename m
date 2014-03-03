From: lee.jones@linaro.org (Lee Jones)
Date: Mon, 3 Mar 2014 15:36:39 +0800
Subject: [PATCH 2/4] mfd: mc13xxx: Limit maximum SPI speed
In-Reply-To: <1393746275-9253-2-git-send-email-shc_work@mail.ru>
References: <1393746275-9253-1-git-send-email-shc_work@mail.ru>
 <1393746275-9253-2-git-send-email-shc_work@mail.ru>
Message-ID: <20140303073639.GE4674@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> The patch adds the maximum speed limit in accordance with the
> PMIC datasheet if other value is not given in the devicetree
> description or board data.
> 
> Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
> ---
>  drivers/mfd/mc13xxx-spi.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/mfd/mc13xxx-spi.c b/drivers/mfd/mc13xxx-spi.c
> index f88087f..cd27c32 100644
> --- a/drivers/mfd/mc13xxx-spi.c
> +++ b/drivers/mfd/mc13xxx-spi.c
> @@ -138,6 +138,8 @@ static int mc13xxx_spi_probe(struct spi_device *spi)
>  
>  	mc13xxx->irq = spi->irq;
>  
> +	spi->max_speed_hz = spi->max_speed_hz ? : 26000000;
> +
>  	mc13xxx->regmap = devm_regmap_init(&spi->dev, &regmap_mc13xxx_bus,
>  					   &spi->dev,
>  					   &mc13xxx_regmap_spi_config);

Applied, thanks.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
