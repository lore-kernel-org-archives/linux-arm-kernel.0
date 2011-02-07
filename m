From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 7 Feb 2011 15:02:33 +0000
Subject: [PATCH v3 2/5] ARM: pm: add generic CPU suspend/resume support
In-Reply-To: <AANLkTikVQG1ngkT7VwvjiSJjSfNsSMw=msfhc44emx6B@mail.gmail.com>
References: <E1PmA28-0000AC-2t@rmk-PC.arm.linux.org.uk>
	<20110207120103.GC31929@n2100.arm.linux.org.uk>
	<20110207121052.GD31929@n2100.arm.linux.org.uk>
	<AANLkTintBD2Gfb3pkPZPe2mreU5EatUnNwUqR-id7q+M@mail.gmail.com>
	<20110207133457.GE31929@n2100.arm.linux.org.uk>
	<AANLkTi=B45PuOErxR49Gfhfq6-=y_NugbWBLBo0MEoCt@mail.gmail.com>
	<20110207141734.GG31929@n2100.arm.linux.org.uk>
	<AANLkTi=JCQBH4sjJzWajYJx6VuUTgdB76nxXbvKTrcwc@mail.gmail.com>
	<20110207143351.GH31929@n2100.arm.linux.org.uk>
	<AANLkTikVQG1ngkT7VwvjiSJjSfNsSMw=msfhc44emx6B@mail.gmail.com>
Message-ID: <20110207150233.GI31929@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 07, 2011 at 04:58:05PM +0200, saeed bishara wrote:
> well, the allocation of the identity page table doesn't need to be
> done in assembly code. this is the similar to what you did in
> __cpu_up.
> for example, this allocation can be done in arch/arm/kernel/setup.c.
> the assembly code only need to know the offset of this page table.
> looks that there are several usages for the identity page table (smp
> boot, kexec, pm), maybe all those clients can share the same one.

We don't want to allocate this at boot time, because it will require
additional maintainence when L1 page tables are added for ioremap() etc.

I feel that it's best to leave it as-is, as this is the method everyone
has been using to date.  When it becomes a problem, we can then look at
resolving it.
