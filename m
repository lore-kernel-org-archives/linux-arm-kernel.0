From: jg1.han@samsung.com (Jingoo Han)
Date: Wed, 08 May 2013 10:41:37 +0900
Subject: [PATCH] usb: gadget: s3c2410_udc: fix error return code in
 s3c2410_udc_probe()
In-Reply-To: <CAPgLHd9zzFi6dCBH0V=eeqVtd=UstiqM8fDcDsMCfujAfEDHTg@mail.gmail.com>
References: <CAPgLHd9zzFi6dCBH0V=eeqVtd=UstiqM8fDcDsMCfujAfEDHTg@mail.gmail.com>
Message-ID: <001a01ce4b8d$2e22fd40$8a68f7c0$@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday, May 07, 2013 8:48 PM, Wei Yongjun wrote:
> 
> From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
> 
> Fix to return a negative error code in the gpio_to_irq() error handling
> case instead of 0, as done elsewhere in this function.
> 
> Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

Reviewed-by: Jingoo Han <jg1.han@samsung.com>

Best regards,
Jingoo Han


> ---
>  drivers/usb/gadget/s3c2410_udc.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/usb/gadget/s3c2410_udc.c b/drivers/usb/gadget/s3c2410_udc.c
> index d0e75e1..c974776 100644
> --- a/drivers/usb/gadget/s3c2410_udc.c
> +++ b/drivers/usb/gadget/s3c2410_udc.c
> @@ -1851,6 +1851,7 @@ static int s3c2410_udc_probe(struct platform_device *pdev)
>  		irq = gpio_to_irq(udc_info->vbus_pin);
>  		if (irq < 0) {
>  			dev_err(dev, "no irq for gpio vbus pin\n");
> +			retval = irq;
>  			goto err_gpio_claim;
>  		}
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-samsung-soc" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
