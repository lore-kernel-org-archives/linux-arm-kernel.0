From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Mon, 23 Sep 2013 14:34:34 +0200
Subject: [PATCH 37/51] DMA-API: usb: use new dma_coerce_mask_and_coherent()
In-Reply-To: <E1VMmIV-0007jw-Gq@rmk-PC.arm.linux.org.uk>
References: <20130919212235.GD12758@n2100.arm.linux.org.uk>
 <E1VMmIV-0007jw-Gq@rmk-PC.arm.linux.org.uk>
Message-ID: <5240355A.9010609@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20/09/2013 00:02, Russell King :
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> ---
>   drivers/usb/chipidea/ci_hdrc_imx.c |    4 +---
>   drivers/usb/dwc3/dwc3-exynos.c     |    4 +---
>   drivers/usb/host/ehci-atmel.c      |    4 +---

For Atmel driver:

Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>

[..]

> diff --git a/drivers/usb/host/ehci-atmel.c b/drivers/usb/host/ehci-atmel.c
> index 5831a88..8e7323e 100644
> --- a/drivers/usb/host/ehci-atmel.c
> +++ b/drivers/usb/host/ehci-atmel.c
> @@ -90,9 +90,7 @@ static int ehci_atmel_drv_probe(struct platform_device *pdev)
>   	 * Since shared usb code relies on it, set it here for now.
>   	 * Once we have dma capability bindings this can go away.
>   	 */
> -	if (!pdev->dev.dma_mask)
> -		pdev->dev.dma_mask = &pdev->dev.coherent_dma_mask;
> -	retval = dma_set_coherent_mask(&pdev->dev, DMA_BIT_MASK(32));
> +	retval = dma_coerce_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32));
>   	if (retval)
>   		goto fail_create_hcd;
>

[..]

Thanks Russell,
-- 
Nicolas Ferre
