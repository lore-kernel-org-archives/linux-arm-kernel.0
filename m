From: vinod.koul@intel.com (Vinod Koul)
Date: Mon, 23 Apr 2018 10:53:17 +0530
Subject: [RFC 4/6] dmaengine: xilinx_dma: Freeup active list based on
 descriptor completion bit
In-Reply-To: <BN6PR02MB3282D60BCF6A4B40BCC7A5B8C7B70@BN6PR02MB3282.namprd02.prod.outlook.com>
References: <1522665546-10035-1-git-send-email-radheys@xilinx.com>
 <1522665546-10035-5-git-send-email-radheys@xilinx.com>
 <20180411091102.GZ6014@localhost>
 <BN6PR02MB3282D60BCF6A4B40BCC7A5B8C7B70@BN6PR02MB3282.namprd02.prod.outlook.com>
Message-ID: <20180423052317.GZ6014@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 17, 2018 at 12:28:52PM +0000, Radhey Shyam Pandey wrote:

> > > +		if ((seg->hw.status & XILINX_DMA_COMP_MASK) ||
> > > +			(!chan->xdev->has_axieth_connected)) {
> > 
> > why the second case ? That is not expalined in log?
> In the current implementation, delay timeout is enabled only for
> has_axieth_connected usecase. For ethernet, we need real-time processing
> while still having benefit of interrupt coalescing. Example: In RX interrupt
> coalescing is set to 0x3.  Without delay timeout, DMA engine will wait for
> all frames and then issue completion interrupt. In ethernet usecase, this
> can introduce huge latencies. Delay timeout interrupt will trigger if delay
> time period has expired and we can notify dma client with received frames.
> 
> The second case is added to keep the previous implementation as is.(i.e when
> Delay timeout interrupt is not enabled - move all active desc to done list). 
> Sure I will add a description for it in the commit log.

That should help, it didn't seem to have anything to do with log or other
changes, please keep in mind again that changelog should describe the change
and help ppl review...

-- 
~Vinod
