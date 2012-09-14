From: vkoul@infradead.org (Vinod Koul)
Date: Fri, 14 Sep 2012 08:57:59 +0530
Subject: [PATCH v2 03/15] dmaengine: Add no_wakeup parameter to
 dmaengine_prep_dma_cyclic()
In-Reply-To: <20120913153824.GK28448@n2100.arm.linux.org.uk>
References: <1347543485-339-1-git-send-email-peter.ujfalusi@ti.com>
 <1347543485-339-4-git-send-email-peter.ujfalusi@ti.com>
 <5051FB4D.3000009@metafoo.de>
 <20120913153824.GK28448@n2100.arm.linux.org.uk>
Message-ID: <1347593279.1943.27.camel@vkoul-udesk3>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2012-09-13 at 16:38 +0100, Russell King - ARM Linux wrote:
> On Thu, Sep 13, 2012 at 05:27:09PM +0200, Lars-Peter Clausen wrote:
> > Hm... Do you think it would work as well if we implement this by setting the
> > callback for the descriptor to NULL? If the callback is NULL there is
> > nothing to at the end of a transfer/period and the dma engine driver may
> > choose to disable interrupts. This would also benefit non cyclic transfers
> > where the callback is NULL and we do not need add the new parameter to
> > dmaengine_prep_dma_cyclic.
> 
> Actually, there's a way to do that already.  DMA_PREP_INTERRUPT.
> Unfortunately, most DMA engine slave API users don't set it when they
> setup their transfer:
> 
>  * @DMA_PREP_INTERRUPT - trigger an interrupt (callback) upon completion of
>  *  this transaction
Looks like I have repeated the correct action!
> 
> if we fixed that, then we could use the lack of it to avoid the interrupt.
> 
> However, cyclic transfers don't have the flags parameter used to pass this
> bit.  Yet another bit of yucky inconsistent design in DMA engine land...
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
