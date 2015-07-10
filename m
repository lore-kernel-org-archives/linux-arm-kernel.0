From: HartleyS@visionengravers.com (Hartley Sweeten)
Date: Fri, 10 Jul 2015 16:11:01 +0000
Subject: [PATCH] ARM: ep93xx: simone: enable DMA on the SPI host
In-Reply-To: <1436517557-11725-1-git-send-email-linus.walleij@linaro.org>
References: <1436517557-11725-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <DC148C5AA1CEBA4E87973D432B1C2D883D4DAFD6@P3PWEX4MB008.ex4.secureserver.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday, July 10, 2015 1:39 AM, Linus Walleij wrote:
> The SPI host on the SIM.ONE is used for the MMC/SD card and
> will badly need this turbo boost.
>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  arch/arm/mach-ep93xx/simone.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm/mach-ep93xx/simone.c b/arch/arm/mach-ep93xx/simone.c
> index 3c950f5864f3..d0938a219443 100644
> --- a/arch/arm/mach-ep93xx/simone.c
> +++ b/arch/arm/mach-ep93xx/simone.c
> @@ -169,6 +169,7 @@ static struct spi_board_info simone_spi_devices[] __initdata = {
>  
>  static struct ep93xx_spi_info simone_spi_info __initdata = {
>  	.num_chipselect	= ARRAY_SIZE(simone_spi_devices),
> +	.use_dma = 1,
>  };
>  
>  static struct i2c_gpio_platform_data __initdata simone_i2c_gpio_data = {

Reviewed-by: H Hartley Sweeten <hsweeten@visionengravers.com>
