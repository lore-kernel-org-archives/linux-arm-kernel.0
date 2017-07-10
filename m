From: michal.simek@xilinx.com (Michal Simek)
Date: Mon, 10 Jul 2017 08:32:55 +0200
Subject: [PATCH] usb: gadget: udc-xilinx: compress return logic into one
 line
In-Reply-To: <20170710030458.GA14639@embeddedgus>
References: <20170710030458.GA14639@embeddedgus>
Message-ID: <73e25e50-c65a-bd43-d51c-1291a9168cd2@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10.7.2017 05:04, Gustavo A. R. Silva wrote:
> Simplify return logic to avoid unnecessary variable assignment.
> 
> This issue was detected using Coccinelle and the following
> semantic patch:
> 
> @@
> local idexpression ret;
> expression e;
> @@
> 
> -ret =
> +return
>      e;
> -return ret;
> 
> Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>
> ---
>  drivers/usb/gadget/udc/udc-xilinx.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/usb/gadget/udc/udc-xilinx.c b/drivers/usb/gadget/udc/udc-xilinx.c
> index de207a9..552389d 100644
> --- a/drivers/usb/gadget/udc/udc-xilinx.c
> +++ b/drivers/usb/gadget/udc/udc-xilinx.c
> @@ -1217,14 +1217,13 @@ static const struct usb_ep_ops xusb_ep_ops = {
>  static int xudc_get_frame(struct usb_gadget *gadget)
>  {
>  	struct xusb_udc *udc;
> -	int frame;
>  
>  	if (!gadget)
>  		return -ENODEV;
>  
>  	udc = to_udc(gadget);
> -	frame = udc->read_fn(udc->addr + XUSB_FRAMENUM_OFFSET);
> -	return frame;
> +
> +	return udc->read_fn(udc->addr + XUSB_FRAMENUM_OFFSET);
>  }
>  
>  /**
> 

Acked-by: Michal Simek <michal.simek@xilinx.com>

Thanks,
Michal
