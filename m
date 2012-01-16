From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 16 Jan 2012 19:06:37 +0000
Subject: [RFC PATCH] ARM: new architecture for Energy Micro's EFM32
 Cortex-M3 SoCs
In-Reply-To: <20120116181002.GC12267@arm.com>
References: <1324480428-13344-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <CADMYwHzE0HeBKjA55ApQo0k5AW8+Za3kT8u5HnMorXEk4PQxjA@mail.gmail.com>
 <20120116162933.GG14252@pengutronix.de>
 <20120116174039.GD32049@n2100.arm.linux.org.uk>
 <20120116181002.GC12267@arm.com>
Message-ID: <20120116190637.GE32049@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 16, 2012 at 06:10:02PM +0000, Catalin Marinas wrote:
> On Mon, Jan 16, 2012 at 05:40:39PM +0000, Russell King - ARM Linux wrote:
> > The VFP stuff - adding 'clean' which is kernel state to the _user_
> > _exported_ VFP hardware structure is a bad idea.  So this needlessly
> > causes a variation in the kernels userspace API.  Please find somewhere
> > else to keep kernel internal state.  (As that patch comes from Catalin,
> > then that comment is directed to Catalin.)
> 
> Are you sure we export vfp_hard_struct to user? That's a kernel-only
> structure (and it's not by any means stable, given the number of
> #ifdef's it has). I would also argue that 'clean' is a hardware state
> (inferred from the exception return value).

Actually, looking at arch/arm/kernel/ptrace.c, we only export the
fpregs and fpscr, so this should be fine.

Still, I don't see why we need this 'clean' state, when normal VFP
doesn't need it.  Maybe you could explain why it's necessary?
