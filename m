From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 18 Feb 2011 14:37:02 +0100
Subject: [PATCH v2] mxcmmc: use dmaengine API
In-Reply-To: <20110218092109.GG24426@pengutronix.de>
References: <20110218092109.GG24426@pengutronix.de>
Message-ID: <201102181437.02943.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 18 February 2011, Sascha Hauer wrote:
> This switches the mxcmmc driver to use the dmaengine API. Unlike
> the old one this one is always present in the tree, even if no DMA
> is implemented, hence we can remove all the #ifdefs in from the driver.
> The driver automatically switches to PIO mode if no DMA support or no
> suitable channel is available.
> 
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>

The patch looks good to me, but shouldn't you also add a Kconfig
dependency or select on CONFIG_DMA_ENGINE? I don't see where that
gets set.

Acked-by: Arnd Bergmann <arnd@arndb.de>

> Arnd recognized that it's not a good idea that the driver has to
> know about the dmaengine implementation (the struct imx_dma_data field).
> I have a patch in my queue fixing this, but as this has to be
> synchronized with the platform code, I'd like to address this in a later
> patch.

Sounds good, since this patch is definitely a step forward.

	Arnd
