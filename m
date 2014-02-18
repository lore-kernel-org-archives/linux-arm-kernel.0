From: balbi@ti.com (Felipe Balbi)
Date: Tue, 18 Feb 2014 10:19:06 -0600
Subject: [PATCH 2/2] USB: at91: using USBA_NR_DMAS for DMA channels
In-Reply-To: <1389927565-22477-2-git-send-email-voice.shen@atmel.com>
References: <1389927565-22477-1-git-send-email-voice.shen@atmel.com>
 <1389927565-22477-2-git-send-email-voice.shen@atmel.com>
Message-ID: <20140218161839.GD9878@saruman.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 17, 2014 at 10:59:25AM +0800, Bo Shen wrote:
> When the SoC is earlier than sama5d3 SoC, which have the same number
> endpoints and DMAs. However for sama5d3 SoC, it has different number
> for endpoints and DMAs. So, define USBA_NR_DMAs for DMA channels
> 
> Signed-off-by: Bo Shen <voice.shen@atmel.com>
> ---
> 
>  drivers/usb/gadget/atmel_usba_udc.c | 2 +-
>  drivers/usb/gadget/atmel_usba_udc.h | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/gadget/atmel_usba_udc.c b/drivers/usb/gadget/atmel_usba_udc.c
> index 7e67a81..5cded1c 100644
> --- a/drivers/usb/gadget/atmel_usba_udc.c
> +++ b/drivers/usb/gadget/atmel_usba_udc.c
> @@ -1661,7 +1661,7 @@ static irqreturn_t usba_udc_irq(int irq, void *devid)
>  	if (dma_status) {
>  		int i;
>  
> -		for (i = 1; i < USBA_NR_ENDPOINTS; i++)
> +		for (i = 1; i < USBA_NR_DMAS; i++)
>  			if (dma_status & (1 << i))
>  				usba_dma_irq(udc, &udc->usba_ep[i]);
>  	}
> diff --git a/drivers/usb/gadget/atmel_usba_udc.h b/drivers/usb/gadget/atmel_usba_udc.h
> index 2922db5..a70706e 100644
> --- a/drivers/usb/gadget/atmel_usba_udc.h
> +++ b/drivers/usb/gadget/atmel_usba_udc.h
> @@ -210,7 +210,7 @@
>  #define USBA_FIFO_BASE(x)	((x) << 16)
>  
>  /* Synth parameters */
> -#define USBA_NR_ENDPOINTS	7
> +#define USBA_NR_DMAS		7

what's the difference ? You just renamed this macro. Also, please
clarify a bit your commit log.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140218/32376893/attachment.sig>
