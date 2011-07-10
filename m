From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 10 Jul 2011 10:30:07 +0100
Subject: [PATCH 06/17] mach-shark: retire custom LED code
In-Reply-To: <1309955687-19365-7-git-send-email-bryan.wu@canonical.com>
References: <1309955687-19365-1-git-send-email-bryan.wu@canonical.com>
	<1309955687-19365-7-git-send-email-bryan.wu@canonical.com>
Message-ID: <20110710093007.GU4812@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 06, 2011 at 08:34:36PM +0800, Bryan Wu wrote:
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 9adc278..df971c7 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -783,6 +783,12 @@ config ARCH_SHARK
>  	select ZONE_DMA
>  	select PCI
>  	select ARCH_USES_GETTIMEOFFSET
> +	select NEW_LEDS
> +	select LEDS_CLASS
> +	select LEDS_TRIGGERS
> +	select LEDS_TRIGGER_CPU
> +	select LEDS_TRIGGER_HEARTBEAT
> +	select LEDS_TRIGGER_DEFAULT_ON

So Shark too gets forced to have LED support no matter what.  Can we
please stop this madness.
