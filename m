From: zach.pfeffer@linaro.org (Zach Pfeffer)
Date: Tue, 14 Jun 2011 13:58:25 -0500
Subject: [Linaro-mm-sig] [PATCH 08/10] mm: cma: Contiguous Memory
	Allocator added
In-Reply-To: <20110614170158.GU2419@fooishbar.org>
References: <1307699698-29369-1-git-send-email-m.szyprowski@samsung.com>
	<201106141549.29315.arnd@arndb.de>
	<op.vw2jmhir3l0zgt@mnazarewicz-glaptop>
	<201106141803.00876.arnd@arndb.de>
	<20110614170158.GU2419@fooishbar.org>
Message-ID: <BANLkTi=cJisuP8=_YSg4h-nsjGj3zsM7sg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14 June 2011 12:01, Daniel Stone <daniels@collabora.com> wrote:
> Hi,
>
> On Tue, Jun 14, 2011 at 06:03:00PM +0200, Arnd Bergmann wrote:
>> On Tuesday 14 June 2011, Michal Nazarewicz wrote:
>> > On Tue, 14 Jun 2011 15:49:29 +0200, Arnd Bergmann <arnd@arndb.de> wrote:
>> > > Please explain the exact requirements that lead you to defining multiple
>> > > contexts.
>> >
>> > Some devices may have access only to some banks of memory. ?Some devices
>> > may use different banks of memory for different purposes.
>>
>> For all I know, that is something that is only true for a few very special
>> Samsung devices, and is completely unrelated of the need for contiguous
>> allocations, so this approach becomes pointless as soon as the next
>> generation of that chip grows an IOMMU, where we don't handle the special
>> bank attributes. Also, the way I understood the situation for the Samsung
>> SoC during the Budapest discussion, it's only a performance hack, not a
>> functional requirement, unless you count '1080p playback' as a functional
>> requirement.

Coming in mid topic...

I've seen this split bank allocation in Qualcomm and TI SoCs, with
Samsung, that makes 3 major SoC vendors (I would be surprised if
Nvidia didn't also need to do this) - so I think some configurable
method to control allocations is necessarily. The chips can't do
decode without it (and by can't do I mean 1080P and higher decode is
not functionally useful). Far from special, this would appear to be
the default.

> Hm, I think that was something similar but not quite the same: talking
> about having allocations split to lie between two banks of RAM to
> maximise the read/write speed for performance reasons. ?That's something
> that can be handled in the allocator, rather than an API constraint, as
> this is.
>
> Not that I know of any hardware which is limited as such, but eh.
>
> Cheers,
> Daniel
>
> _______________________________________________
> Linaro-mm-sig mailing list
> Linaro-mm-sig at lists.linaro.org
> http://lists.linaro.org/mailman/listinfo/linaro-mm-sig
>
