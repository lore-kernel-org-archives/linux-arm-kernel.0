From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 26 Oct 2009 11:19:33 +0000
Subject: cpu_vm_mask checks in ARM flush functions
In-Reply-To: <1256555719.5282.26.camel@pc1117.cambridge.arm.com>
References: <f20fa6c60910232103h5a3046fbmda23a093f94fa230@mail.gmail.com>
	<20091024111036.GC16451@n2100.arm.linux.org.uk>
	<1256552546.5282.2.camel@pc1117.cambridge.arm.com>
	<20091026105148.GA22097@n2100.arm.linux.org.uk>
	<1256555719.5282.26.camel@pc1117.cambridge.arm.com>
Message-ID: <20091026111933.GC22097@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 26, 2009 at 11:15:19AM +0000, Catalin Marinas wrote:
> On Mon, 2009-10-26 at 10:51 +0000, Russell King - ARM Linux wrote:
> > Since I don't have an EABI gdb, I can't test it either.
> 
> Not for this particular case but if you want I have some scripts to
> generate a debootstrap root filesystem for the RealView boards (they
> require a Debian PC).

That doesn't help - I don't have any Debian stuff here.

> > Was the ARM11MPCore system being tested one which broadcasts the cache ops
> > in hardware?
> 
> There's no ARM11MPCore with in-hardware cache ops broadcasting (only
> Cortex-A9). I think there was also a case of not setting the PG_arch_1
> bit on SMP at all.

That'll be why it removing that check doesn't resolve the problem then.
The coherent flushes aren't broadcasted.

> Now that you mention this, they tried a patch for Cortex-A9 which goes
> back to lazy cache-flushing in flush_dcache_page/update_mmu_cache and
> the gdb breakpoints were working fine.

The lazy d-cache flushing has nothing to do with gdb breakpoints.
