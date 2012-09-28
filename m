From: santosh.shilimkar@ti.com (Shilimkar, Santosh)
Date: Fri, 28 Sep 2012 12:11:00 +0530
Subject: [GIT PULL] ARM: cache flushing LoUIS API
In-Reply-To: <20120927161552.GA5001@e102568-lin.cambridge.arm.com>
References: <20120925125758.GA16842@e102568-lin.cambridge.arm.com>
 <20120927114805.GC14358@n2100.arm.linux.org.uk>
 <20120927161552.GA5001@e102568-lin.cambridge.arm.com>
Message-ID: <CAMQu2gy1ZDXbpJH2hk4fnPMdFgqA4cqb5XnN1Q1=_7jdC0XP3w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Lorenzo,

On Thu, Sep 27, 2012 at 9:45 PM, Lorenzo Pieralisi
<lorenzo.pieralisi@arm.com> wrote:
> [CC'ed Shawn to test T2 on iMX]
>
> On Thu, Sep 27, 2012 at 12:48:05PM +0100, Russell King - ARM Linux wrote:
>> On Tue, Sep 25, 2012 at 01:57:58PM +0100, Lorenzo Pieralisi wrote:
>> > Hi Russell,
>> >
>> > I know it is coming quite late in the cycle but please consider pulling
>> > the patch series implementing the new cache maintenance LoUIS API, since
>> > it provides a stepping stone to implementing power management on upcoming
>> > A15 and A7 based platforms, leaving functionality for earlier processor
>> > versions unchanged.
>> >
>> > It has been tested on:
>> >
>> > - OMAP4/5
>> >   # suspend/hotplug and CPU idle
>> > - iMX6q
>> >   # suspend and hotplug
>> > - TC2 big.LITTLE testchip
>> >   # CPU idle
>>
>> Ok, last night's PXA build regressed with this:
>>
>> arch/arm/mm/built-in.o: In function `xscale_dma_unmap_area':
>> cache-xsc3l2.c:(.text+0x4194): undefined reference to `xscale_80200_A0_A1_flush_kern_cache_louis'
>>
>> That's because we missed that proc-xscale.S aliases a bunch of functions to
>> xscale_80200_A0_A1_xxx from xscale_xxx.  And looking at that, it seems that
>> we also .type equivalent symbols - have you tested this on T2 builds to
>> check whether it works correctly there?
>
> Tested T2 build on TC2 testchip and everything seems to be working fine.
>
> Santosh, Shawn, can you give T2 a go on OMAP and iMX6 please ?
>
Tested OMAP4/5 with T2 build and CPU power tests continue to work. All good.
Note that for T2 build I need to take out OMAP2 devices from the build which
are based of ARM_v6.

Regards
Santosh
