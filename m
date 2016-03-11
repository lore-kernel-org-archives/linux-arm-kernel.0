From: vinod.koul@intel.com (Vinod Koul)
Date: Fri, 11 Mar 2016 11:23:56 +0530
Subject: [PATCH v3 04/11] ARM: bcm2835: dt: add bindings for shared
 interrupt properties
In-Reply-To: <3503D512-7E9C-46E8-91C7-CAD828DD48D1@martin.sperl.org>
References: <1457175142-28665-1-git-send-email-kernel@martin.sperl.org>
 <1457175142-28665-5-git-send-email-kernel@martin.sperl.org>
 <87fuw1yipi.fsf@eliezer.anholt.net>
 <3503D512-7E9C-46E8-91C7-CAD828DD48D1@martin.sperl.org>
Message-ID: <20160311055356.GM11154@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 08, 2016 at 12:23:51PM +0100, Martin Sperl wrote:
> 
> > On 08.03.2016, at 00:24, Eric Anholt <eric@anholt.net> wrote:
> > 
> > kernel at martin.sperl.org writes:
> > 
> >> From: Martin Sperl <kernel@martin.sperl.org>
> >> 
> >> Add binding documentation for the new shared interrupt properties:
> >> * brcm,dma-channel-shared-mask
> >> * brcm,dma-shared-irq-index
> >> 
> >> Signed-off-by: Martin Sperl <kernel@martin.sperl.org>
> >> ---
> >> Documentation/devicetree/bindings/dma/brcm,bcm2835-dma.txt | 6 ++++++
> >> 1 file changed, 6 insertions(+)
> >> 
> >> diff --git a/Documentation/devicetree/bindings/dma/brcm,bcm2835-dma.txt b/Documentation/devicetree/bindings/dma/brcm,bcm2835-dma.txt
> >> index 1396078..f9e84ee 100644
> >> --- a/Documentation/devicetree/bindings/dma/brcm,bcm2835-dma.txt
> >> +++ b/Documentation/devicetree/bindings/dma/brcm,bcm2835-dma.txt
> >> @@ -17,6 +17,10 @@ Required properties:
> >> - brcm,dma-channel-mask: Bit mask representing the channels
> >> 			 not used by the firmware in ascending order,
> >> 			 i.e. first channel corresponds to LSB.
> >> +- brcm,dma-channel-shared-mask: Bit mask representing the channels
> >> +				that use a shared interrupt
> >> +- brcm,dma-shared-irq-index: index of which of the interrupts mentioned
> >> +			     above is the shared interrupt
> > 
> > This should be under "Optional properties" since there are appropriate
> > defaults for the only compatible string listed.
> 
> Well - IMO it is actually required and the defaults are only for backwards
> compatibility with older device-trees, but that is easy to change?
> > 
> > I still don't think exposing this in the DT is necessary (it's hardware
> > block internals), but I'm not writing the code so I'm fine with it
> Actually this was a request by Vinod to make this configurable via the
> device-tree.

DT needs to provide the hardware details for driver to work across
generations. Driver needs to get information like this to make decisions and
not hard code and make driver not scale..

> 
> > either way, really.  Regardless, it would be really good to get the
> > slave_sg part of the series in, which is really important for the
> > platform.
> Yes, then we can bring the DMA implementations for mmc/sdhost forward.
> 
> Martin
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe dmaengine" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
~Vinod
