From: balbi@ti.com (Felipe Balbi)
Date: Wed, 6 Mar 2013 00:22:24 +0200
Subject: [PATCH 4/9] usb: gadget: fix omap_udc build errors
In-Reply-To: <1362521809-22989-5-git-send-email-arnd@arndb.de>
References: <1362521809-22989-1-git-send-email-arnd@arndb.de>
 <1362521809-22989-5-git-send-email-arnd@arndb.de>
Message-ID: <20130305222224.GA26278@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Mar 05, 2013 at 11:16:44PM +0100, Arnd Bergmann wrote:
> 1bf0cf6040 "usb: gadget: omap_udc: convert to udc_start/udc_stop"
> made some trivial changes but was missing a ';' character.
> 
> 8c4cc00552 "ARM: OMAP1: DMA: Moving OMAP1 DMA channel definitions
> to mach-omap1" added a definition for OMAP_DMA_USB_W2FC_TX0 to
> the driver while making the header file it was defined in
> unavailable for drivers, but this driver actually needs
> OMAP_DMA_USB_W2FC_RX0 as well.
> 
> Both changes appear trivial, so let's add the missing semicolon
> and the macro definition.
> 
> Cc: Felipe Balbi <balbi@ti.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/usb/gadget/omap_udc.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/gadget/omap_udc.c b/drivers/usb/gadget/omap_udc.c
> index 06be85c..f844565 100644
> --- a/drivers/usb/gadget/omap_udc.c
> +++ b/drivers/usb/gadget/omap_udc.c
> @@ -62,6 +62,7 @@
>  #define	DRIVER_VERSION	"4 October 2004"
>  
>  #define OMAP_DMA_USB_W2FC_TX0		29
> +#define OMAP_DMA_USB_W2FC_RX0		26
>  
>  /*
>   * The OMAP UDC needs _very_ early endpoint setup:  before enabling the
> @@ -1310,7 +1311,7 @@ static int omap_pullup(struct usb_gadget *gadget, int is_on)
>  }
>  
>  static int omap_udc_start(struct usb_gadget *g,
> -		struct usb_gadget_driver *driver)
> +		struct usb_gadget_driver *driver);

good catch, thanks. I'll queue it for v3.6-rc3. Make sure to Cc
linux-usb for anything under drivers/usb/ though

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130306/773d75f5/attachment.sig>
