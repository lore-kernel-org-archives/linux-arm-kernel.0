From: vinod.koul@linux.intel.com (Vinod Koul)
Date: Fri, 14 Sep 2012 08:54:00 +0530
Subject: [PATCH v2 04/15] dmaengine: Pass no_wakeup parameter via
 device_prep_dma_cyclic() callback
In-Reply-To: <1347543485-339-5-git-send-email-peter.ujfalusi@ti.com>
References: <1347543485-339-1-git-send-email-peter.ujfalusi@ti.com>
 <1347543485-339-5-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <1347593040.1943.24.camel@vkoul-udesk3>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2012-09-13 at 16:37 +0300, Peter Ujfalusi wrote:
> Change the parameter list of device_prep_dma_cyclic() so the DMA drivers
> can receive the no_wakeup request coming from client drivers.
> This feature can be used during audio operation to disable all audio
> related interrupts.
We already have a flag to indicate this, see 
* @DMA_PREP_INTERRUPT - trigger an interrupt (callback) upon completion  of
*  this transaction

Unfortunately, the addition of cyclic API missed having this flag. So
right way would be to add flag argument in the API.

-- 
~Vinod
