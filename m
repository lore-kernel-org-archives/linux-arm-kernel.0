From: dv@vollmann.ch (Detlef Vollmann)
Date: Thu, 17 Mar 2011 14:25:05 +0100
Subject: Why don't we have atomic_set_mask()?
In-Reply-To: <20110317120748.GH29758@n2100.arm.linux.org.uk>
References: <AANLkTi=V5mHHibKftXZ1A+s6xiuqH5X0pqYPMjZod6EV@mail.gmail.com>
	<20110317120748.GH29758@n2100.arm.linux.org.uk>
Message-ID: <4D820BB1.9050500@vollmann.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/17/11 13:07, Russell King - ARM Linux wrote:
> On Thu, Mar 17, 2011 at 08:36:15PM +0900, KyongHo Cho wrote:
>> arch/arm/asm/atomic.h defines atomic_clear_mask() but its counterpart,
>> atomic_set_mask() is not defined.
>
> Nothing other than some s390 drivers seems to use it, so I'd say no.
> I also feel that atomic_xxx() is over-used, many times in inappropriate
> and buggy ways.
I fully agree.  Simply asking for a atomic_set_mask looks like you're
trying to do something wrong.
The convention is to use those bits as flags, and having the contention
on setting the flag, so you have test_and_set_bit(), and can then
deal with the case where the flag was already set.
Doing that with more than one flag at a time would get pretty complex.

   Detlef
