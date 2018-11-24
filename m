From: vkoul@kernel.org (Vinod Koul)
Date: Sat, 24 Nov 2018 20:00:35 +0530
Subject: [PATCH] dma: coh901318: Fix a double-lock bug
In-Reply-To: <20181106033348.27361-1-baijiaju1990@gmail.com>
References: <20181106033348.27361-1-baijiaju1990@gmail.com>
Message-ID: <20181124143035.GJ3175@vkoul-mobl.Dlink>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06-11-18, 11:33, Jia-Ju Bai wrote:
> The function coh901318_alloc_chan_resources() calls spin_lock_irqsave() 
> before calling coh901318_config().
> But coh901318_config() calls spin_lock_irqsave() again in its
> definition, which may cause a double-lock bug.
> 
> Because coh901318_config() is only called by
> coh901318_alloc_chan_resources(), the bug fix is to remove the
> calls to spin-lock and -unlock functions in coh901318_config().

Applied after fixing subsystem tag, thanks
-- 
~Vinod
