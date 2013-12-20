From: balbi@ti.com (Felipe Balbi)
Date: Fri, 20 Dec 2013 09:49:58 -0600
Subject: [PATCH] usb: musb: Remove USB_GADGET driver dependency
In-Reply-To: <1387502448-11041-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1387502448-11041-1-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <20131220154958.GA5957@saruman.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 19, 2013 at 10:20:48PM -0300, Ezequiel Garcia wrote:
> This USB controller is dual-role, but can also work in host-only mode.
> There's no reason to condition the entire driver to USB_GADGET. Fix this by
> removing the dependency.
> 
> Tested on a Beaglebone black (AM335x) using a regular USB mass storage
> device.
> 
> Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
> ---
>  drivers/usb/musb/Kconfig | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/usb/musb/Kconfig b/drivers/usb/musb/Kconfig
> index 57dfc0c..2119370 100644
> --- a/drivers/usb/musb/Kconfig
> +++ b/drivers/usb/musb/Kconfig
> @@ -6,7 +6,6 @@
>  # (M)HDRC = (Multipoint) Highspeed Dual-Role Controller
>  config USB_MUSB_HDRC
>  	tristate 'Inventra Highspeed Dual Role Controller (TI, ADI, ...)'
> -	depends on USB_GADGET

the correct patch would be to turn this into (USB || USB_GADGET) and fix
the mode selection just like dwc3 is doing.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131220/cb68bbdc/attachment.sig>
