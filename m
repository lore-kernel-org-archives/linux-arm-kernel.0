From: tony@atomide.com (Tony Lindgren)
Date: Mon, 31 May 2010 11:04:30 +0300
Subject: [RFC] Initial attempt to make ARM use LMB
In-Reply-To: <20100528143207.GB25568@n2100.arm.linux.org.uk>
References: <20100325233248.GM24984@n2100.arm.linux.org.uk>
	<20100522215848.GB29889@n2100.arm.linux.org.uk>
	<20100526004418.GM9645@atomide.com>
	<20100528143207.GB25568@n2100.arm.linux.org.uk>
Message-ID: <20100531080429.GA30216@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Russell King - ARM Linux <linux@arm.linux.org.uk> [100528 17:26]:
> On Tue, May 25, 2010 at 05:44:18PM -0700, Tony Lindgren wrote:
> > Also, the last patch in lmb branch "ARM: use LMB to allocate system
> > memory MMIO resource structures" causes both osk5912 and n900
> > to hang very early. Maybe I'm missing some patch again..
> 
> I'll drop this patch for the time being - we don't have stuff in the
> right order yet for lmb_alloc() to work immediately after arm_lmb_init()
> with highmem present - lmb_alloc tries to allocate from unmapped or high
> memory, which we then use __va() on and referencing the resulting pointer
> causes an abort.
> 
> However, using lmb_alloc() for the OMAP framebuffers shouldn't be an
> issue because the problem only happens if you want to immediately
> dereference the memory.

OK. Looks like your lmb branch still has it and is from the 23rd,
maybe you forgot to push out the update lmb branch?

Regards,

Tony
