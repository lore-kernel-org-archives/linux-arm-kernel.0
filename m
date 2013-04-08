From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 8 Apr 2013 18:09:56 +0100
Subject: [RFC v2] dmaengine: omap-dma: Start DMA without delay for
 cyclic channels
In-Reply-To: <51626D88.8020809@ti.com>
References: <1364987862-14597-1-git-send-email-peter.ujfalusi@ti.com>
 <51626D88.8020809@ti.com>
Message-ID: <20130408170956.GX30923@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 08, 2013 at 09:11:04AM +0200, Peter Ujfalusi wrote:
> Russell,
> 
> On 04/03/2013 01:17 PM, Peter Ujfalusi wrote:
> > cyclic DMA is only used by audio which needs DMA to be started without a
> > delay.
> > If the DMA for audio is started using the tasklet we experience random
> > channel switch (to be more precise: channel shift).
> > 
> > Reported-by: Peter Meerwald <pmeerw@pmeerw.net>
> > Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> > ---
> > Hi Russell,
> > 
> > Instead of removing the tasklet we can identify the DMA channel used by audio
> > based on the cyclic flag of the channel.
> > I think this can be used as a short term solution to fix the audio channel shift
> > issue and later when we have the dynamic DMA channel allocation we can adjust
> > the code.
> 
> Could you, please look at this patch?

Now that I'm back from a short 4 day break, then yes, and the answer is
that it's fine.  Who's handling the patch?
