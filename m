From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 3 Jun 2016 12:27:21 +0100
Subject: [PATCH v2 4/9] arm64: Add platform selection for BCM2835.
In-Reply-To: <1464934708-24769-5-git-send-email-kraxel@redhat.com>
References: <1464934708-24769-1-git-send-email-kraxel@redhat.com>
 <1464934708-24769-5-git-send-email-kraxel@redhat.com>
Message-ID: <20160603112721.GC1128@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 03, 2016 at 08:18:23AM +0200, Gerd Hoffmann wrote:
> diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
> index 7ef1d05..ea88402 100644
> --- a/arch/arm64/Kconfig.platforms
> +++ b/arch/arm64/Kconfig.platforms
> @@ -13,6 +13,19 @@ config ARCH_ALPINE
>  	  This enables support for the Annapurna Labs Alpine
>  	  Soc family.
>  
> +config ARCH_BCM2835
> +	bool "Broadcom BCM2835 family"
> +	select ARCH_REQUIRE_GPIOLIB
> +	select CLKSRC_OF
> +	select PINCTRL
> +	select PINCTRL_BCM2835
> +	select ARM_AMBA
> +	select ARM_TIMER_SP804
> +	select HAVE_ARM_ARCH_TIMER
> +	help
> +	  This enables support for the Broadcom BCM2837 SoC.
> +	  This SoC is used in the Raspberry Pi 3 device.

I thought we would just use ARCH_BCM, or is it too generic?

-- 
Catalin
