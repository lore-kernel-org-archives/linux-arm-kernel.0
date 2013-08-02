From: balbi@ti.com (Felipe Balbi)
Date: Fri, 2 Aug 2013 10:46:57 +0300
Subject: [PATCH v2] usb: gadget: at91_udc: add usb_clk for transition to
 common clk framework
In-Reply-To: <1375376870-22747-1-git-send-email-b.brezillon@overkiz.com>
References: <1375376870-22747-1-git-send-email-b.brezillon@overkiz.com>
Message-ID: <20130802074657.GI24465@radagast>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Aug 01, 2013 at 07:07:50PM +0200, Boris BREZILLON wrote:
> @@ -1851,6 +1860,12 @@ fail3:
>  fail2:
>  	free_irq(udc->udp_irq, udc);
>  fail1:
> +	if (IS_ENABLED(CONFIG_COMMON_CLK) && !IS_ERR(udc->uclk))
> +		clk_put(udc->uclk);
> +	if (!IS_ERR(udc->fclk))
> +		clk_put(udc->fclk);
> +	if (!IS_ERR(udc->iclk))
> +		clk_put(udc->iclk);

adding missing clk_put() for iclk and fclk should be part of a separate
patch. Please split this part.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130802/e77b6f9e/attachment.sig>
