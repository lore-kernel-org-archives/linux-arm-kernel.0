From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 25 Jan 2012 10:56:00 +0000
Subject: Making allyesconfig work
In-Reply-To: <alpine.LFD.2.02.1201201742070.19587@xanadu.home>
References: <20120120115108.GJ1068@n2100.arm.linux.org.uk>
 <20120120120856.GC30612@arm.com>
 <20120120122402.GN1068@n2100.arm.linux.org.uk>
 <20120120145346.GE30612@arm.com>
 <alpine.LFD.2.02.1201201742070.19587@xanadu.home>
Message-ID: <CAHkRjk4yFKc6FgsYQLCNQuVO0h4nNGw+-z67Wjh6mCNqam1WBw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20 January 2012 22:43, Nicolas Pitre <nico@fluxnic.net> wrote:
> On Fri, 20 Jan 2012, Catalin Marinas wrote:
>> On Fri, Jan 20, 2012 at 12:24:02PM +0000, Russell King - ARM Linux wrote:
>> > On Fri, Jan 20, 2012 at 12:08:56PM +0000, Catalin Marinas wrote:
>> > > On Fri, Jan 20, 2012 at 11:51:08AM +0000, Russell King - ARM Linux wrote:
>> > > > There's also the troublesome T() macro, which conflicts with a bunch
>> > > > of other drivers. ?(I've added Catalin to the To: line for this
>> > > > reason.)
>> > >
>> > > This macro is used in asm/uaccess.h and asm/futex.h, so I think it would
>> > > be difficult to hide it completely. But I'm happy to rename it to
>> > > something else (IIRC, T stands for "Translated").
>> >
>> > We should do something, because T() is just too risky for causing these
>> > kinds of conflicts.
>>
>> Here's a patch. For lack of inspiration, I called it TUSER (and grep'ed
>> the kernel, there isn't other reference to such name).
>
> To be on the safe side, you could even call it ARM_TUSER.

I thought about making it longer but some asm code becomes uglier with
so many characters.

> In any case:
>
> Acked-by: Nicolas Pitre <nico@linaro.org>

Thanks.

-- 
Catalin
