From: kgene.kim@samsung.com (Kukjin Kim)
Date: Sat, 02 Oct 2010 19:40:31 +0900
Subject: [PATCH v3] ARM: S5PC110: add support for S6E63M0 LCD controller on
	Goni board
In-Reply-To: <1285679744-21621-1-git-send-email-m.szyprowski@samsung.com>
References: <005b01cb5ee0$2d266f90$87734eb0$%kim@samsung.com>
	<1285679744-21621-1-git-send-email-m.szyprowski@samsung.com>
Message-ID: <014801cb621e$3edd42e0$bc97c8a0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Marek Szyprowski wrote:
> 
> Add required platform definitions for S6E63M0 LCD controller on Samsung
> Goni board.
> 
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---
> 
> Changes since v2:
> - removed defines for lcd pin names
> 
>  arch/arm/mach-s5pv210/mach-goni.c |   66
> +++++++++++++++++++++++++++++++++++++
>  1 files changed, 66 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-s5pv210/mach-goni.c
b/arch/arm/mach-s5pv210/mach-
> goni.c
> index b0ae208..ac6ebab 100644
> --- a/arch/arm/mach-s5pv210/mach-goni.c
> +++ b/arch/arm/mach-s5pv210/mach-goni.c

(snip)

> +static struct lcd_platform_data s6e63m0_platform_data = {
> +	.reset			= reset_lcd,
> +	.power_on		= lcd_power_on,
> +	.lcd_enabled		= 0,
> +	.reset_delay		= 120,	/* 120ms */
> +	.power_on_delay		= 25,	/* 25ms */
> +	.power_off_delay	= 200,	/* 200ms */
> +};
> +
> +#define LCD_BUS_NUM	3
> +static struct spi_board_info spi_board_info[] __initdata = {
> +	{
> +		.modalias	= "s6e63m0",
> +		.platform_data	= &goni_lcd_platform_data,

Happened following build error.
arch/arm/mach-s5pv210/mach-goni.c:153: error: 'goni_lcd_platform_data'
undeclared here (not in a function)

should be 's6e63m0_platform_data'?..let me know your preferred name.
Will apply with changing it.

> +		.max_speed_hz	= 1200000,
> +		.bus_num	= LCD_BUS_NUM,
> +		.chip_select	= 0,
> +		.mode		= SPI_MODE_3,
> +		.controller_data = (void *)S5PV210_MP01(1), /* DISPLAY_CS */
> +	},
> +};

(snip)

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
