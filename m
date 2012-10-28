From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Sun, 28 Oct 2012 09:41:05 +0530
Subject: [PATCH] i2c: omap: ensure writes to dev->buf_len are ordered
In-Reply-To: <alpine.DEB.2.00.1210271545390.16409@utopia.booyaka.com>
References: <1351155648-20429-1-git-send-email-balbi@ti.com>
 <alpine.DEB.2.00.1210262251020.11258@utopia.booyaka.com>
 <508BBC59.60504@ti.com>
 <alpine.DEB.2.00.1210271545390.16409@utopia.booyaka.com>
Message-ID: <508CB059.8000203@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 27 October 2012 09:29 PM, Paul Walmsley wrote:
> On Sat, 27 Oct 2012, Santosh Shilimkar wrote:
>
>> Another alternative, which I will recommend to just make use of the
>> read*/wrire* instead __raw versions. The barriers are taken care
>> already and driver point of view, it is transparent.
>
> Those barriers will disappear if CONFIG_ARM_DMA_MEM_BUFFERABLE is set to
> N, so that's probably not the right thing to do in this case.  The barrier
> here isn't DMA-related, it's needed due to the design of the driver.
>
Good point.

> In fact the wmb() is probably overkill, since only a compiler reordering
> barrier is needed.  It can probably just be barrier().
>
I agree. Just barrier() is enough to avoid compiler re-ordering.

Regards
Santosh
