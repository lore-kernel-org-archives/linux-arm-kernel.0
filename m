From: stern@rowland.harvard.edu (Alan Stern)
Date: Mon, 19 Mar 2012 21:56:35 -0400 (EDT)
Subject: [PATCH] USB: gadget driver for LPC32xx
In-Reply-To: <1332191930-2433-1-git-send-email-stigge@antcom.de>
Message-ID: <Pine.LNX.4.44L0.1203192155150.24735-100000@netrider.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 19 Mar 2012, Roland Stigge wrote:

> This patch adds a USB gadget driver.
> 
> Signed-off-by: Roland Stigge <stigge@antcom.de>

...

> +static const struct usb_ep_ops lpc32xx_ep_ops = {
> +	.enable		= lpc32xx_ep_enable,
> +	.disable	= lpc32xx_ep_disable,
> +	.alloc_request	= lpc32xx_ep_alloc_request,
> +	.free_request	= lpc32xx_ep_free_request,
> +	.queue		= lpc32xx_ep_queue,
> +	.dequeue	= lpc32xx_ep_dequeue,
> +	.set_halt	= lpc32xx_ep_set_halt,
> +};

You have not implemented the set_wedge method, which is needed for the 
file-storage gadgets.

Alan Stern
