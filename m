From: vinod.koul@intel.com (Vinod Koul)
Date: Tue, 7 Jun 2016 12:51:21 +0530
Subject: [PATCH] dmaengine: bcm2835: Fix polling for completion of DMA
 with interrupts masked.
In-Reply-To: <87k2i1leap.fsf@eliezer.anholt.net>
References: <1465007351-5559-1-git-send-email-eric@anholt.net>
 <20160606042635.GU16910@localhost>
 <87a8iy6x41.fsf@eliezer.anholt.net>
 <20160607052405.GC16910@localhost>
 <87k2i1leap.fsf@eliezer.anholt.net>
Message-ID: <20160607072121.GM16910@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 06, 2016 at 11:10:38PM -0700, Eric Anholt wrote:
> >> >> -	if (ret == DMA_COMPLETE || !txstate)
> >> >> +	if (ret == DMA_COMPLETE)
> >> >
> >> > Why do you change this? txstate can be NULL, so no point calculating reside
> >> > for those cases
> >> 
> >> The point was to go into the "Calculate where we're at in our current
> >> DMA (if the current DMA is the one we're asking about status for)" path,
> >> so that we could note when the DMA is complete even when there's no
> >> txstate passed in.
> >
> > Can you explain what you mean by current DMA!
> >
> > The claulation is always done for 'descriptor' represnted by the cookie. So
> > it doesnt not matter...!
> 
> By current I mean the current descriptor that has been submitted to the
> hardware, in bcm2835_chan->desc.

As I said, you calculate for the descriptor respresnted by cookie and
not the one getting processed!

-- 
~Vinod
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160607/e5143195/attachment.sig>
