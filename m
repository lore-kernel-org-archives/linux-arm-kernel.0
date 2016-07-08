From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Fri, 8 Jul 2016 22:35:28 +0200
Subject: [PATCH v2 6/7] spi: s3c64xx: restore removed comments
In-Reply-To: <1467989201-14661-7-git-send-email-andi.shyti@samsung.com>
References: <1467989201-14661-1-git-send-email-andi.shyti@samsung.com>
 <1467989201-14661-7-git-send-email-andi.shyti@samsung.com>
Message-ID: <20160708203528.GA26626@kozik-lap>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 08, 2016 at 11:46:40PM +0900, Andi Shyti wrote:
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
>  	writel(val, regs + S3C64XX_SPI_MODE_CFG);
>  
>  	if (sdd->port_conf->clk_from_cmu) {
> +		/* There is half-multiplier before the SPI */
>  		clk_set_rate(sdd->src_clk, sdd->cur_speed * 2);
>  	} else {
>  		/* Configure Clock */

Regardless of possible followup after Michael's comments:

Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Best regards,
Krzysztof
