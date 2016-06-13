From: vinod.koul@intel.com (Vinod Koul)
Date: Mon, 13 Jun 2016 11:12:44 +0530
Subject: [PATCH] dmaengine: vdma: Fix compilation warning in cyclic dma
 mode
In-Reply-To: <1465452132-13512-1-git-send-email-appanad@xilinx.com>
References: <1465452132-13512-1-git-send-email-appanad@xilinx.com>
Message-ID: <20160613054243.GB16910@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 09, 2016 at 11:32:12AM +0530, Kedareswara rao Appana wrote:
> This patch fixes the below compilation warining.
> drivers/dma/xilinx/xilinx_vdma.c: In function 'xilinx_dma_prep_dma_cyclic':
> drivers/dma/xilinx/xilinx_vdma.c:1808:23: warning: 'segment' may be used
> uninitialized in this function [-Wmaybe-uninitialized]
>    segment->hw.control |= XILINX_DMA_BD_SOP;
> 
> The start of packet (SOP) should be set to the first segment in the desc
> chain not for the last segment of the desc chain.

I have applied this after adding Reported by from SFR.

You should always give credit to folks who report issues.

Thanks
-- 
~Vinod
