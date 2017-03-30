From: balbi@kernel.org (Felipe Balbi)
Date: Thu, 30 Mar 2017 13:39:43 +0300
Subject: [PATCH linux-next v2 3/4] usb: gadget: udc: atmel: Use dev_warn()
 to display EP configuration error
In-Reply-To: <676bd6d232af7ce08f2fb1f7e4188fc20ef751db.1490715349.git.cristian.birsan@microchip.com>
References: <cover.1490715349.git.cristian.birsan@microchip.com>
 <676bd6d232af7ce08f2fb1f7e4188fc20ef751db.1490715349.git.cristian.birsan@microchip.com>
Message-ID: <87d1czjbf4.fsf@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi,

cristian.birsan at microchip.com writes:
> From: Cristian Birsan <cristian.birsan@microchip.com>
>
> Use dev_warn() to display EP configuration error to avoid silent failure.
>
> Signed-off-by: Cristian Birsan <cristian.birsan@microchip.com>
> ---
>  drivers/usb/gadget/udc/atmel_usba_udc.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/usb/gadget/udc/atmel_usba_udc.c b/drivers/usb/gadget/udc/atmel_usba_udc.c
> index 2bd8410..942c9c9 100644
> --- a/drivers/usb/gadget/udc/atmel_usba_udc.c
> +++ b/drivers/usb/gadget/udc/atmel_usba_udc.c
> @@ -1851,7 +1851,7 @@ static irqreturn_t usba_udc_irq(int irq, void *devid)
>  		 * but it's clearly harmless...
>  		 */
>  		if (!(usba_ep_readl(ep0, CFG) & USBA_EPT_MAPPED))
> -			dev_dbg(&udc->pdev->dev,
> +			dev_warn(&udc->pdev->dev,

seems like dev_err() would've been more fitting.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 832 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170330/594f62d6/attachment.sig>
