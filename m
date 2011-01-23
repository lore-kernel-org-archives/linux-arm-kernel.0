From: eric.y.miao@gmail.com (Eric Miao)
Date: Mon, 24 Jan 2011 07:05:05 +0800
Subject: [PATCH 1/2] ARM: calculate VMALLOC_END by probing in
	mdesc->map_io()
In-Reply-To: <20110123143408.GA30094@n2100.arm.linux.org.uk>
References: <1295737001-19578-1-git-send-email-eric.y.miao@gmail.com>
	<20110122231528.GD11960@n2100.arm.linux.org.uk>
	<AANLkTikkiMKseQznf99p3uiL4he_P3TyGLx0XOPuZgHs@mail.gmail.com>
	<alpine.LFD.2.00.1101230918340.8580@xanadu.home>
	<20110123143408.GA30094@n2100.arm.linux.org.uk>
Message-ID: <AANLkTim7qrCR+mm5rRyJ9tyD1c9m5UwsuGt1fNaBX2fU@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jan 23, 2011 at 10:34 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Sun, Jan 23, 2011 at 09:21:19AM -0500, Nicolas Pitre wrote:
>> On Sun, 23 Jan 2011, Eric Miao wrote:
>>
>> > > I'd instead suggest adding vmalloc_end to the machine description
>> > > record.
>> > >
>> >
>> > And since all boards sharing a same machine_class is going to use
>> > the same value, I'd rather we first introduce struct machine_class
>> > like in the patch I posted months ago?
>>
>> Another way to look at it is to move vmalloc_end and the like into each
>> machine record now, and look at the machine class changes afterwards
>> with a better view of all that might be consolidated at that point.
>
> The machine class stuff is only worthwhile if it results in a net
> reduction in complexity. ?I don't remember whether the previous set
> of patches for this showed any platforms being converted - searching
> the list archives seems to suggest not.
>
> While the simpler platforms seem to have (eg) their .map_io in a class
> pointing at the same function, more complex platforms tend to have it
> pointing at board-level functions. ?Same goes for the .init_irq
> function.
>
> I don't think there's a clear-cut case where this approach will result
> in a net reduction of complexity. ?I suspect it might actually end up
> making things more complicated.
>
> What I'm basically saying is that I'd like to see the effect of having
> existing board stuff converted over to show whether this is worthwhile
> or not.
>

OK, that makes sense.
