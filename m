From: brian@walsh.ws (Brian Walsh)
Date: Tue, 29 Sep 2009 11:16:02 -0400
Subject: ixp4xx dmabounce
In-Reply-To: <20090927165531.GC20093@n2100.arm.linux.org.uk>
References: <a104b22c0909171402x10c06d41oa5c78065a65836e1@mail.gmail.com>
	<20090917215302.GA14939@n2100.arm.linux.org.uk>
	<a104b22c0909221502l621ec9e9ia02cb524479c4476@mail.gmail.com>
	<20090927165531.GC20093@n2100.arm.linux.org.uk>
Message-ID: <a104b22c0909290816q1ad1ed06hc481f01307c19dd7@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Sep 27, 2009 at 12:55 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Tue, Sep 22, 2009 at 06:02:19PM -0400, Brian Walsh wrote:
>> On Thu, Sep 17, 2009 at 5:53 PM, Russell King - ARM Linux
>> <linux@arm.linux.org.uk> wrote:
>> >
>> > On Thu, Sep 17, 2009 at 05:02:59PM -0400, Brian Walsh wrote:
>> > > Any ideas or suggestions?
>> >
>> > It's caused because we don't allow dma_free_coherent() to be called from
>> > IRQ context (which is reasonable because it needs to flush TLBs across
>> > all processors on SMP systems.)
>>
>> I am not running on an SMP system so would this even be a problem?
>
> Yes - because it's there to ensure that the API is used in a consistent
> way.

Right, I was just referring to it being a problem in my specific
situation not in the
general case.

>
>> > Unfortunately, with the DMA bounce code enabled, this function does get
>> > called from IRQ context, and so tends to spit out these warnings.
>> >
>> > I did have a patch which made dma_free_coherent() lazy, but it was
>> > reported that the suffered disk corruption (though it was never
>> > conclusive whether it was caused by the patch or not.) ?Here's an
>> > updated version of that patch.
>> >
>>
>> I did not see any data rate improvement using this patch over just commenting
>> out the warning stack dump.? I am still seeing about half the data transfer rate
>> using the high speed ehci USB controller over the full speed ohci USB
>> controller.
>
> I didn't suggest it would improve the data rate - only that it should
> fix the stack dump.
>
> I'd really like to get this patch properly tested and confirmed that it
> does _not_ actually cause corruption, so that I can get it merged.
>

I will be able to help you test this patch once I get past this issue
I am dealing with.
