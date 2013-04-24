From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 24 Apr 2013 14:35:50 +0200
Subject: [PATCH 04/11] dmaengine: dw_dmac: simplify master selection
In-Reply-To: <1366796443-7083-4-git-send-email-andriy.shevchenko@linux.intel.com>
References: <1366796443-7083-1-git-send-email-andriy.shevchenko@linux.intel.com>
 <1366796443-7083-4-git-send-email-andriy.shevchenko@linux.intel.com>
Message-ID: <201304241435.50963.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 24 April 2013, Andy Shevchenko wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The patch to add the common DMA binding added a dummy dw_dma_slave
> structure into the dw_dma_chan structure in order to configure the
> masters correctly. It turns out that this can be simplified if we
> pick the DMA masters in the dwc_alloc_chan_resources function instead
> and save them in the dw_dma_chan structure directly.
> 
> This could be simplified further once all users that today use
> dw_dma_slave for configuration get converted to device tree based
> setup instead.
> 
> (Upstream commit id: f776076b9fa82d630651c9af56359d80fce86d68)
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> Cc: linux-arm-kernel at lists.infradead.org
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Vinod Koul <vinod.koul@intel.com>

Hi Andy,

Did you intend that to get sent to everyone, or just forget to
pass --suppress-cc=all to git-send-email?

	Arnd
