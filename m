From: eric.y.miao@gmail.com (Eric Miao)
Date: Fri, 7 Sep 2012 11:56:46 +0800
Subject: [PATCH v2 1/6] usb: pxa27x_udc: remove IRQ_USB define
In-Reply-To: <1346960563-18689-2-git-send-email-robherring2@gmail.com>
References: <1346960563-18689-1-git-send-email-robherring2@gmail.com>
 <1346960563-18689-2-git-send-email-robherring2@gmail.com>
Message-ID: <CAMPhdO9pyVDaR03Cy53gXbPttbnekaejuP_60qARttUuaBUwWg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 7, 2012 at 3:42 AM, Rob Herring <robherring2@gmail.com> wrote:
> From: Rob Herring <rob.herring@calxeda.com>
>
> IRQ_USB was implicitly included by gpio.h. Use the existing variable
> instead of IRQ_USB.
>
> Signed-off-by: Rob Herring <rob.herring@calxeda.com>
> Cc: Eric Miao <eric.y.miao@gmail.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Acked-by: Eric Miao <eric.y.miao@gmail.com>

Greg, guess this can go through the ARM tree.

> ---
>  drivers/usb/gadget/pxa27x_udc.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/usb/gadget/pxa27x_udc.c b/drivers/usb/gadget/pxa27x_udc.c
> index 644b430..7a8713c 100644
> --- a/drivers/usb/gadget/pxa27x_udc.c
> +++ b/drivers/usb/gadget/pxa27x_udc.c
> @@ -2508,7 +2508,7 @@ static int __init pxa_udc_probe(struct platform_device *pdev)
>                         IRQF_SHARED, driver_name, udc);
>         if (retval != 0) {
>                 dev_err(udc->dev, "%s: can't get irq %i, err %d\n",
> -                       driver_name, IRQ_USB, retval);
> +                       driver_name, udc->irq, retval);
>                 goto err_irq;
>         }
>         retval = usb_add_gadget_udc(&pdev->dev, &udc->gadget);
> --
> 1.7.9.5
>
