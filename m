From: andrew@aj.id.au (Andrew Jeffery)
Date: Thu, 08 Nov 2018 12:25:22 +1030
Subject: [PATCH] usb: gadget: fix spelling mistakeis "[En]queing" ->
 "[En]queuing"
In-Reply-To: <20180929114313.10557-1-colin.king@canonical.com>
References: <20180929114313.10557-1-colin.king@canonical.com>
Message-ID: <1541642122.1498358.1569514624.6EA70C69@webmail.messagingengine.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 29 Sep 2018, at 22:13, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Trivial fix to spelling mistakes in debug warning messages
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Reviewed-by: Andrew Jeffery <andrew@aj.id.au>

> ---
>  drivers/usb/gadget/udc/aspeed-vhub/epn.c | 2 +-
>  drivers/usb/gadget/udc/udc-xilinx.c      | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/gadget/udc/aspeed-vhub/epn.c b/drivers/usb/
> gadget/udc/aspeed-vhub/epn.c
> index 5939eb1e97f2..e9ee2b72af19 100644
> --- a/drivers/usb/gadget/udc/aspeed-vhub/epn.c
> +++ b/drivers/usb/gadget/udc/aspeed-vhub/epn.c
> @@ -353,7 +353,7 @@ static int ast_vhub_epn_queue(struct usb_ep* u_ep, 
> struct usb_request *u_req,
>  	/* Endpoint enabled ? */
>  	if (!ep->epn.enabled || !u_ep->desc || !ep->dev || !ep->d_idx ||
>  	    !ep->dev->enabled || ep->dev->suspended) {
> -		EPDBG(ep,"Enqueing request on wrong or disabled EP\n");
> +		EPDBG(ep, "Enqueuing request on wrong or disabled EP\n");
>  		return -ESHUTDOWN;
>  	}
>  
> diff --git a/drivers/usb/gadget/udc/udc-xilinx.c b/drivers/usb/gadget/
> udc/udc-xilinx.c
> index 6407e433bc78..b1f4104d1283 100644
> --- a/drivers/usb/gadget/udc/udc-xilinx.c
> +++ b/drivers/usb/gadget/udc/udc-xilinx.c
> @@ -1078,7 +1078,7 @@ static int xudc_ep_queue(struct usb_ep *_ep, 
> struct usb_request *_req,
>  	unsigned long flags;
>  
>  	if (!ep->desc) {
> -		dev_dbg(udc->dev, "%s:queing request to disabled %s\n",
> +		dev_dbg(udc->dev, "%s: queuing request to disabled %s\n",
>  			__func__, ep->name);
>  		return -ESHUTDOWN;
>  	}
> -- 
> 2.17.1
> 
