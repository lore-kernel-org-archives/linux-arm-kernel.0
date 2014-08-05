From: vinod.koul@intel.com (Vinod Koul)
Date: Tue, 5 Aug 2014 22:26:17 +0530
Subject: DMA engine API issue (was: [PATCH/RFC 0/5] R-Car Gen2 DMAC
 hardware descriptor list support)
In-Reply-To: <1621896.RqTTnmY7rK@avalon>
References: <1406032431-3807-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <18522523.T2zy7HfoJ2@avalon> <20140801170744.GD8181@intel.com>
 <1621896.RqTTnmY7rK@avalon>
Message-ID: <20140805165617.GB8181@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 04, 2014 at 06:50:17PM +0200, Laurent Pinchart wrote:
 
> The question was why is there a dma_async_issue_pending() operation at all ? 
> Why can't dmaengine_submit() triggers the transfer start ? The only 
> explanation is a small comment in dmaengine.h that states
> 
>  * This allows drivers to push copies to HW in batches,
>  * reducing MMIO writes where possible.
> 
> I don't think that's applicable for DMA slave transfers. Is it still 
> applicable for anything else ?
why not?

If your hw supports sg-lists and say length of 8 and you prepare two
descriptors for lengths of 3 and 5. While in issue pending what prevents you
from submiiting them in one shot to hardware while still getting interrupt.

I know designware and intel-dma do support that. It is different point that
drivers don't

-- 
~Vinod
