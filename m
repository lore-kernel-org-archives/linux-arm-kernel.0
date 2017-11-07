From: colin.king@canonical.com (Colin Ian King)
Date: Tue, 7 Nov 2017 14:32:14 +0000
Subject: NAK: [PATCH] usb: gadget: pxa27x: Remove redundant assignment to
 is_short
In-Reply-To: <20171107143125.5548-1-colin.king@canonical.com>
References: <20171107143125.5548-1-colin.king@canonical.com>
Message-ID: <1721c589-d8db-7c45-dc4a-bd77122d1ece@canonical.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/11/17 14:31, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Variable is set to zero but this value is never read as it is
> overwritten with a new value later on, hence it is a redundant
> assignment and can be removed. Cleans up clang warning:
> 
> drivers/usb/gadget/udc/pxa27x_udc.c:1141:2: warning: Value stored
> to 'dev' is never read
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/usb/gadget/udc/pxa27x_udc.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/usb/gadget/udc/pxa27x_udc.c b/drivers/usb/gadget/udc/pxa27x_udc.c
> index 14606f340325..e3d362cc47db 100644
> --- a/drivers/usb/gadget/udc/pxa27x_udc.c
> +++ b/drivers/usb/gadget/udc/pxa27x_udc.c
> @@ -984,8 +984,6 @@ static int write_fifo(struct pxa_ep *ep, struct pxa27x_request *req)
>  
>  	max = ep->fifo_size;
>  	do {
> -		is_short = 0;
> -
>  		udccsr = udc_ep_readl(ep, UDCCSR);
>  		if (udccsr & UDCCSR_PC) {
>  			ep_vdbg(ep, "Clearing Transmit Complete, udccsr=%x\n",
> 
Ignore this, sorry. It's wrong
