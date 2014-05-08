From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 8 May 2014 09:21:02 -0500
Subject: [PATCH] pinctrl: sunxi Ensure the correct pinctrl drivers are
 enabled
In-Reply-To: <1399556216-7590-1-git-send-email-hdegoede@redhat.com>
References: <1399556216-7590-1-git-send-email-hdegoede@redhat.com>
Message-ID: <20140508142101.GT7047@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Hans,

On Thu, May 08, 2014 at 03:36:56PM +0200, Hans de Goede wrote:
> The commit titled: "pinctrl: sunxi: Introduce per-driver Kconfig options"
> adds a bunch of new Kconfig options, but nothing sets them resulting in a
> non working kernel. Since they are per sunxi family, and we already have
> sunxi family Kconfig options, make those options select the necessary
> Kconfig options.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  arch/arm/mach-sunxi/Kconfig | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-sunxi/Kconfig b/arch/arm/mach-sunxi/Kconfig
> index 3aff966..beab32e 100644
> --- a/arch/arm/mach-sunxi/Kconfig
> +++ b/arch/arm/mach-sunxi/Kconfig
> @@ -4,7 +4,6 @@ menuconfig ARCH_SUNXI
>  	select CLKSRC_MMIO
>  	select GENERIC_IRQ_CHIP
>  	select PINCTRL
> -	select PINCTRL_SUNXI
>  	select SUN4I_TIMER
>  
>  if ARCH_SUNXI
> @@ -12,11 +11,14 @@ if ARCH_SUNXI
>  config MACH_SUN4I
>  	bool "Allwinner A10 (sun4i) SoCs support"
>  	default ARCH_SUNXI
> +	select PINCTRL_SUN4I_A10
>  
>  config MACH_SUN5I
>  	bool "Allwinner A10s / A13 (sun5i) SoCs support"
>  	default ARCH_SUNXI
>  	select SUN5I_HSTIMER
> +	select PINCTRL_SUN5I_A10S
> +	select PINCTRL_SUN5I_A13
>  
>  config MACH_SUN6I
>  	bool "Allwinner A31 (sun6i) SoCs support"
> @@ -25,6 +27,7 @@ config MACH_SUN6I
>  	select ARM_GIC
>  	select RESET_CONTROLLER
>  	select SUN5I_HSTIMER
> +	select PINCTRL_SUN6I_A31
>  
>  config MACH_SUN7I
>  	bool "Allwinner A20 (sun7i) SoCs support"
> @@ -33,5 +36,6 @@ config MACH_SUN7I
>  	select ARM_PSCI
>  	select HAVE_ARM_ARCH_TIMER
>  	select SUN5I_HSTIMER
> +	select PINCTRL_SUN7I_A20
>  
>  endif

I already posted a similar patch that is still pending. I was only
waiting for Linus to merge the branch I gave him to merge it in my
tree.

http://lists.infradead.org/pipermail/linux-arm-kernel/2014-April/251704.html

I don't think he actually merged the branch yet. How did you
encounter such breakage?

Thanks,
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140508/3920d05f/attachment.sig>
