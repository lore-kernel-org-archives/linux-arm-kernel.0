From: tony@atomide.com (Tony Lindgren)
Date: Mon, 8 Apr 2013 10:15:19 -0700
Subject: [RFC v2] dmaengine: omap-dma: Start DMA without delay for
 cyclic channels
In-Reply-To: <20130408170956.GX30923@n2100.arm.linux.org.uk>
References: <1364987862-14597-1-git-send-email-peter.ujfalusi@ti.com>
 <51626D88.8020809@ti.com>
 <20130408170956.GX30923@n2100.arm.linux.org.uk>
Message-ID: <20130408171519.GP10155@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Russell King - ARM Linux <linux@arm.linux.org.uk> [130408 10:15]:
> On Mon, Apr 08, 2013 at 09:11:04AM +0200, Peter Ujfalusi wrote:
> > Russell,
> > 
> > On 04/03/2013 01:17 PM, Peter Ujfalusi wrote:
> > > cyclic DMA is only used by audio which needs DMA to be started without a
> > > delay.
> > > If the DMA for audio is started using the tasklet we experience random
> > > channel switch (to be more precise: channel shift).
> > > 
> > > Reported-by: Peter Meerwald <pmeerw@pmeerw.net>
> > > Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> > > ---
> > > Hi Russell,
> > > 
> > > Instead of removing the tasklet we can identify the DMA channel used by audio
> > > based on the cyclic flag of the channel.
> > > I think this can be used as a short term solution to fix the audio channel shift
> > > issue and later when we have the dynamic DMA channel allocation we can adjust
> > > the code.
> > 
> > Could you, please look at this patch?
> 
> Now that I'm back from a short 4 day break, then yes, and the answer is
> that it's fine.  Who's handling the patch?

I suggest Peter resend the patch with also Grant + Linus W cc:d so
they can queue it unless there are other related patches pending
somewhere else.

Regards,

Tony
