From: joelf@ti.com (Joel Fernandes)
Date: Mon, 21 Apr 2014 11:54:55 -0500
Subject: [PATCH v3 00/10] dma: edma: Fixes for cyclic (audio) operation
In-Reply-To: <1397475725-5036-1-git-send-email-peter.ujfalusi@ti.com>
References: <1397475725-5036-1-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <53554D5F.9020105@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Vinod, Dan,

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

I reviewed/tested these patches and they look OK to me. Also the point
of contention was priority which is now dropped from the series. If the
patches look OK and there are no further review comments can they be
queued for -next?

I also have a memcpy and another fix patch for edma so I could queue all
together in my tree and send a consolidated pull request to make it easier.

thanks,
 -Joel
