From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Tue, 20 Nov 2018 09:40:16 +0100
Subject: [RFC PATCH v2 01/14] ARM: add CONFIG_ARCH_SUNXI_V7 for
 differentiate ARMv5/v7 Allwinner SoCs
In-Reply-To: <abbb75165c8ef41da6963d72f4155ad6ae79140c.1542546735.git.mesihkilinc@gmail.com>
References: <cover.1542546735.git.mesihkilinc@gmail.com>
 <abbb75165c8ef41da6963d72f4155ad6ae79140c.1542546735.git.mesihkilinc@gmail.com>
Message-ID: <20181120084016.nrvpylj64ok3d5ch@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Sun, Nov 18, 2018 at 05:17:00PM +0300, Mesih Kilinc wrote:
> Allwinner also has some ARMv5 SoCs.
> 
> In order to add support for them, add a CONFIG_ARCH_SUNXI_V7 bool config
> which is selected when a ARMv7 soc is selected, and make CONFIG_ARCH_SUNXI
> a common option which is selected by both V7 and V5 sunxi option.
> 
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> Signed-off-by: Mesih Kilinc <mesihkilinc@gmail.com>

I'm not sure why Icenowy has her SoB here?

> ---
>  arch/arm/mach-sunxi/Kconfig  | 25 +++++++++++++++++--------
>  arch/arm/mach-sunxi/Makefile |  2 +-
>  2 files changed, 18 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/arm/mach-sunxi/Kconfig b/arch/arm/mach-sunxi/Kconfig
> index d9c8ecf..5db17ec 100644
> --- a/arch/arm/mach-sunxi/Kconfig
> +++ b/arch/arm/mach-sunxi/Kconfig
> @@ -6,31 +6,38 @@ menuconfig ARCH_SUNXI
>  	select GENERIC_IRQ_CHIP
>  	select GPIOLIB
>  	select PINCTRL
> -	select PM_OPP
> -	select SUN4I_TIMER
>  	select RESET_CONTROLLER
> +	help
> +	  Support for Allwinner ARM-based family of processors
>  
>  if ARCH_SUNXI
>  
> +if ARCH_MULTI_V7
> +
> +config ARCH_SUNXI_V7
> +	bool
> +	select PM_OPP
> +	select SUN4I_TIMER
> +
>  config MACH_SUN4I
>  	bool "Allwinner A10 (sun4i) SoCs support"
> -	default ARCH_SUNXI
> +	select ARCH_SUNXI_V7

It changes the behaviour a bit. It used to be enabled by default, it
doesn't anymore.

Maxime

-- 
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 228 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181120/c4cd052e/attachment-0001.sig>
