From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Fri, 5 Aug 2011 09:04:59 +0200
Subject: [PATCH] ARM: mx5: board-cpuimx51.c fixup irq_to_gpio() usage
In-Reply-To: <1312472855-15778-1-git-send-email-ben-linux@fluff.org>
References: <1312472855-15778-1-git-send-email-ben-linux@fluff.org>
Message-ID: <20110805070459.GB17990@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 04, 2011 at 04:47:35PM +0100, Ben Dooks wrote:
> irq_to_gpio() is being called on a GPIO so change to using
> gpio_to_irq() instead.
> 
> Signed-off-by: Ben Dooks <ben-linux@fluff.org>

Applied, thanks

Sascha

> ---
>  arch/arm/mach-mx5/board-cpuimx51.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/mach-mx5/board-cpuimx51.c b/arch/arm/mach-mx5/board-cpuimx51.c
> index 7c893fa..68934ea 100644
> --- a/arch/arm/mach-mx5/board-cpuimx51.c
> +++ b/arch/arm/mach-mx5/board-cpuimx51.c
> @@ -81,7 +81,7 @@ static struct plat_serial8250_port serial_platform_data[] = {
>  		.flags = UPF_BOOT_AUTOCONF | UPF_SKIP_TEST | UPF_IOREMAP,
>  	}, {
>  		.mapbase = (unsigned long)(MX51_CS1_BASE_ADDR + 0x2000000),
> -		.irq = irq_to_gpio(CPUIMX51_QUARTD_GPIO),
> +		.irq = gpio_to_irq(CPUIMX51_QUARTD_GPIO),
>  		.irqflags = IRQF_TRIGGER_HIGH,
>  		.uartclk = CPUIMX51_QUART_XTAL,
>  		.regshift = CPUIMX51_QUART_REGSHIFT,
> -- 
> 1.7.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
