From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 28 Jan 2010 22:08:35 +0000
Subject: [PATCH 01/06] ARM: SuperH Mobile ARM, sh7367 and G3EVM support
In-Reply-To: <20100128124038.8982.82995.sendpatchset@rxone.opensource.se>
References: <20100128124028.8982.16123.sendpatchset@rxone.opensource.se>
	<20100128124038.8982.82995.sendpatchset@rxone.opensource.se>
Message-ID: <20100128220835.GA23471@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 28, 2010 at 09:40:38PM +0900, Magnus Damm wrote:
> --- 0001/arch/arm/Kconfig
> +++ work/arch/arm/Kconfig	2010-01-20 18:59:55.000000000 +0900
> @@ -740,6 +740,11 @@ config ARCH_U8500
>  	help
>  	  Support for ST-Ericsson's Ux500 architecture
>  
> +config ARCH_SHMOBILE
> +	bool "Renesas SH-Mobile"
> +	help
> +	  Support for Renesas's SH-Mobile ARM platforms
> +

The entries in this choice menu are sorted by option text - please
place your new option appropriately to avoid conflicts.

>  endchoice
>  
>  source "arch/arm/mach-aaec2000/Kconfig"
> @@ -851,6 +856,8 @@ source "arch/arm/mach-versatile/Kconfig"
>  
>  source "arch/arm/mach-w90x900/Kconfig"
>  
> +source "arch/arm/mach-shmobile/Kconfig"

Ditto, except ordered alphabetically by filename.

> +static struct sh_timer_config cmt10_platform_data = {
> +	.name = "CMT10",
> +	.channel_offset = 0x10,
> +	.timer_bit = 0,
> +	.clk = "r_clk",

I guess you can't do a lot about this because of arch/sh, but over in ARM
land, we use clkdev to get the clock primerily by the device name rather
than a string passed around; this is how the clk API is meant to be used.
