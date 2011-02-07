From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 7 Feb 2011 14:33:51 +0000
Subject: [PATCH v3 2/5] ARM: pm: add generic CPU suspend/resume support
In-Reply-To: <AANLkTi=JCQBH4sjJzWajYJx6VuUTgdB76nxXbvKTrcwc@mail.gmail.com>
References: <20110206191117.GA17808@n2100.arm.linux.org.uk>
	<E1PmA28-0000AC-2t@rmk-PC.arm.linux.org.uk>
	<20110207120103.GC31929@n2100.arm.linux.org.uk>
	<20110207121052.GD31929@n2100.arm.linux.org.uk>
	<AANLkTintBD2Gfb3pkPZPe2mreU5EatUnNwUqR-id7q+M@mail.gmail.com>
	<20110207133457.GE31929@n2100.arm.linux.org.uk>
	<AANLkTi=B45PuOErxR49Gfhfq6-=y_NugbWBLBo0MEoCt@mail.gmail.com>
	<20110207141734.GG31929@n2100.arm.linux.org.uk>
	<AANLkTi=JCQBH4sjJzWajYJx6VuUTgdB76nxXbvKTrcwc@mail.gmail.com>
Message-ID: <20110207143351.GH31929@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 07, 2011 at 04:27:34PM +0200, saeed bishara wrote:
> > As I've said, there's not much other choice here. ?We _have_ to have an
> > identity mapping in place to bring the MMU back online, or we'll crash.
> > That's non-optional. ?So if this is a problem for cpuidle, cpuidle needs
> > to ensure that a page table switch has happened prior to the CPU going
> > down which _can_ be safely modified.
> I fully agree with you, but what I was suggesting is to create
> temporary identity page table at boot time, the resume code will load
> that page table (Context ID will be loaded with unique ASID), enable
> mmu, then the original page table and Context ID will be restored.

That's much easier to do in C code than in the assembly code.  Let's
keep the assembly code as simple as possible...
