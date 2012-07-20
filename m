From: vinod.koul@linux.intel.com (Vinod Koul)
Date: Fri, 20 Jul 2012 15:11:25 +0530
Subject: [PATCH V3 1/2] of: Add generic device tree DMA helpers
In-Reply-To: <87y5meu7dv.fsf@free.fr>
References: <1335820679-28721-1-git-send-email-jon-hunter@ti.com>
 <201206271520.49276.arnd@arndb.de> <1342161907.1726.26.camel@vkoul-udesk3>
 <201207171924.33756.arnd@arndb.de> <1342756850.1726.74.camel@vkoul-udesk3>
 <87y5meu7dv.fsf@free.fr>
Message-ID: <1342777285.1726.444.camel@vkoul-udesk3>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2012-07-20 at 11:08 +0200, Robert Jarzmik wrote:
> Vinod Koul <vinod.koul@linux.intel.com> writes:
> 
> >> 4. A dma controller requiring complex configuration:
> >> 
> >>        dma: dmaengine at 48000000 {
> >>                compatible = "foo,foo-sdma"
> >>                reg = <0x48000000 0x1000>;
> >>                interrupts = <4>;
> >>                #dma-cells = <6>; /* phandle, flag, request, channel,
> >> 					 input-width, output-width */
> > Why would we want the widths to be here?
> > Assuming a DMA from System memory to a peripheral, source width should
> > be system memory width and destination the peripheral width. IMO these
> > should not be in dma property even if we need these
> Hi Vinod,
> 
> I know at least one peripheral which accepts 2 widths, 8bit and 16bit, namely the
> M-Systems DiskOnChip G3 NAND chip.
> This device has to configured to choose either 8bit data bus access or 16bit
> data bus access.
That would be configured by the client (peripheral) driver and passed to
dmaengine driver using the slave config. The point is that it has
nothing to do with dma.

> 
> I'm just wondering if that usecase will fit in without the width information
> embedded, and how will the driver choose the width to use ?
It you need, this should be the client property and passed as argument
to dma, not a dma property :)


-- 
~Vinod
