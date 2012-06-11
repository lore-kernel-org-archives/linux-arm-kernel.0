From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 11 Jun 2012 12:10:29 +0100
Subject: [PATCH 4/14] ARM: LPC32xx: Add DMA configuration to platform data
In-Reply-To: <1339412537-24485-5-git-send-email-stigge@antcom.de>
References: <1339412537-24485-1-git-send-email-stigge@antcom.de>
 <1339412537-24485-5-git-send-email-stigge@antcom.de>
Message-ID: <20120611111029.GF11168@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 11, 2012 at 01:02:07PM +0200, Roland Stigge wrote:
> +static int pl08x_get_signal(struct pl08x_dma_chan *ch)
> +{
> +	return ch->cd->min_signal;
> +}
> +
> +static void pl08x_put_signal(struct pl08x_dma_chan *ch)
> +{
> +}

These change in my unstable/dma-pl08x branch, patches have been posted
already, but I don't deem them to be totally stable yet.  Waiting on
OMAP people to get their mainline kernel restored to a buildable state
so I can continue my DMA engine work.

> +
>  static struct pl08x_platform_data pl08x_pd = {
> +	.slave_channels = &pl08x_slave_channels[0],
> +	.num_slave_channels = ARRAY_SIZE(pl08x_slave_channels),
> +	.get_signal = &pl08x_get_signal,
> +	.put_signal = &pl08x_put_signal,

No need to take the address of a function here.
