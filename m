From: dave.martin@linaro.org (Dave Martin)
Date: Wed, 9 Feb 2011 09:48:26 +0000
Subject: [PATCH 00/14] Fix issues with ARMv6+v6k+v7 kernels
In-Reply-To: <54f225541194205f01fe9f03b5110d16@mail.gmail.com>
References: <20110117192050.GE23331@n2100.arm.linux.org.uk>
	<0557426516de482c1769a50fa0b5f17a@mail.gmail.com>
	<20110208164747.GD6188@n2100.arm.linux.org.uk>
	<78d0134576ace6be5874871076cf0c10@mail.gmail.com>
	<alpine.LFD.2.00.1102081537010.14920@xanadu.home>
	<20110209003537.GQ20795@atomide.com>
	<54f225541194205f01fe9f03b5110d16@mail.gmail.com>
Message-ID: <AANLkTin2zB32YVPZkr48gSOjm0N-WDnZFScysKC8ZTiv@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 9, 2011 at 6:04 AM, Santosh Shilimkar
<santosh.shilimkar@ti.com> wrote:
>> -----Original Message-----
>> From: linux-omap-owner at vger.kernel.org [mailto:linux-omap-
>> owner at vger.kernel.org] On Behalf Of Tony Lindgren
>> Sent: Wednesday, February 09, 2011 6:06 AM
>> To: Nicolas Pitre
>> Cc: Santosh Shilimkar; Russell King - ARM Linux; linux-
>> omap at vger.kernel.org; linux-arm-kernel at lists.infradead.org
>> Subject: Re: [PATCH 00/14] Fix issues with ARMv6+v6k+v7 kernels
>>
>> * Nicolas Pitre <nico@fluxnic.net> [110208 12:41]:
>> > On Tue, 8 Feb 2011, Santosh Shilimkar wrote:
>> >
>> > > > I think it's probably going to be better to _purposely_ break
>> the
>> > > > OMAP build when it covers v6 and v7 CPUs in these kernels as I
>> don't
>> > > > think it's sanely fixable given where we are.
>> >
>> > Agreed. ?At least making SMP unavailable when both v6 and v7 are
>> > configured should be small and good enough for 2.6.38-rc5.
>>
>> That's probably the best solution as then we can still do boot
>> testing on all omap2plus_defconfig boards.
>>
> Just to be clear, are we saying disable SMP from omap2plus build.
> If the v6, v7 is not fixable then, we also need a SMP
> config for OMAP. Just boot test with SMP disable config for
> OMAP4 is not enough.

You could also have a "v7+" unified kernel -- i.e., supporting OMAP3+4+SMP.
This is what we currently do in Linaro, since we're focusing on v7 and above.

Cheers
---Dave
