From: dave.martin@linaro.org (Dave Martin)
Date: Fri, 11 Feb 2011 10:52:17 +0000
Subject: [PATCH] ARM: Avoid discarding sections that might have SMP_ON_UP
	fixups
In-Reply-To: <20110211101345.GA23785@n2100.arm.linux.org.uk>
References: <20110126124452.GB4232@n2100.arm.linux.org.uk>
	<20110126172535.GA15983@arm.com>
	<20110209142211.GA11460@n2100.arm.linux.org.uk>
	<20110210125624.GA3652@n2100.arm.linux.org.uk>
	<AANLkTin3+4pwxQRz1J_1B6dJxJm0_5ou0OWteDFZNbo9@mail.gmail.com>
	<AANLkTinjAHLCMJja8q=bPhRBuoR2DCO_NjDw1qNi5MrU@mail.gmail.com>
	<20110210144617.GD3652@n2100.arm.linux.org.uk>
	<AANLkTiks_8hXd=7cKN0jNw=1QGcb=5ZyFu1sEFc0G=Px@mail.gmail.com>
	<20110210191125.GA12582@n2100.arm.linux.org.uk>
	<AANLkTim0RRw-xHQYTdHLCXCS_GXkaCiW8y9Fz=jMmwPa@mail.gmail.com>
	<20110211101345.GA23785@n2100.arm.linux.org.uk>
Message-ID: <AANLkTikFkZH6KK_KUgXaaKyQM6eZOh-ki3xdtS2fk8zN@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 11, 2011 at 10:13 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Fri, Feb 11, 2011 at 09:33:56AM +0000, Dave Martin wrote:
>> Agreed -- actually, I suspected we might need to support this. ?But I
>> don't think solving this problem (= keeping the fixup implementation
>> in memory and enhancing the module loader) solved the
>> fixups-referencing-sections-discarded-from-vmlinux problem. ?These
>> seem to be two separate issues. ?I am filing to understand something?
>
> They are separate, but related issues. ?They both ultimately have the
> same cause - the placement of the spinlock code inline rather than
> out of line, resulting in fixups appearing all over the place rather
> than just in kernel/spinlock.o.

I guess what I want to understand is whether I (or someone) still
need(s) to sort out the vmlinux.lds issue.

If we're keeping inline spinlocks (I currently assume "yes"), then the
vmlinux.lds issue still needs fixing.  Is that correct?  However, if
we get rid of inline spinlocks we won't have the problem, though there
may be some performance impact -- hard to judge how significant.

Apologies if I'm being dense here...

Cheers
---Dave
