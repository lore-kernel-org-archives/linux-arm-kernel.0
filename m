From: vinod.koul@intel.com (Koul, Vinod)
Date: Sat, 26 Feb 2011 21:27:35 +0530
Subject: [PATCH v4] dmaengine: mxs-dma: add dma support for i.MX23/28
In-Reply-To: <1298619259-14344-1-git-send-email-shawn.guo@freescale.com>
References: <1298619259-14344-1-git-send-email-shawn.guo@freescale.com>
Message-ID: <1298735855.6974.21.camel@vkoul-udesk3>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2011-02-25 at 15:34 +0800, Shawn Guo wrote:
> This patch adds dma support for Freescale MXS-based SoC i.MX23/28,
> including apbh-dma and apbx-dma.
> 
> * apbh-dma and apbx-dma are supported in the driver as two mxs-dma
>   instances.
> 
> * apbh-dma is different between mx23 and mx28, hardware version
>   register is used to differentiate.
> 
> * mxs-dma supports pio function besides data transfer.  The driver
>   uses dma_data_direction DMA_NONE to identify the pio mode, and
>   steals sgl and sg_len to get pio words and numbers from clients.
> 
> * mxs dmaengine has some very specific features, like sense function
>   and the special NAND support (nand_lock, nand_wait4ready).  These
>   are too specific to implemented in generic dmaengine driver.
> 
> * The driver refers to imx-sdma and only a single descriptor is
>   statically assigned to each channel.
> 
> Signed-off-by: Shawn Guo <shawn.guo@freescale.com>
Please fix the checkpatch errors and warnings, at least it should have
zero errors.

ERROR: code indent should use tabs where possible
#430: FILE: drivers/dma/mxs-dma.c:250:
+        if (mxs_chan->desc.callback)$


WARNING: please, no spaces at the start of a line
#430: FILE: drivers/dma/mxs-dma.c:250:
+        if (mxs_chan->desc.callback)$

ERROR: code indent should use tabs where possible
#431: FILE: drivers/dma/mxs-dma.c:251:
+                mxs_chan->desc.callback(mxs_chan->desc.callback_param);

WARNING: please, no spaces at the start of a line
#431: FILE: drivers/dma/mxs-dma.c:251:
+                mxs_chan->desc.callback(mxs_chan->desc.callback_param);

ERROR: do not initialise statics to 0 or NULL
#564: FILE: drivers/dma/mxs-dma.c:384:
+       static int idx = 0;

~Vinod
