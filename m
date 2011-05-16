From: vinod.koul@intel.com (Koul, Vinod)
Date: Mon, 16 May 2011 21:34:11 +0530
Subject: [PATCH V5 0/5] dmaengine/dw_dmac updates
In-Reply-To: <cover.1304928776.git.viresh.kumar@st.com>
References: <cover.1304928776.git.viresh.kumar@st.com>
Message-ID: <1305561851.28926.70.camel@vkoul-udesk3>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2011-05-09 at 13:45 +0530, Viresh Kumar wrote:
> This patchset fixes few issues and extends its support.
> 
> Changes in V5:
>  - [PATCH 1/5] rearranging code in dmaengine/dw_dmac: don't call callback
>    routine in case dmaengine_terminate_all() is called
> 
> Changes in V4:
>  - spin_locks are not taken anymore from parent routines. Now every routine
>    takes locks whenever required.
>  - 1 and 0 are replaced with true and false for bool parameters to routines.
>  - flags are not used uninitialized for spin_lock_irqsave
> 
> Changes in V3:
>  - lflags is removed from dw_dma_chan and local flag variables are created.
>  - An extra argument is added to routines calling dwc_descriptor_complete()
>    directly or indirectly
>  - spin_lock() in tasklet is also changed to irqsave variants.
> 
> Changes in V2:
>  - lflags added in dw_dma_chan instead of dw_dma
>  - Patch from Linus Walleij added for pause and resume functionality.
> 
> Linus Walleij (1):
>   dmaengine/dw_dmac: implement pause and resume in dwc_control
> 
> Viresh Kumar (4):
>   dmaengine/dw_dmac: don't call callback routine in case
>     dmaengine_terminate_all() is called
>   dmaengine/dw_dmac: set residue as total len in dwc_tx_status if
>     status is !DMA_SUCCESS
>   dmaengine/dw_dmac: Divide one sg to many desc, if sg len is greater
>     than DWC_MAX_COUNT
>   dmaengine/dw_dmac: Replace spin_lock* with irqsave variants and
>     enable submission from callback
> 
>  drivers/dma/dw_dmac.c      |  267 +++++++++++++++++++++++++++++---------------
>  drivers/dma/dw_dmac_regs.h |    1 +
>  2 files changed, 176 insertions(+), 92 deletions(-)
> 
Applied, thanks

-- 
~Vinod
