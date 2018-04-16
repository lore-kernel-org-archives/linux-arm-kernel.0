From: ludovic.desroches@microchip.com (Ludovic Desroches)
Date: Mon, 16 Apr 2018 13:44:27 +0200
Subject: [PATCH 3/3] usb: gadget: udc: atmel: Fix indenting
In-Reply-To: <20180416093405.16612-4-romain.izard.pro@gmail.com>
References: <20180416093405.16612-1-romain.izard.pro@gmail.com>
 <20180416093405.16612-4-romain.izard.pro@gmail.com>
Message-ID: <20180416114427.GE2750@rfolt0960.corp.atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 16, 2018 at 11:34:05AM +0200, Romain Izard wrote:
> Fix the fallout of the conversion to GPIO descriptors in 3df034081021.
> 
> Signed-off-by: Romain Izard <romain.izard.pro@gmail.com>
Acked-by: Ludovic Desroches <ludovic.desroches@microchip.com>
> ---
>  drivers/usb/gadget/udc/atmel_usba_udc.c | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/usb/gadget/udc/atmel_usba_udc.c b/drivers/usb/gadget/udc/atmel_usba_udc.c
> index b9623e228609..2f586f2bda7e 100644
> --- a/drivers/usb/gadget/udc/atmel_usba_udc.c
> +++ b/drivers/usb/gadget/udc/atmel_usba_udc.c
> @@ -2277,15 +2277,15 @@ static int usba_udc_probe(struct platform_device *pdev)
>  	if (udc->vbus_pin) {
>  		irq_set_status_flags(gpiod_to_irq(udc->vbus_pin), IRQ_NOAUTOEN);
>  		ret = devm_request_threaded_irq(&pdev->dev,
> -					gpiod_to_irq(udc->vbus_pin), NULL,
> -					usba_vbus_irq_thread, USBA_VBUS_IRQFLAGS,
> -					"atmel_usba_udc", udc);
> -			if (ret) {
> -				udc->vbus_pin = NULL;
> -				dev_warn(&udc->pdev->dev,
> -					 "failed to request vbus irq; "
> -					 "assuming always on\n");
> -			}
> +				gpiod_to_irq(udc->vbus_pin), NULL,
> +				usba_vbus_irq_thread, USBA_VBUS_IRQFLAGS,
> +				"atmel_usba_udc", udc);
> +		if (ret) {
> +			udc->vbus_pin = NULL;
> +			dev_warn(&udc->pdev->dev,
> +				 "failed to request vbus irq; "
> +				 "assuming always on\n");
> +		}
>  	}
>  
>  	ret = usb_add_gadget_udc(&pdev->dev, &udc->gadget);
> -- 
> 2.14.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
