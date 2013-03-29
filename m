From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 29 Mar 2013 17:31:00 +0000
Subject: [RFC] dmaengine: omap-dma: Start DMA without delay
In-Reply-To: <1364566323-24144-1-git-send-email-peter.ujfalusi@ti.com>
References: <1364566323-24144-1-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <20130329173100.GV30923@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 29, 2013 at 03:12:03PM +0100, Peter Ujfalusi wrote:
> Remove the use of a tasklet to start the DMA channel when issue_pending is
> called.
> The use of tasklet delays the DMA start which can cause issues at drivers,
> for example the audio drivers expect that the DMA is started right away.
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> ---
> Hi Russell,
> 
> I know you are against removing the tasklet since you have planed to move the
> omap-dma to use runtime/dynamic DMA channel use.
> I have looked at the amba-pl08x.c driver which is doing that exactly (as you
> pointed out that to me). AMBA did not use tasklet either and I'm sure we can
> change the omap-dma driver to do the same in a same way as we could have done it
> with the tasklet use.

It's rather sad that you're ignoring what I'm saying, and going by what
another DMA engine driver - which is self contained - is doing, rather
than listening to my arguments against that approach.

I think in return I'll just ignore this patch, showing you the same
respect you show me.  Congratuations.
