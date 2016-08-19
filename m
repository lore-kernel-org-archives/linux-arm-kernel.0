From: vinod.koul@intel.com (Vinod Koul)
Date: Fri, 19 Aug 2016 12:02:24 +0530
Subject: [PATCH] dmaengine: pxa_dma: fix hotchain corner case
In-Reply-To: <1470596509-1726-1-git-send-email-robert.jarzmik@free.fr>
References: <1470596509-1726-1-git-send-email-robert.jarzmik@free.fr>
Message-ID: <20160819063224.GU9681@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Aug 07, 2016 at 09:01:48PM +0200, Robert Jarzmik wrote:
> In the case where a descriptor is chained on a running channel, and as
> explained in the comment in the code 10 lines above, the success of the
> chaining is ensured either if :
>  - the DMA is still running
>  - or if the chained transfer is completed
> 
> Unfortunately the transfer completness test was done on the descriptor
> to which the transfer was chained, and not the transfer being chained at
> the end, ie. hot-chained.
> 
> This corner case is extremely hard to trigger, as usually the DMA chain
> is still running, and the first case takes care of returning success of
> the hot-chaining. It was seen by hot-chaining several "small transfers"
> to a running "big transfer", not in a real-life usecase but by testing
> the robustness of the driver.

Applied, thanks

-- 
~Vinod
