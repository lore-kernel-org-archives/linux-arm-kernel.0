From: balbi@ti.com (Felipe Balbi)
Date: Wed, 14 Jan 2015 11:37:29 -0600
Subject: [PATCH 05/12] usb: gadget: at91_udc: Fix clock names
In-Reply-To: <1421252524-24452-6-git-send-email-alexandre.belloni@free-electrons.com>
References: <1421252524-24452-1-git-send-email-alexandre.belloni@free-electrons.com>
 <1421252524-24452-6-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <20150114173729.GG16533@saruman>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 14, 2015 at 05:21:57PM +0100, Alexandre Belloni wrote:
> From: Boris Brezillon <boris.brezillon@free-electrons.com>
> 
> The driver is requesting clock by their global name (those declared in the
> clk_lookup list), but this only works with !CCF kernels.
> 
> Now that all SoCs have moved to CCF, fix the driver to use local names
> (hclk and pclk).
> 
> Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>

Acked-by: Felipe Balbi <balbi@ti.com>

> ---
>  drivers/usb/gadget/udc/at91_udc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/gadget/udc/at91_udc.c b/drivers/usb/gadget/udc/at91_udc.c
> index c862656d18b8..9ff2f7e5c6a7 100644
> --- a/drivers/usb/gadget/udc/at91_udc.c
> +++ b/drivers/usb/gadget/udc/at91_udc.c
> @@ -1779,8 +1779,8 @@ static int at91udc_probe(struct platform_device *pdev)
>  	udc_reinit(udc);
>  
>  	/* get interface and function clocks */
> -	udc->iclk = clk_get(dev, "udc_clk");
> -	udc->fclk = clk_get(dev, "udpck");
> +	udc->iclk = clk_get(dev, "pclk");
> +	udc->fclk = clk_get(dev, "hclk");
>  	if (IS_ENABLED(CONFIG_COMMON_CLK))
>  		udc->uclk = clk_get(dev, "usb_clk");
>  	if (IS_ERR(udc->iclk) || IS_ERR(udc->fclk) ||
> -- 
> 2.1.0
> 

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150114/8dd2d90f/attachment.sig>
