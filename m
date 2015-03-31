From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Tue, 31 Mar 2015 19:48:03 +0300
Subject: [PATCH v3 1/7] dmaengine: of_dma: Support for DMA routers
In-Reply-To: <201503280244.46961.arnd@arndb.de>
References: <1427459213-14611-1-git-send-email-peter.ujfalusi@ti.com>
 <1427459213-14611-2-git-send-email-peter.ujfalusi@ti.com>
 <201503280244.46961.arnd@arndb.de>
Message-ID: <551ACFC3.5020003@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/28/2015 03:44 AM, Arnd Bergmann wrote:
> On Friday 27 March 2015, Peter Ujfalusi wrote:
>> +Required property:
>> +- dma-device:          phandle of the DMA controller. The router is modifying
>> +                       the DMA requests for this controller.
> 
> This property seems rather specific to the case at hand, I would expect that
> one might also see routers like this that are connected to more than one
> dma-device, so maybe make it a list?

Yeah, it is intentional from my part.
In dra7xx family we actually have two DMA controllers: sDMA and eDMA. They
both have identical crossbar up front but you can not choose the DMA request
to be routed to either eDMA or sDMA. They are always routed to both and in the
crossbar you select which signal goes to which DMA request of the given
controller.
At the moment I was not aware of different designs (current and future), but
it might be possible that a design you described might surface at some point.
For sure, the list will complicate things quite a bit it might require
different API and callbacks at the end. I need to think about this how it is
going to work best.

> It might also be better to name this as 'dma-controllers' or 'dma-masters',
> as it is not entirely obvious (without referencing the binding document)
> whether a dma device refers to the slave or the master.

I think the 'dma-masters' sounds much better.

PS: I'm out of office this week so do not expect v4 before mid next week.

-- 
P?ter
