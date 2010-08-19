From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Thu, 19 Aug 2010 14:48:11 +0400
Subject: [PATCH 1/2] mx35_3ds: add physmap-flash NOR at CS0
In-Reply-To: <1282146406-2901-2-git-send-email-m.grzeschik@pengutronix.de>
References: <1282146406-2901-1-git-send-email-m.grzeschik@pengutronix.de>
	<1282146406-2901-2-git-send-email-m.grzeschik@pengutronix.de>
Message-ID: <4C6D0BEB.7080002@ru.mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

Michael Grzeschik wrote:

> From: Marc Kleine-Budde <mkl@pengutronix.de>

> The mx35_3ds comes with 64 MiByte for NOR flash at CS0, add physmap-flash
> platform device for it.

> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>

[...]

> diff --git a/arch/arm/mach-mx3/mach-mx35_3ds.c b/arch/arm/mach-mx3/mach-mx35_3ds.c
> index 1c30d72..73149b8 100644
> --- a/arch/arm/mach-mx3/mach-mx35_3ds.c
> +++ b/arch/arm/mach-mx3/mach-mx35_3ds.c
[...]
> @@ -43,8 +46,29 @@ static const struct imxuart_platform_data uart_pdata __initconst = {
>  	.flags = IMXUART_HAVE_RTSCTS,
>  };
>  
> +static struct physmap_flash_data mx35pdk_flash_data = {
> +	.width  = 2,
> +};
> +
> +static struct resource mx35pdk_flash_resource = {
> +	.start	= MX35_CS0_BASE_ADDR,
> +	.end	= MX35_CS0_BASE_ADDR + SZ_64M - 1,
> +	.flags	= IORESOURCE_MEM,
> +};
> +
> +static struct platform_device mx35pdk_flash = {
> +	.name	= "physmap-flash",
> +	.id	= 0,

    -1 perhaps as that is probably a single physmap devie on your board?

WBR, Sergei
