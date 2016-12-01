From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Thu, 1 Dec 2016 12:20:10 +0100
Subject: [PATCH] usb: gadget: udc: atmel: used managed kasprintf
In-Reply-To: <20161201102656.29041-1-alexandre.belloni@free-electrons.com>
References: <20161201102656.29041-1-alexandre.belloni@free-electrons.com>
Message-ID: <5a02d413-6620-3777-366f-e45e713deb49@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 01/12/2016 ? 11:26, Alexandre Belloni a ?crit :
> Use devm_kasprintf instead of simple kasprintf to free the allocated memory
> when needed.
> 
> Suggested-by: Peter Rosin <peda@axentia.se>
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>

Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>

> ---
>  drivers/usb/gadget/udc/atmel_usba_udc.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/gadget/udc/atmel_usba_udc.c b/drivers/usb/gadget/udc/atmel_usba_udc.c
> index 45bc997d0711..aec72fe8273c 100644
> --- a/drivers/usb/gadget/udc/atmel_usba_udc.c
> +++ b/drivers/usb/gadget/udc/atmel_usba_udc.c
> @@ -1978,7 +1978,8 @@ static struct usba_ep * atmel_udc_of_init(struct platform_device *pdev,
>  			dev_err(&pdev->dev, "of_probe: name error(%d)\n", ret);
>  			goto err;
>  		}
> -		ep->ep.name = kasprintf(GFP_KERNEL, "ep%d", ep->index);
> +		ep->ep.name = devm_kasprintf(&pdev->dev, GFP_KERNEL, "ep%d",
> +					     ep->index);
>  
>  		ep->ep_regs = udc->regs + USBA_EPT_BASE(i);
>  		ep->dma_regs = udc->regs + USBA_DMA_BASE(i);
> 


-- 
Nicolas Ferre
