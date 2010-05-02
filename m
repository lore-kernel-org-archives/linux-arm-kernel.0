From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 2 May 2010 15:36:02 +0100
Subject: [PATCH 3/5] USB: add clk structure for systems that support
	clkdev framework
In-Reply-To: <1272810162-14858-4-git-send-email-saeed@marvell.com>
References: <1272810162-14858-1-git-send-email-saeed@marvell.com>
	<1272810162-14858-2-git-send-email-saeed@marvell.com>
	<1272810162-14858-3-git-send-email-saeed@marvell.com>
	<1272810162-14858-4-git-send-email-saeed@marvell.com>
Message-ID: <20100502143602.GA4233@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, May 02, 2010 at 05:22:40PM +0300, Saeed Bishara wrote:
> @@ -110,6 +111,9 @@ struct usb_hcd {
>  	u64			rsrc_start;	/* memory/io resource start */
>  	u64			rsrc_len;	/* memory/io resource length */
>  	unsigned		power_budget;	/* in mA, 0 = no limit */
> +#if defined(CONFIG_HAVE_CLK)
> +	struct clk		*clk;
> +#endif

We have other hci's using the clk API, why do we need to add this for
them too?  In other words, why can't the orion HCI driver work like
the other HCI drivers such as ohci-pxa27x.c or ehci-omap.c ?
