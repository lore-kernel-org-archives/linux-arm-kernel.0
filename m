From: vinod.koul@intel.com (Vinod Koul)
Date: Wed, 8 Jun 2016 08:57:55 +0530
Subject: [PATCH] dmaengine: edma: Use early completion for intermediate
 paRAM set in slave_sg
In-Reply-To: <20160607081944.21447-1-peter.ujfalusi@ti.com>
References: <20160607081944.21447-1-peter.ujfalusi@ti.com>
Message-ID: <20160608032755.GN16910@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 07, 2016 at 11:19:44AM +0300, Peter Ujfalusi wrote:
> The driver limits the physical number of paRAM slots to be used by channels.
> If the transfer needs more slots (more SGs) then the transfer is broken up
> to smaller chunks. When the chunk is finished the driver will rewrite the
> physical slots and continues the transfer. This set up time can take some
> time and we might miss DMA events. If the intermediate set completion is
> using early completion (the interrupt will happen when the last slot is
> issued to the TPTC and not when the transfer is finished by the TPTC) we
> will have a bit more time to update the paRAM slots and less likely to have
> missed events.

Applied, thanks

-- 
~Vinod
