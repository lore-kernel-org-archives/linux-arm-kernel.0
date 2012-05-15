From: vinod.koul@linux.intel.com (Vinod Koul)
Date: Tue, 15 May 2012 14:28:32 +0530
Subject: Cyclic DMA - callback properties and tx_status residue
In-Reply-To: <20120515073712.GE10453@n2100.arm.linux.org.uk>
References: <20120502162702.GE3548@n2100.arm.linux.org.uk>
 <CACRpkdYTpP_nW+CJiJNPLgU6fXtR6ku3-OQaA4ceYtB3ZM5sqQ@mail.gmail.com>
 <20120509093334.GS26481@n2100.arm.linux.org.uk>
 <20120509111614.GH3955@opensource.wolfsonmicro.com>
 <20120509121945.GT26481@n2100.arm.linux.org.uk>
 <1336621458.1540.280.camel@vkoul-udesk3>
 <20120510094205.GM3908@opensource.wolfsonmicro.com>
 <1336647675.15424.390.camel@vkoul-udesk3>
 <20120511140710.GC6220@n2100.arm.linux.org.uk>
 <1337058446.16185.5382.camel@vkoul-udesk3>
 <20120515073712.GE10453@n2100.arm.linux.org.uk>
Message-ID: <1337072312.16185.5400.camel@vkoul-udesk3>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2012-05-15 at 08:37 +0100, Russell King - ARM Linux wrote:
> On Tue, May 15, 2012 at 10:37:26AM +0530, Vinod Koul wrote:
> > On Fri, 2012-05-11 at 15:07 +0100, Russell King - ARM Linux wrote:
> > > On Thu, May 10, 2012 at 04:31:15PM +0530, Vinod Koul wrote:
> > > > This should not be in ASoC library. The driver should be able to detect
> > > > if a tasklet was called for many dma completions and notify the client
> > > > (soc-lib) accordingly.
> > > 
> > > No.  Think about the cyclic case.  How do you correctly record how many
> > > 'periods' have completed so that when your tasklet eventually gets called,
> > > you call its callback the correct number of times?
> > In ISR you can find which descriptors the interupt is for and then use
> > this info in tasklet.
> 
> What descriptors?  With cyclic DMA you only have one descriptor.  Your
> DMA engine may only need to be programmed once to do this too.
My bad mixed my reply to generic case where you can mark descriptor that
interrupt is triggered and later in tasklet call pending notifications.

Said that, nothing prevents the driver from keeping the count of
interrupts and calling the callbacks. BUT it makes no sense in cyclic
case where ALSA wouldn't need this and would need just a notification
and current position.


-- 
~Vinod
