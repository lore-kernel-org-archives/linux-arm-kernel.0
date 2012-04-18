From: thierry.reding@avionic-design.de (Thierry Reding)
Date: Wed, 18 Apr 2012 06:55:40 +0200
Subject: [PATCH v2 1/8] ohci-nxp: Driver cleanup
In-Reply-To: <1334682507-15055-2-git-send-email-stigge@antcom.de>
References: <1334682507-15055-1-git-send-email-stigge@antcom.de>
 <1334682507-15055-2-git-send-email-stigge@antcom.de>
Message-ID: <20120418045540.GA16990@avionic-0098.adnet.avionic-design.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Roland Stigge wrote:
> --- linux-2.6.orig/drivers/usb/host/ohci-nxp.c
> +++ linux-2.6/drivers/usb/host/ohci-nxp.c
[...]
> @@ -220,7 +220,7 @@ static void isp1301_configure_lpc32xx(vo
>  		ISP1301_I2C_INTERRUPT_RISING | ISP1301_I2C_REG_CLEAR_ADDR, ~0);
>  
>  	/* Enable usb_need_clk clock after transceiver is initialized */
> -	__raw_writel((__raw_readl(USB_CTRL) | (1 << 22)), USB_CTRL);
> +	__raw_writel((__raw_readl(USB_CTRL) | USB_HOST_NEED_CLK_EN), USB_CTRL);

There's a pair of gratuitous parentheses here. Since you're changing the line
anyway you can just drop them as well.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120418/d5fa2d60/attachment.sig>
