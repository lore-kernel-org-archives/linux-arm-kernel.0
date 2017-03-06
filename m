From: balbi@kernel.org (Felipe Balbi)
Date: Mon, 06 Mar 2017 17:06:11 +0200
Subject: [PATCH 1/4 linux-next] usb: gadget: udc: atmel: Check fifo
 configuration values against device tree
In-Reply-To: <f71b15dfe79e227491aced411af203297e746603.1487007870.git.cristian.birsan@microchip.com>
References: <cover.1487007870.git.cristian.birsan@microchip.com>
 <f71b15dfe79e227491aced411af203297e746603.1487007870.git.cristian.birsan@microchip.com>
Message-ID: <87varm1m3g.fsf@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

cristian.birsan at microchip.com writes:

> From: Cristian Birsan <cristian.birsan@microchip.com>
>
> Check fifo configuration values against device tree values for endpoint
> fifo in auto configuration mode (fifo_mode=0).
>
> Signed-off-by: Cristian Birsan <cristian.birsan@microchip.com>
> ---
>  drivers/usb/gadget/udc/atmel_usba_udc.c | 26 +++++++++++++++++++++++---
>  1 file changed, 23 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/usb/gadget/udc/atmel_usba_udc.c b/drivers/usb/gadget/udc/atmel_usba_udc.c
> index 11bbce2..ce8bf8b 100644
> --- a/drivers/usb/gadget/udc/atmel_usba_udc.c
> +++ b/drivers/usb/gadget/udc/atmel_usba_udc.c
> @@ -371,7 +371,7 @@ static struct usba_fifo_cfg mode_4_cfg[] = {
>  };
>  /* Add additional configurations here */
>  
> -int usba_config_fifo_table(struct usba_udc *udc)
> +static int usba_config_fifo_table(struct usba_udc *udc)

this is not part of $subject. Should be a separate patch. Please fix.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 832 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170306/f076d9b7/attachment.sig>
