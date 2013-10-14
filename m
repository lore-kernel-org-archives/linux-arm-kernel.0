From: balbi@ti.com (Felipe Balbi)
Date: Mon, 14 Oct 2013 17:49:23 -0500
Subject: [PATCH v2 1/3] usb: musb: Handle nullpointer
In-Reply-To: <1381758639-30300-2-git-send-email-mpa@pengutronix.de>
References: <1381758639-30300-1-git-send-email-mpa@pengutronix.de>
 <1381758639-30300-2-git-send-email-mpa@pengutronix.de>
Message-ID: <20131014224923.GB7446@radagast>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 14, 2013 at 03:50:37PM +0200, Markus Pargmann wrote:
> When the device is connected to a host without a gadget driver,
> otg->gadget is NULL.
> 
> Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
> ---
>  drivers/usb/musb/musb_core.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/musb/musb_core.c b/drivers/usb/musb/musb_core.c
> index 18e877f..baa4f6a 100644
> --- a/drivers/usb/musb/musb_core.c
> +++ b/drivers/usb/musb/musb_core.c
> @@ -654,7 +654,8 @@ static irqreturn_t musb_stage0_irq(struct musb *musb, u8 int_usb,
>  				break;
>  		case OTG_STATE_B_PERIPHERAL:

why would we be in B peripheral if we're host only ? Bug seems to be
else where.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131014/09b8e5b9/attachment.sig>
