From: m.nazarewicz@samsung.com (=?utf-8?B?TWljaGHFgiBOYXphcmV3aWN6?=)
Date: Wed, 20 Jan 2010 15:54:22 +0100
Subject: [PATCH/RFC v1 0/2] Human readable performance event	description in
	sysfs
In-Reply-To: <1263996979.4283.1066.camel@laptop>
References: <1263978706-15499-1-git-send-email-t.fujak@samsung.com>
	<1263978999.4283.823.camel@laptop> <op.u6tslipz7p4s8u@pikus>
	<20100120133145.GE4089@wear.picochip.com>
	<1263994779.4283.1057.camel@laptop>
	<20100120135553.GA22897@n2100.arm.linux.org.uk>
	<1263996080.4283.1064.camel@laptop> <op.u6t4atd07p4s8u@pikus>
	<1263996979.4283.1066.camel@laptop>
Message-ID: <op.u6t6cwu17p4s8u@pikus>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>> On Wed, 20 Jan 2010 15:01:20 +0100, Peter Zijlstra <peterz@infradead.org> wrote:
>>> It seems to me userspace might care about the exact platform they're
>>> running on.

> On Wed, 2010-01-20 at 15:09 +0100, Micha? Nazarewicz wrote:
>> In my humble opinion, user space should never care about platform it's
>> running on.  Interfaces provided by kernel should suffice to implement
>> abstraction layer between user space and hardware.  If we abandon that
>> we're back in DOS times.  But hey, again, that's just my opinion.

On Wed, 20 Jan 2010 15:16:19 +0100, Peter Zijlstra <peterz@infradead.org> wrote:
> Well, you're completely right. But the often sad reality is that perfect
> abstraction is either impossible or prohibitively expensive.

Yes, I agree and am aware of that, but I think it's not the case with
performance events.  It is possible for kernel to provide such a list
and at the same time it's not that expensive (it's a matter of hardcoding
a list in the source and possibly alter it a bit according to hardware
detection which is done anyway).

Of course, it's not all gold -- maintaining such a list increases
complexity of the kernel and adds burden of keeping the lists in
sync with reality.

Still, however, in my opinion, the advantages of the list maintained
in kernel are greater then disadvantages and so I'd opt in for that
solution.  (Of course, I'm not some kind of ARM Linux guru so I may
be simply wrong.)

-- 
Best regards,                                           _     _
  .o. | Liege of Serenely Enlightened Majesty of       o' \,=./ `o
  ..o | Computer Science,  Micha? "mina86" Nazarewicz     (o o)
  ooo +---[mina86 at mina86.com]---[mina86 at jabber.org]---ooO--(_)--Ooo--
