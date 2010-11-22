From: stern@rowland.harvard.edu (Alan Stern)
Date: Mon, 22 Nov 2010 10:22:07 -0500 (EST)
Subject: [PATCH 2/2] USB: pxa: Add USB client support for Marvell
	PXA9xx/PXA168 chips
In-Reply-To: <1290418347-6861-2-git-send-email-chao.xie@marvell.com>
Message-ID: <Pine.LNX.4.44L0.1011221020360.1758-100000@iolanthe.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 22 Nov 2010 chao.xie at marvell.com wrote:

> From: cxie4 <cxie4@marvell.com>
> 
> This patch add USB client support Marvell PXA9xx/PXA168 chips. The USB
> controller in PXA9xx/PXA168 is a High-Speed OTG controller. The available
> endpoints is different between PXA9xx and PXA168.
> 
> NOTE:
> It is the first version of Marvell PXA9xx/PXA168 USB controller driver.
> The support for OTG mode will be added in later patch.
> PXA9xx and PXA168 has integrated UTMI PHY in the chips. The initialization
> for the PHY is a little different between PXA9xx and PXA168.

...

> +static struct usb_ep_ops mv_ep_ops = {
> +	.enable		= mv_ep_enable,
> +	.disable	= mv_ep_disable,
> +
> +	.alloc_request	= mv_alloc_request,
> +	.free_request	= mv_free_request,
> +
> +	.queue		= mv_ep_queue,
> +	.dequeue	= mv_ep_dequeue,
> +
> +	.set_halt	= mv_ep_set_halt,
> +	.fifo_flush	= mv_ep_fifo_flush,	/* flush fifo */
> +};

What happened to the .set_wedge method?

Alan Stern
