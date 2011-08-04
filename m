From: amit.kucheria@canonical.com (Amit Kucheria)
Date: Thu, 4 Aug 2011 17:19:27 +0100
Subject: [PATCH] ARM: mx5: board-cpuimx51.c fixup irq_to_gpio() usage
In-Reply-To: <1312472855-15778-1-git-send-email-ben-linux@fluff.org>
Message-ID: <20110804161927.GD8408@avalanche>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11 Aug 04, Ben Dooks wrote:
> irq_to_gpio() is being called on a GPIO so change to using
> gpio_to_irq() instead.
> 
> Signed-off-by: Ben Dooks <ben-linux@fluff.org>

cc'ing board maintainer.

Acked-by: Amit Kucheria <amit.kucheria@canonical.com>


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

-- 
----------------------------------------------------------------------
Amit Kucheria, Kernel Engineer || amit.kucheria at canonical.com
----------------------------------------------------------------------
