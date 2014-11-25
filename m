From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 25 Nov 2014 21:57:07 +0100
Subject: [PATCH v2 2/8] irqchip: Supply new driver for STi based devices
In-Reply-To: <1416932705-16880-3-git-send-email-lee.jones@linaro.org>
References: <1416932705-16880-1-git-send-email-lee.jones@linaro.org>
 <1416932705-16880-3-git-send-email-lee.jones@linaro.org>
Message-ID: <2433040.4NqTrOMmEE@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 25 November 2014 16:24:59 Lee Jones wrote:

> diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
> index b21f12f..e502f15 100644
> --- a/drivers/irqchip/Kconfig
> +++ b/drivers/irqchip/Kconfig
> @@ -93,6 +93,13 @@ config RENESAS_IRQC
>  	bool
>  	select IRQ_DOMAIN
>  
> +config ST_IRQCHIP
> +	bool
> +	select REGMAP
> +	select MFD_SYSCON
> +	help
> +	  Enables SysCfg Controlled IRQs on STi based platforms.
> +

I'm confused by the purpose of this code. It's apparently a driver
in drivers/irqchip, the Kconfig symbol contains the string IRQCHIP,
yet it doesn't actually register an irq_chip.

Also, the name is a bit too generic, ST has lots of different irqchips,
and this apparently isn't even one of them ;-)

	Arnd
