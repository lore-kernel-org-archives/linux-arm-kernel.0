From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 10 Jan 2013 23:17:00 +0800
Subject: [PATCHv2] ARM: mxs: select USB_ARCH_HAS_EHCI
In-Reply-To: <1357830235-15661-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1357830235-15661-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <20130110151659.GB9139@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 10, 2013 at 04:03:55PM +0100, Maxime Ripard wrote:
> Commit 09f6ffde introduced a dependency on USB_EHCI_HCD for the chipidea
> USB host driver, that in turns depends on USB_ARCH_HAS_EHCI.
> 
> If this symbol is not selected by the ARCH, we are not able to use the
> chipidea driver anymore.
> 
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> ---
>  drivers/usb/Kconfig |    1 +
>  1 file changed, 1 insertion(+)

Now, it should go via usb rather than arm-soc tree.

Shawn

> 
> diff --git a/drivers/usb/Kconfig b/drivers/usb/Kconfig
> index 4c90b51..640ae6c 100644
> --- a/drivers/usb/Kconfig
> +++ b/drivers/usb/Kconfig
> @@ -37,6 +37,7 @@ config USB_ARCH_HAS_EHCI
>  	default y if ARCH_W90X900
>  	default y if ARCH_AT91
>  	default y if ARCH_MXC
> +	default y if ARCH_MXS
>  	default y if ARCH_OMAP3
>  	default y if ARCH_CNS3XXX
>  	default y if ARCH_VT8500
> -- 
> 1.7.10.4
> 
