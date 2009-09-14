From: felipe.contreras@gmail.com (Felipe Contreras)
Date: Mon, 14 Sep 2009 03:11:23 +0300
Subject: 'bx lr' vs 'mov pc,lr'
In-Reply-To: <20090913230103.GD30169@n2100.arm.linux.org.uk>
References: <94a0d4530909131455x7a33cbaaw402642fb2e63c6d6@mail.gmail.com>
	<20090913221500.GB5398@digital-scurf.org>
	<94a0d4530909131556j49824b84ubddc13237f2d0bdd@mail.gmail.com>
	<20090913230103.GD30169@n2100.arm.linux.org.uk>
Message-ID: <94a0d4530909131711p63dabe95j3cff160e2656bb69@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 14, 2009 at 2:01 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Mon, Sep 14, 2009 at 01:56:16AM +0300, Felipe Contreras wrote:
>> On Mon, Sep 14, 2009 at 1:15 AM, Daniel Silverstone
>> <dsilvers@simtec.co.uk> wrote:
>> > On Mon, Sep 14, 2009 at 12:55:24AM +0300, Felipe Contreras wrote:
>> >> I noticed that in 'arch/arm/lib/delay.S' we are using 'mov pc, lr'
>> >> instead of 'bx lr'. Why? It looks like 'mov pc, lr' is used all over
>> >> the place, but I can't find out what's the reason.
>> >
>> > I'd guess at the reason being that not all ARM processors whose ports use
>> > arch/arm/lib/delay.S support the bx instruction, whereas the 'mov pc, lr'
>> > instruction is universally supported.
>>
>> Are there really processors that don't support 'bx'? Can you give some examples?
>
> Any ARMv3 CPU and any ARMv4 which doesn't support Thumb. ?Eg, StrongARM.

Ok. Thanks.

-- 
Felipe Contreras
