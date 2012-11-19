From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Mon, 19 Nov 2012 11:00:15 +0100
Subject: [RFC] dmaengine: omap-dma: Allow DMA controller to prefetch data
In-Reply-To: <20121117113159.GM3332@n2100.arm.linux.org.uk>
References: <20121018222046.GA28541@animalcreek.com>
 <20121018225540.GB28061@n2100.arm.linux.org.uk>
 <20121018232405.GA29064@animalcreek.com>
 <20121018233335.GC28061@n2100.arm.linux.org.uk> <50814B83.7090203@ti.com>
 <20121117113159.GM3332@n2100.arm.linux.org.uk>
Message-ID: <50AA032F.1010102@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/17/2012 12:31 PM, Russell King - ARM Linux wrote:
> On Fri, Oct 19, 2012 at 02:45:55PM +0200, P?ter Ujfalusi wrote:
>> Hi,
>>
>> On 10/19/2012 01:33 AM, Russell King - ARM Linux wrote:
>>> I'm merely pointing out here that we need their feedback here before
>>> deciding if there's anything further that needs to happen.
>>
>> Thanks Russell, I'll take a look at the implication of the prefetch for audio.
> 
> P?ter, any news?

Sorry, I was carried away with other things...
I did some testing with and without the dma prefetch for audio (on BeagleBoard
with mplayer: -ao alsa/pulse).
When we have prefetch enabled we tend to resume after pause from a slightly
off place than when the prefetch is disabled.
I also remember that in n9 we have had some issue with the DMA prefetch.

So I would for sure enable the prefetch for non cyclic DMA.
For the cyclic I would not enable it for now. I need to dig a bit deeper in
DMA/McBSP to have better view on the issue.

I have one comment to the patch itself as well.

-- 
P?ter
