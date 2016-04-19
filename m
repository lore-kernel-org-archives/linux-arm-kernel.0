From: vinod.koul@intel.com (Vinod Koul)
Date: Tue, 19 Apr 2016 21:03:20 +0530
Subject: [PATCH V2 0/3] dmaengine: bcm2835: support dma channel 11 to 14
In-Reply-To: <1460381349-14408-1-git-send-email-kernel@martin.sperl.org>
References: <1460381349-14408-1-git-send-email-kernel@martin.sperl.org>
Message-ID: <20160419153320.GT2274@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 11, 2016 at 01:29:06PM +0000, kernel at martin.sperl.org wrote:
> From: Martin Sperl <kernel@martin.sperl.org>
> 
> Right now the dma engine officially supports dma channel 11 and 12.
> But the use of dma channel 12 immediately stalls the system.
> 
> The reason is that the interrupt assigned right now to dma channel 11
> is actually a shared interrupt for dma channels 11 to 12.
> So whenever the dma channel 12, 13 or 14 is used, it triggers the interrupt
> for dma 11 which only clears the interrupt flag for dma channel 11.
> This results in the interrupt 11 is triggered all the time.
> 
> On top the requesting dma channel12 (and the corresponding irq) triggers
> an immeditate stall of the system, because for the 12th interrupt
> any dma channel will trigger also this interrupt - even if the dma channel
> is controlled by the firmware.
> 
> As the description in the default device-tree is (for the above reasons)
> wrong a new means had to get devised that allows correct representation
> of the mapping between interrupts and dma channels.
> 
> For this the existing (but unused) device-tree property "interrupt-names"
> is used to define the mapping.
> 
> Implementing shared interrupts is another necessity when using dma channel
> 11 to 14, so it is a part of this patch.

Applied, thanks

-- 
~Vinod
