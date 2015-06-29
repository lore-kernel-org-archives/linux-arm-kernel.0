From: mike.looijmans@topic.nl (Mike Looijmans)
Date: Mon, 29 Jun 2015 15:08:48 +0200
Subject: dma-mapping: support for DMA_ATTR_NON_CONSISTENT DMA attribute
In-Reply-To: <20150629094557.GY7557@n2100.arm.linux.org.uk>
References: <CAF6-1L5c-PbK_wfpvz1xdRkquXyuQDv4mvKfYp8fwA1LK9ZOyw@mail.gmail.com>
 <20150628224543.GW7557@n2100.arm.linux.org.uk>
 <CAF6-1L4g0W6kboZt52fHBUPxGYWYn9-9vmm=0-WQVv1-YdfOEA@mail.gmail.com>
 <5590E962.4020700@topic.nl> <20150629094557.GY7557@n2100.arm.linux.org.uk>
Message-ID: <55914360.6050709@topic.nl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 29-06-15 11:45, Russell King - ARM Linux wrote:
> On Mon, Jun 29, 2015 at 08:44:50AM +0200, Mike Looijmans wrote:
>> ?On 29-06-15 07:24, Sylvain Munaut wrote:
>>> """ By using this API, you are guaranteeing to the platform that you
>>> have all the correct and necessary sync points for this memory in the
>>> driver should it choose to return non-consistent memory."""
>>>
>>> I had assumed it was the dma_sync_* calls, but apparently not.
>>
>> I think the answer is "the dma_sync_* calls plus whatever it is your DMA
>> controller hardware needs to do"
>
> No it is not.  When something is clearly the wrong API, you do not go
> around telling people to use it.  I'm pretty disgusted that you think
> that is an appropraite way to behave.

I trying to merely refer to the "correct and necessary sync points" part, once 
the decision to (properly) use the streaming API has been made.

To the best of my knowledge, the dma_sync_... methods take care of things from 
the ARM (CPU) side.

That leaves only the device side, you need to make sure that for example its 
FIFOs are empty before starting to flush caches. Something that the API cannot 
do for you, but your driver and hardware (or logic in the case of a Zynq) must 
do a proper job too.

Saying something about those things would make the documentation a lot less 
cryptic than just dropping a "correct and necessary sync points" bomb into the 
text and then offering no advise on where one could hope to find some clay 
tablets with engravings explaining what is "correct and necessary".

M.
