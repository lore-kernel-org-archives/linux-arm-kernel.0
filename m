From: david@lechnology.com (David Lechner)
Date: Mon, 9 Jan 2017 14:40:50 -0600
Subject: [RESEND] spi: davinci: Allow device tree devices to use DMA
In-Reply-To: <20170109194811.p3if5pzvjjaez2g3@sirena.org.uk>
References: <1483673177-31516-1-git-send-email-david@lechnology.com>
 <20170109194811.p3if5pzvjjaez2g3@sirena.org.uk>
Message-ID: <dc47ecd2-fb94-ef7c-af15-590b2233e79f@lechnology.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/09/2017 01:48 PM, Mark Brown wrote:
> On Thu, Jan 05, 2017 at 09:26:17PM -0600, David Lechner wrote:
>
>> This allows SPI devices specified in a device tree to use DMA when the
>> master controller.
>
>> Since device tree is supposed to only describe the hardware, adding such
>> a configuration option to device tree would not be acceptable. So, this
>> is the best we can do for now to get SPI devices working with DMA.
>
>> Unfortunately, this excludes the possibility of using one SPI device with
>> DMA and one without on the same master.
>
> Why would you ever want to do that?  What would ever make sense about
> not using DMA if it's available and the transfer is suitably large, or
> conversely why would one want to force DMA even if PIO would be more
> performant?

I don't particularly want to do that, but that is the way the 
spi-davinci driver currently works. The choice between DMA or PIO is 
specified in the platform data on a per-device basis.

What I get from your remarks is that this is wrong and it needs to be 
fixed. If that is so, could someone please point out a driver that does 
it the right way and I will try to fix it.


>
>> When I originally submitted this patch, there was some discussion as to whether
>> dspi->dma_rx should be changed to return an error rather than being null.
>
>> However, I prefer it the way it is and don't see a compelling reason to change
>> it.
>
> I don't know what the above comment means, sorry (and don't recall
> having seen any earlier versions of this).
>

FWIW, you can find the previous conversation at 
https://patchwork.kernel.org/patch/9437901/
