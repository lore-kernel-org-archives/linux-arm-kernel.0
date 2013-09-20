From: balbi@ti.com (Felipe Balbi)
Date: Fri, 20 Sep 2013 08:10:02 -0500
Subject: [PATCH 37/51] DMA-API: usb: use new dma_coerce_mask_and_coherent()
In-Reply-To: <E1VMmIV-0007jw-Gq@rmk-PC.arm.linux.org.uk>
References: <20130919212235.GD12758@n2100.arm.linux.org.uk>
 <E1VMmIV-0007jw-Gq@rmk-PC.arm.linux.org.uk>
Message-ID: <20130920131002.GN26101@radagast>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Sep 19, 2013 at 11:02:03PM +0100, Russell King wrote:
> diff --git a/drivers/usb/dwc3/dwc3-exynos.c b/drivers/usb/dwc3/dwc3-exynos.c
> index c10b324..8b20c70 100644
> --- a/drivers/usb/dwc3/dwc3-exynos.c
> +++ b/drivers/usb/dwc3/dwc3-exynos.c
> @@ -119,9 +119,7 @@ static int dwc3_exynos_probe(struct platform_device *pdev)
>  	 * Since shared usb code relies on it, set it here for now.
>  	 * Once we move to full device tree support this will vanish off.
>  	 */
> -	if (!dev->dma_mask)
> -		dev->dma_mask = &dev->coherent_dma_mask;
> -	ret = dma_set_coherent_mask(dev, DMA_BIT_MASK(32));
> +	ret = dma_coerce_mask_and_coherent(dev, DMA_BIT_MASK(32));
>  	if (ret)
>  		goto err1;
>  
> diff --git a/drivers/usb/host/ehci-omap.c b/drivers/usb/host/ehci-omap.c
> index d0759c5..6fa82d6 100644
> --- a/drivers/usb/host/ehci-omap.c
> +++ b/drivers/usb/host/ehci-omap.c
> @@ -144,9 +144,7 @@ static int ehci_hcd_omap_probe(struct platform_device *pdev)
>  	 * Since shared usb code relies on it, set it here for now.
>  	 * Once we have dma capability bindings this can go away.
>  	 */
> -	if (!dev->dma_mask)
> -		dev->dma_mask = &dev->coherent_dma_mask;
> -	ret = dma_set_coherent_mask(dev, DMA_BIT_MASK(32));
> +	ret = dma_coerce_mask_and_coherent(dev, DMA_BIT_MASK(32));
>  	if (ret)
>  		return ret;

for dwc3 and ehci-omap:

Acked-by: Felipe Balbi <balbi@ti.com>

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130920/cd985ce0/attachment.sig>
