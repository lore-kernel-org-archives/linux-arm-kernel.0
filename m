From: vinod.koul@intel.com (Koul, Vinod)
Date: Wed, 02 Mar 2011 21:59:06 +0530
Subject: [PATCH v5] dmaengine: mxs-dma: add dma support for i.MX23/28
In-Reply-To: <1298738862-3623-1-git-send-email-shawn.guo@freescale.com>
References: <1298738862-3623-1-git-send-email-shawn.guo@freescale.com>
Message-ID: <1299083346.6974.80.camel@vkoul-udesk3>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 2011-02-26 at 22:17 +0530, Shawn Guo wrote:
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
> ---
> Change since v4:
> 
> Fix checkpatch errors (sorry for forgetting this basical requirement)
> 
>  arch/arm/mach-mxs/include/mach/dma.h |   26 ++
>  drivers/dma/Kconfig                  |    8 +
>  drivers/dma/Makefile                 |    1 +
>  drivers/dma/mxs-dma.c                |  724 ++++++++++++++++++++++++++++++++++
>  4 files changed, 759 insertions(+), 0 deletions(-)
>  create mode 100644 arch/arm/mach-mxs/include/mach/dma.h
>  create mode 100644 drivers/dma/mxs-dma.c
Thanks, Applied to my tree at
git://git.infradead.org/users/vkoul/slave-dma.git

~Vinod
