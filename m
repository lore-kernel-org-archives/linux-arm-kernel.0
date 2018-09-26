From: shawnguo@kernel.org (Shawn Guo)
Date: Wed, 26 Sep 2018 10:39:39 +0800
Subject: [PATCH] soc: imx: gpc: set DMA mask for PD platform devices
In-Reply-To: <20180912152702.14640-1-l.stach@pengutronix.de>
References: <20180912152702.14640-1-l.stach@pengutronix.de>
Message-ID: <20180926023937.GD22238@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 12, 2018 at 05:27:02PM +0200, Lucas Stach wrote:
> The PD platform devices aren't DMA capable (as is correctly reflected
> in with a zero mask coherent_dma_mask). As they have a of_node attached
> they will go through of_dma_configure, which will warn if it finds an
> uninitialized DMA mask. Let the driver core know that this isn't a
> missing configuration, but a non DMA capable device by pointing the
> dma_mask to the coherent_dma_mask.
> 
> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> ---
> Since the warning that is triggered with the incomplete configuration
> has been introduced in the v4.19 cycle, it would nice to get this in
> as a fix.

Applied as a fix, thanks.
