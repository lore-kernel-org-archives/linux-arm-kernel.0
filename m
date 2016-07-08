From: mturquette@baylibre.com (Michael Turquette)
Date: Fri, 08 Jul 2016 09:17:28 -0700
Subject: [PATCH v2 6/7] spi: s3c64xx: restore removed comments
In-Reply-To: <1467989201-14661-7-git-send-email-andi.shyti@samsung.com>
References: <1467989201-14661-1-git-send-email-andi.shyti@samsung.com>
 <1467989201-14661-7-git-send-email-andi.shyti@samsung.com>
Message-ID: <146799464881.73491.7507792367941552864@resonance>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Andi Shyti (2016-07-08 07:46:40)
> Patch a9e93e8 has erroneously removed some comments which are
> important to understand why the bus frequency is multiplied by
> two during the spi transfer.
> 
> Signed-off-by: Andi Shyti <andi.shyti@samsung.com>
> ---
>  drivers/spi/spi-s3c64xx.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
> index 6da663f..32b66f0 100644
> --- a/drivers/spi/spi-s3c64xx.c
> +++ b/drivers/spi/spi-s3c64xx.c
> @@ -639,6 +639,7 @@ static void s3c64xx_spi_config(struct s3c64xx_spi_driver_data *sdd)
>         writel(val, regs + S3C64XX_SPI_MODE_CFG);
>  
>         if (sdd->port_conf->clk_from_cmu) {
> +               /* There is half-multiplier before the SPI */
>                 clk_set_rate(sdd->src_clk, sdd->cur_speed * 2);

Just a small comment, but if the fixed-factor divide-by-two clock was
modeled in Linux, then this driver could call clk_set_rate on that clock
with the "correct" rate.

I guess that this driver would be the provider of that clock?

Regards,
Mike

>         } else {
>                 /* Configure Clock */
> -- 
> 2.8.1
> 
