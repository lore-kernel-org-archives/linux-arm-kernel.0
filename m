From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 10 Jan 2013 11:48:06 +0800
Subject: [PATCH] ARM: mxs: select USB_ARCH_HAS_EHCI
In-Reply-To: <1357742162-27982-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1357742162-27982-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <20130110034805.GF2265@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 09, 2013 at 03:36:02PM +0100, Maxime Ripard wrote:
> Commit 09f6ffde introduced a dependency on USB_EHCI_HCD for the chipidea
> USB host driver, that in turns depends on USB_ARCH_HAS_EHCI.
> 
> If this symbol is not selected by the ARCH, we are not able to use the
> chipidea driver anymore.
> 
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> ---
>  arch/arm/Kconfig |    1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index f95ba14..c77d1d1 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -456,6 +456,7 @@ config ARCH_MXS
>  	select PINCTRL
>  	select SPARSE_IRQ
>  	select USE_OF
> +	select USB_ARCH_HAS_EHCI
>  	help
>  	  Support for Freescale MXS-based family of processors
>  

I prefer to fix it with the patch below.

Shawn

diff --git a/drivers/usb/Kconfig b/drivers/usb/Kconfig
index 4c90b51..640ae6c 100644
--- a/drivers/usb/Kconfig
+++ b/drivers/usb/Kconfig
@@ -37,6 +37,7 @@ config USB_ARCH_HAS_EHCI
        default y if ARCH_W90X900
        default y if ARCH_AT91
        default y if ARCH_MXC
+       default y if ARCH_MXS
        default y if ARCH_OMAP3
        default y if ARCH_CNS3XXX
        default y if ARCH_VT8500
