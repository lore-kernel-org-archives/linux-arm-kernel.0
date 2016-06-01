From: f.fainelli@gmail.com (Florian Fainelli)
Date: Wed, 1 Jun 2016 14:49:53 -0700
Subject: [PATCH 01/32] arm64: Add platform selection for BCM2835.
In-Reply-To: <1464817421-8519-2-git-send-email-kraxel@redhat.com>
References: <1464817421-8519-1-git-send-email-kraxel@redhat.com>
 <1464817421-8519-2-git-send-email-kraxel@redhat.com>
Message-ID: <574F5881.4060008@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/01/2016 02:43 PM, Gerd Hoffmann wrote:
> From: Eric Anholt <eric@anholt.net>
> 
> Signed-off-by: Eric Anholt <eric@anholt.net>
> 
> [ kraxel: copy some selects from arm to arm64 ]
> [ kraxel: add CONFIG_ARCH_BCM, needed for some "depends on ARCH_BCM" ]
> 
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  arch/arm/mach-bcm/Kconfig    |  2 +-
>  arch/arm64/Kconfig.platforms | 20 ++++++++++++++++++++
>  2 files changed, 21 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-bcm/Kconfig b/arch/arm/mach-bcm/Kconfig
> index 68ab641..21f0e43 100644
> --- a/arch/arm/mach-bcm/Kconfig
> +++ b/arch/arm/mach-bcm/Kconfig
> @@ -136,7 +136,7 @@ comment "Other Architectures"
>  
>  config ARCH_BCM2835
>  	bool "Broadcom BCM2835 family"
> -	depends on ARCH_MULTI_V6 || ARCH_MULTI_V7
> +	depends on ARCH_MULTI_V6 || ARCH_MULTI_V7 || ARM64

Humm, what does that achieve?

>  	select ARCH_REQUIRE_GPIOLIB
>  	select ARM_AMBA
>  	select ARM_ERRATA_411920 if ARCH_MULTI_V6
> diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
> index 7ef1d05..32aba6b 100644
> --- a/arch/arm64/Kconfig.platforms
> +++ b/arch/arm64/Kconfig.platforms
> @@ -13,8 +13,28 @@ config ARCH_ALPINE
>  	  This enables support for the Annapurna Labs Alpine
>  	  Soc family.
>  
> +config ARCH_BCM
> +	bool "Broadcom SoC Support"
> +	help
> +	  This enables support for Broadcom ARM based SoC chips

menuconfig maybe?

> +
> +config ARCH_BCM2835
> +	bool "Broadcom BCM2835 family"
> +	depends on ARCH_BCM
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
> +
>  config ARCH_BCM_IPROC
>  	bool "Broadcom iProc SoC Family"
> +	depends on ARCH_BCM

Does not seem necessary nor adding anything here.
-- 
Florian
