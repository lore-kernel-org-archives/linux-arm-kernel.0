From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Mon, 19 Jan 2015 15:09:44 +0100
Subject: [PATCHv3 1/2] USB: gadget: atmel_usba_udc: Fixed vbus_prev initial
 state
In-Reply-To: <1421601875-9436-2-git-send-email-sylvain.rochet@finsecur.com>
References: <20150118175621.6b519cdc@bbrezillon>
 <1421601875-9436-1-git-send-email-sylvain.rochet@finsecur.com>
 <1421601875-9436-2-git-send-email-sylvain.rochet@finsecur.com>
Message-ID: <54BD1028.20303@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 18/01/2015 18:24, Sylvain Rochet a ?crit :
> If vbus gpio is high at init, we should set vbus_prev to true
> accordingly to the current vbus state. Without that, we skip the first
> vbus interrupt because the saved vbus state is not consistent.
> 
> Signed-off-by: Sylvain Rochet <sylvain.rochet@finsecur.com>

Indeed:
Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>

We can also add the following tags:
Fixes: 914a3f3b3754 ("USB: add atmel_usba_udc driver")
Cc: <stable@vger.kernel.org> # 2.6.x-ish

Bye,


> ---
>  drivers/usb/gadget/udc/atmel_usba_udc.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/usb/gadget/udc/atmel_usba_udc.c b/drivers/usb/gadget/udc/atmel_usba_udc.c
> index ce88237..e207d75 100644
> --- a/drivers/usb/gadget/udc/atmel_usba_udc.c
> +++ b/drivers/usb/gadget/udc/atmel_usba_udc.c
> @@ -1791,6 +1791,8 @@ static int atmel_usba_start(struct usb_gadget *gadget,
>  		toggle_bias(1);
>  		usba_writel(udc, CTRL, USBA_ENABLE_MASK);
>  		usba_writel(udc, INT_ENB, USBA_END_OF_RESET);
> +
> +		udc->vbus_prev = 1;
>  	}
>  	spin_unlock_irqrestore(&udc->lock, flags);
>  
> 


-- 
Nicolas Ferre
