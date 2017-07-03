From: vinod.koul@intel.com (Vinod Koul)
Date: Mon, 3 Jul 2017 10:40:22 +0530
Subject: [PATCH V2] dmaengine: qcom_hidma: correct API violation for submit
In-Reply-To: <1498833785-22632-1-git-send-email-okaya@codeaurora.org>
References: <1498833785-22632-1-git-send-email-okaya@codeaurora.org>
Message-ID: <20170703051022.GZ19154@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 30, 2017 at 10:43:05AM -0400, Sinan Kaya wrote:
> Current code is violating the DMA Engine API by putting the submitted
> requests directly into the HW queue. This causes queued transactions
> to be started by another thread as soon as the first one finishes.
> 
> The DMA Engine document clearly states this.
> 
> "dmaengine_submit() will not start the DMA operation".
> 
> Move HW queuing of the requests into the issue_pending() routine
> to comply with API requirements also create a new queued state for
> temporarily holding the requests.
> 
> A descriptor goes through these transitions now.
> 
> free->prepared->queued->active->completed->free
> 
> as opposed to
> 
> free->prepared->active->completed->free

Applied, thanks

-- 
~Vinod
