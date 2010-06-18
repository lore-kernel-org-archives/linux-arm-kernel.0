From: eric.miao@canonical.com (Eric Miao)
Date: Fri, 18 Jun 2010 10:30:54 +0800
Subject: [PATCH 0/5] Makefile.boot cleanup
In-Reply-To: <alpine.LFD.2.00.1006171203030.13427@xanadu.home>
References: <1275550613-9553-1-git-send-email-eric.miao@canonical.com>
	<20100603075704.GB336@pengutronix.de>
	<alpine.LFD.2.00.1006171203030.13427@xanadu.home>
Message-ID: <AANLkTinhQgeEXHnlYVtbGrPpPGDeW34ZT_c_tyI--hGM@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2010/6/18 Nicolas Pitre <nico@fluxnic.net>:
> On Thu, 3 Jun 2010, Uwe Kleine-K?nig wrote:
>
>> Hello Eric,
>>
>> On Thu, Jun 03, 2010 at 03:36:48PM +0800, Eric Miao wrote:
>> > Several facts:
>> >
>> > 1. ZRELADDR in most cases can be auto detected by maksing PC with
>> > ? ?0xf000_0000 if the zImage is placed within the first 256MiB from
>> > ? ?the memory start, which is a sane assumption except for:
>> >
>> > ? ?- when ARCH_MX1 or ARCH_SHARK is defined
>> > ? ?- when ARCH_U300 is defined (U300 really is strange when defining
>> > ? ? ?PHYS_OFFSET and ZRELADDR)
>> > ? ?- or when ZBOOT_ROM is defined
>> If you guess ZRELADDR based on sp instead of pc it even should work if
>> ZBOOT_ROM is defined?!
>
> What is the relation between sp and ZRELADDR?
>
> While we're pushing forward the notion of a relation between phys offset
> and the location where zImage is loaded in memory, I think that making
> the association with sp is a bit too obscur. ?Knowing where you upload
> your kernel is clear, knowing where the stack is allocated in relation
> to that is not that clear. ?It is in the .bss section of course, but
> when ZBOOT_ROM is not defined then the .bss happens to be right after
> the zImage binary, while it must be explicitly specified otherwise.
>

I agree with Nico. Associating PHYS_OFFSET with pc is more straight-forward,
and I think it will save us some effort just not to support a runtime
phys_offset
with ZBOOT enabled.
