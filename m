From: saeed.bishara@gmail.com (saeed bishara)
Date: Mon, 7 Feb 2011 16:04:09 +0200
Subject: [PATCH v3 2/5] ARM: pm: add generic CPU suspend/resume support
In-Reply-To: <20110207133457.GE31929@n2100.arm.linux.org.uk>
References: <20110206191117.GA17808@n2100.arm.linux.org.uk>
	<E1PmA28-0000AC-2t@rmk-PC.arm.linux.org.uk>
	<20110207120103.GC31929@n2100.arm.linux.org.uk>
	<20110207121052.GD31929@n2100.arm.linux.org.uk>
	<AANLkTintBD2Gfb3pkPZPe2mreU5EatUnNwUqR-id7q+M@mail.gmail.com>
	<20110207133457.GE31929@n2100.arm.linux.org.uk>
Message-ID: <AANLkTi=B45PuOErxR49Gfhfq6-=y_NugbWBLBo0MEoCt@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> It's really not nice to page down and down and down to find out the one
> or two lines that actually contain something useful - or in my case
> scroll through the first three pages, then go to the bottom and start
> scrolling up. ?It wastes time.
sorry
>
>> this code doesn't look smp save, it modifies page table that could be
>> used by another cpu. I suggest to create (at ?boot time) identity page
>> table and use it in order to do mmu on.
>
> When you suspend/resume, the other CPUs will be hot-unplugged before
> suspend, and hot-plugged after resume. ?SMP issues really don't come
> in here, and there's not really many other ways to solve the inherent
> races involved with turning on the MMU.
that's right, but in the future this code can be used also for
cpuidle, so please take that into account.
also,  I think cpu_resume_after_mmu  needs to invalidates the TLB
after restoring the old mapping.
one more comment, don't you need to restore the context ID cp15 register?
saeed
>
