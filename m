From: vinod.koul@intel.com (Vinod Koul)
Date: Wed, 13 Nov 2013 15:42:01 +0530
Subject: [PATCH v5 0/5] dma: mxs-dma bugfixes and cleanup
In-Reply-To: <1383032869-12863-1-git-send-email-mpa@pengutronix.de>
References: <1383032869-12863-1-git-send-email-mpa@pengutronix.de>
Message-ID: <20131113101201.GV8834@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 29, 2013 at 08:47:44AM +0100, Markus Pargmann wrote:
> Hi,
> 
> v5 is rebased onto your dma_complete branch. It includes one bugfix.
> 
> This series contains a number of bugfixes for the mxs DMA engine.

Thanks,

I am going to apply this. But as noted in residue patch I think the restriction
of single descriptor is an artficial one and we cna do better in SW. This also
bring the abuse the completion status to track the channel status which shouldnt
be required/gone once we do multiple descriptors. But those should be handled
as another patch series!

--
~Vinod
> 
> Regards,
> 
> Markus Pargmann
> 
> 
> Markus Pargmann (5):
>   dma: mxs-dma: Cleanup interrupt handler
>   dma: mxs-dma: Report correct residue for cyclic DMA
>   dma: mxs-dma: Fix channel reset hardware bug
>   dma: mxs-dma: Update state after channel reset
>   dma: mxs-dma: Use semaphores for cyclic DMA
> 
>  drivers/dma/mxs-dma.c | 176 +++++++++++++++++++++++++++++++++++++++-----------
>  1 file changed, 137 insertions(+), 39 deletions(-)
> 
> -- 
> 1.8.4.rc3
> 

-- 
