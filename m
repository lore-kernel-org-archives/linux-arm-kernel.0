From: andrew@aj.id.au (Andrew Jeffery)
Date: Thu, 08 Nov 2018 11:05:16 +1030
Subject: [PATCH] usb: gadget: aspeed-vhub: constify usb_gadget_ops
 structure
In-Reply-To: <1540916399-22426-1-git-send-email-Julia.Lawall@lip6.fr>
References: <1540916399-22426-1-git-send-email-Julia.Lawall@lip6.fr>
Message-ID: <1541637316.1471870.1569457840.5A56DC54@webmail.messagingengine.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 31 Oct 2018, at 02:49, Julia Lawall wrote:
> The usb_gadget_ops structure can be const as it is only stored in
> the ops field of a usb_gadget structure and this field is const.
> 
> Done with the help of Coccinelle.
> 
> Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

Reviewed-by: Andrew Jeffery <andrew@aj.id.au>

> 
> ---
>  drivers/usb/gadget/udc/aspeed-vhub/dev.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/gadget/udc/aspeed-vhub/dev.c b/drivers/usb/
> gadget/udc/aspeed-vhub/dev.c
> index f0233912bace..6b1b16b17d7d 100644
> --- a/drivers/usb/gadget/udc/aspeed-vhub/dev.c
> +++ b/drivers/usb/gadget/udc/aspeed-vhub/dev.c
> @@ -438,7 +438,7 @@ static int ast_vhub_udc_stop(struct usb_gadget 
> *gadget)
>  	return 0;
>  }
>  
> -static struct usb_gadget_ops ast_vhub_udc_ops = {
> +static const struct usb_gadget_ops ast_vhub_udc_ops = {
>  	.get_frame	= ast_vhub_udc_get_frame,
>  	.wakeup		= ast_vhub_udc_wakeup,
>  	.pullup		= ast_vhub_udc_pullup,
> 
