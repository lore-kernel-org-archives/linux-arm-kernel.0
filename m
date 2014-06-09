From: jason@lakedaemon.net (Jason Cooper)
Date: Mon, 9 Jun 2014 08:03:42 -0400
Subject: [PATCH] usb: ehci_orion should be builable for mvebu multi
 platform
In-Reply-To: <1402260237-15296-1-git-send-email-pbrobinson@gmail.com>
References: <1402260237-15296-1-git-send-email-pbrobinson@gmail.com>
Message-ID: <20140609120342.GO8664@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Peter,

Please amend your subject line to match the other commits in
drivers/usb.  Also, s/builable/buildable/

On Sun, Jun 08, 2014 at 09:43:57PM +0100, Peter Robinson wrote:
> The ehci_orion is used by numerous mvebu SoCs and not just Orion
> so enable it so it can be built as part of the mvebu multi platform
> as it's used by Dove, Armada XP, Armada 370 too.
> 
> Tested on Mirabox booting of the usb attached MMC slot
> 
> Signed-off-by: Peter Robinson <pbrobinson@gmail.com>
> ---
>  drivers/usb/host/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/host/Kconfig b/drivers/usb/host/Kconfig
> index 3d9e540..c0f8900 100644
> --- a/drivers/usb/host/Kconfig
> +++ b/drivers/usb/host/Kconfig
> @@ -141,7 +141,7 @@ config USB_EHCI_HCD_OMAP
>  
>  config USB_EHCI_HCD_ORION
>  	tristate  "Support for Marvell EBU on-chip EHCI USB controller"
> -	depends on USB_EHCI_HCD && PLAT_ORION
> +	depends on USB_EHCI_HCD && ( PLAT_ORION || ARCH_MVEBU )

hmmm, ARCH_MVEBU selects PLAT_ORION in mach-mvebu/Kconfig:8 over here.
What are you trying to fix?

thx,

Jason.

>  	default y
>  	---help---
>  	  Enables support for the on-chip EHCI controller on Marvell's
> -- 
> 2.0.0
> 
