From: mika.westerberg@iki.fi (Mika Westerberg)
Date: Tue, 7 Jun 2011 20:14:04 +0300
Subject: [PATCH v2 5/5] spi/ep93xx: add DMA support
In-Reply-To: <20110603204400.GH17972@ponder.secretlab.ca>
References: <cover.1306662317.git.mika.westerberg@iki.fi>
	<4b27fc93b7df900943e7c12084a8340cbc5fe1a8.1306662317.git.mika.westerberg@iki.fi>
	<20110603204400.GH17972@ponder.secretlab.ca>
Message-ID: <20110607171403.GA3011@acer>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 03, 2011 at 02:44:00PM -0600, Grant Likely wrote:
> On Sun, May 29, 2011 at 01:10:06PM +0300, Mika Westerberg wrote:
> > This patch adds DMA support for the EP93xx SPI driver. By default the DMA is
> > not enabled but it can be enabled by setting ep93xx_spi_info.use_dma to true
> > in board configuration file.
> > 
> > Note that the SPI driver still uses PIO for small transfers (<= 8 bytes) for
> > performance reasons.
> > 
> > Signed-off-by: Mika Westerberg <mika.westerberg@iki.fi>
> > Acked-by: H Hartley Sweeten <hsweeten@visionengravers.com>
> > Cc: Grant Likely <grant.likely@secretlab.ca>
> 
> Acked-by: Grant Likely <grant.likely@secretlab.ca>
> 
> Since this depends on the DMA patches, it can go in via the same tree.

I just realized that once the SPI driver renaming patch (spi: reorganize
drivers) enters linux-next, this patch (which sits on Vinod's tree) will cause
a merge conflict. Any ideas how to avoid it beforehand?
