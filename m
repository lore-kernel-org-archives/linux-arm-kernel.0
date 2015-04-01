From: vinod.koul@intel.com (Vinod Koul)
Date: Wed, 1 Apr 2015 09:10:44 +0530
Subject: [PATCH] dmaengine: ste_dma40: fix implicit conversion
In-Reply-To: <1426981868-1988-1-git-send-email-stefan@agner.ch>
References: <1426981868-1988-1-git-send-email-stefan@agner.ch>
Message-ID: <20150401034044.GT7192@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Mar 22, 2015 at 12:51:08AM +0100, Stefan Agner wrote:
> The function d40_prep_sg takes the type enum dma_transfer_direction
> as second last parameter. However, the memcpy calls pass DMA_NONE
> which is of type enum dma_data_direction. Fix this by passing the
> actual transfer direction DMA_MEM_TO_MEM.
> 
> This does not change the actual code flow since only the transfer
> direction DMA_MEM_TO_DEV and DMA_DEV_TO_MEM are actually used in the
> function d40_prep_sg.

Applied, now

-- 
~Vinod
