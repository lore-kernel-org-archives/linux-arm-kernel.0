From: vinod.koul@intel.com (Vinod Koul)
Date: Sun, 20 Jan 2013 04:05:15 -0800
Subject: [RESEND][PATCH] dma: edma: fix slave config dependency on
 direction
In-Reply-To: <1357843264-27045-1-git-send-email-mporter@ti.com>
References: <1357843264-27045-1-git-send-email-mporter@ti.com>
Message-ID: <20130120120515.GB23398@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 10, 2013 at 01:41:04PM -0500, Matt Porter wrote:
> The edma_slave_config() implementation depends on the
> direction field such that it will not properly configure
> a slave channel when called without direction set.
> 
> This fixes the implementation so that the slave config
> is copied as is and prep_slave_sg() handles the
> direction dependent handling. spi-omap2-mcspi and
> omap_hsmmc both expose this bug as they configure the
> slave channel config from a common path with an unconfigured
> direction field.
> 
> Signed-off-by: Matt Porter <mporter@ti.com>
Applied, Thanks

--
~Vinod
