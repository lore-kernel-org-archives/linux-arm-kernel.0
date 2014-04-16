From: joelf@ti.com (Joel Fernandes)
Date: Wed, 16 Apr 2014 13:11:55 -0500
Subject: [PATCH v3 00/10] dma: edma: Fixes for cyclic (audio) operation
In-Reply-To: <1397475725-5036-1-git-send-email-peter.ujfalusi@ti.com>
References: <1397475725-5036-1-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <534EC7EB.8030602@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/14/2014 06:41 AM, Peter Ujfalusi wrote:
> Hi,
> 
> Changes since v2:
> - Dropped patch 10 from v2 (simplify direction configuration...)
> - Dropped the channel priority related patches since we are going to go via
>   different route for configuring the priority.
> - Added ACK from Joel for the patches since they are not changed since v2
> 
> Changes since v1:
> - ASoC patches removed
> - Comments from Andriy Shevchenko addressed
> - patch added to fix cases when src/dst_maxburst is set to 0
> 
> The series contains now only:
> Support for DMA pause/resume in cyclic mode
> device_slave_caps callback and DMA_CYCLIC flag correction.
> While debugging the edma to get things sorted out I noticed that the debug was
> too verbose and the important information was hidden even when the we did not
> asked for verbose dmaengine debug.
> I have included some debug cleanups for the edma dmaengine driver also.
> 
> Regards,
> Peter
> ---
> Peter Ujfalusi (10):
>   platform_data: edma: Be precise with the paRAM struct
>   arm: common: edma: Save the number of event queues/TCs
>   dmaengine: edma: Correct the handling of src/dst_maxburst == 0
>   dmaengine: edma: Add support for DMA_PAUSE/RESUME operation
>   dmaengine: edma: Set DMA_CYCLIC capability flag
>   dmaengine: edma: Implement device_slave_caps callback
>   dmaengine: edma: Reduce debug print verbosity for non verbose
>     debugging
>   dmaengine: edma: Prefix debug prints where the text were identical in
>     prep callbacks
>   dmaengine: edma: Add channel number to debug prints
>   dmaengine: edma: Print the direction value as well when it is not
>     supported
> 
>  arch/arm/common/edma.c             |  4 ++
>  drivers/dma/edma.c                 | 87 ++++++++++++++++++++++++++++++--------
>  include/linux/platform_data/edma.h | 18 ++++----
>  3 files changed, 83 insertions(+), 26 deletions(-)
> 

I reviewed and tested all the patches in the new series to make sure it
doesn't break anything with non-cyclic users (MMC and Crypto).

Reviewed-and-Tested-by: Joel Fernandes <joelf@ti.com>


regards,
-Joel
