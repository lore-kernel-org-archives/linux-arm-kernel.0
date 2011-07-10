From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 10 Jul 2011 10:27:47 +0100
Subject: [PATCH 03/17] mach-realview: retire custom LED code
In-Reply-To: <1309955687-19365-4-git-send-email-bryan.wu@canonical.com>
References: <1309955687-19365-1-git-send-email-bryan.wu@canonical.com>
	<1309955687-19365-4-git-send-email-bryan.wu@canonical.com>
Message-ID: <20110710092747.GS4812@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 06, 2011 at 08:34:33PM +0800, Bryan Wu wrote:
> diff --git a/arch/arm/plat-versatile/Kconfig b/arch/arm/plat-versatile/Kconfig
> index 52353be..c600420 100644
> --- a/arch/arm/plat-versatile/Kconfig
> +++ b/arch/arm/plat-versatile/Kconfig
> @@ -7,8 +7,12 @@ config PLAT_VERSATILE_FPGA_IRQ
>  	bool
>  
>  config PLAT_VERSATILE_LEDS
> -	def_bool y if LEDS_CLASS
> +	def_bool y
>  	depends on ARCH_REALVIEW || ARCH_VERSATILE
> +	select NEW_LEDS
> +	select LEDS_CLASS
> +	select LEDS_TRIGGERS
> +	select LEDS_TRIGGER_CPU

Can you explain the choice to force LED support to be enabled with no
choice for these?
