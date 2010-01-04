From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 4 Jan 2010 12:32:54 +0000
Subject: [PATCH 4/5] arm: enable support for software perf events
In-Reply-To: <20100104122624.GD4117@wear.picochip.com>
References: <1262602122-10373-1-git-send-email-jamie.iles@picochip.com>
	<1262602122-10373-2-git-send-email-jamie.iles@picochip.com>
	<1262602122-10373-3-git-send-email-jamie.iles@picochip.com>
	<1262602122-10373-4-git-send-email-jamie.iles@picochip.com>
	<1262602122-10373-5-git-send-email-jamie.iles@picochip.com>
	<20100104111137.GC9107@n2100.arm.linux.org.uk>
	<20100104122624.GD4117@wear.picochip.com>
Message-ID: <20100104123254.GE9107@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 04, 2010 at 12:26:24PM +0000, Jamie Iles wrote:
> On Mon, Jan 04, 2010 at 11:11:37AM +0000, Russell King - ARM Linux wrote:
> > On Mon, Jan 04, 2010 at 10:48:41AM +0000, Jamie Iles wrote:
> > > +/* Get the PC. Make sure that we have a 64bit value with the upper 32 cleared.
> > > + */
> > > +#define perf_instruction_pointer(_regs) \
> > > +	((u64)instruction_pointer(regs) & 0xFFFFFFFFLU)
> > 
> > Maybe we should make pt_regs entries be unsigned instead of having this?
> > Nothing should be affected by that change - and it looks like x86 went
> > through this change, making two pt_regs structures, one for userspace
> > with signed ints/longs, and one for kernel space with unsigned ints/longs.
> > 
> > I think it would make more sense to do that rather than litter the kernel
> > with casts like the above.
> Ok, how about this?

Perfect.
