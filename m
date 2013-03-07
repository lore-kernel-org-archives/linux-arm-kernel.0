From: balbi@ti.com (Felipe Balbi)
Date: Thu, 7 Mar 2013 09:34:34 +0200
Subject: [PATCH] ARM: OMAP1: fix omap_udc registration
In-Reply-To: <1362608605-26611-1-git-send-email-aaro.koskinen@iki.fi>
References: <1362608605-26611-1-git-send-email-aaro.koskinen@iki.fi>
Message-ID: <20130307073434.GB9171@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 07, 2013 at 12:23:25AM +0200, Aaro Koskinen wrote:
> omap_udc platform device is not registered properly anymore:
> CONFIG_USB_GADGET_OMAP was deleted by 193ab2a6 (usb: gadget: allow
> multiple gadgets to be built) already in v3.1.
> 
> Fix by using CONFIG_USB_OMAP instead. Tested on Nokia 770 by checking
> that omap_udc is probed & working properly when built as a module.
> 
> Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
> ---
>  arch/arm/mach-omap1/include/mach/usb.h |    2 +-
>  arch/arm/mach-omap1/usb.c              |    6 +++---
>  2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/mach-omap1/include/mach/usb.h b/arch/arm/mach-omap1/include/mach/usb.h
> index 753cd5c..8b2150e 100644
> --- a/arch/arm/mach-omap1/include/mach/usb.h
> +++ b/arch/arm/mach-omap1/include/mach/usb.h
> @@ -2,7 +2,7 @@
>   * FIXME correct answer depends on hmc_mode,
>   * as does (on omap1) any nonzero value for config->otg port number
>   */
> -#ifdef	CONFIG_USB_GADGET_OMAP
> +#if defined(CONFIG_USB_OMAP) || defined(CONFIG_USB_OMAP_MODULE)

could use IS_ENABLED()

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130307/928db90a/attachment.sig>
