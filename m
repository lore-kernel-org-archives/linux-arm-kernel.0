From: andriy.shevchenko@linux.intel.com (Andy Shevchenko)
Date: Wed, 24 Apr 2013 16:35:42 +0300
Subject: [PATCH 04/11] dmaengine: dw_dmac: simplify master selection
In-Reply-To: <201304241435.50963.arnd@arndb.de>
References: <1366796443-7083-1-git-send-email-andriy.shevchenko@linux.intel.com>
 <1366796443-7083-4-git-send-email-andriy.shevchenko@linux.intel.com>
 <201304241435.50963.arnd@arndb.de>
Message-ID: <1366810542.31721.21.camel@smile>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2013-04-24 at 14:35 +0200, Arnd Bergmann wrote: 
> On Wednesday 24 April 2013, Andy Shevchenko wrote:
> > From: Arnd Bergmann <arnd@arndb.de>
> > 
> > The patch to add the common DMA binding added a dummy dw_dma_slave
> > structure into the dw_dma_chan structure in order to configure the
> > masters correctly. It turns out that this can be simplified if we
> > pick the DMA masters in the dwc_alloc_chan_resources function instead
> > and save them in the dw_dma_chan structure directly.
> > 
> > This could be simplified further once all users that today use
> > dw_dma_slave for configuration get converted to device tree based
> > setup instead.
> > 
> > (Upstream commit id: f776076b9fa82d630651c9af56359d80fce86d68)
> > 
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> > Cc: linux-arm-kernel at lists.infradead.org
> > Acked-by: Arnd Bergmann <arnd@arndb.de>
> > Signed-off-by: Vinod Koul <vinod.koul@intel.com>
> 
> Hi Andy,
> 
> Did you intend that to get sent to everyone, or just forget to
> pass --suppress-cc=all to git-send-email?

Second. Sorry for spam.


-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
