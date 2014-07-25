From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 25 Jul 2014 13:14:11 +0100
Subject: next build: 629 warnings 1 failures (next/next-20140723)
In-Reply-To: <20140725112623.GG23220@titan.lakedaemon.net>
References: <53cf8323.e4b6440a.7d37.4f75@mx.google.com>
 <CAOesGMhT9n7nVbCay5cU74pv2qrbqMooZLoY923Lk6SzXk5z+A@mail.gmail.com>
 <20140724085037.GB1994@arm.com> <20140724104318.GA13371@arm.com>
 <20140724132448.GB13371@arm.com>
 <20140724224836.GY23220@titan.lakedaemon.net>
 <20140725090109.GA24268@arm.com>
 <20140725112623.GG23220@titan.lakedaemon.net>
Message-ID: <20140725121411.GE24268@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 25, 2014 at 12:26:23PM +0100, Jason Cooper wrote:
> On Fri, Jul 25, 2014 at 10:01:09AM +0100, Catalin Marinas wrote:
> > On Thu, Jul 24, 2014 at 11:48:36PM +0100, Jason Cooper wrote:
> > > On Thu, Jul 24, 2014 at 02:24:48PM +0100, Catalin Marinas wrote:
> > > > From 3acb8b49aeba9f48153a2d719dec05d0b862e285 Mon Sep 17 00:00:00 2001
> > > > From: Catalin Marinas <catalin.marinas@arm.com>
> > > > Date: Thu, 24 Jul 2014 14:14:42 +0100
> > > > Subject: [PATCH] arm64: gicv3: Allow GICv3 compilation with older binutils
> > > > 
> > > > GICv3 introduces new system registers accessible with the full msr/mrs
> > > > syntax (e.g. mrs x0, Sx_op0_op1_CRm_CRn_op2). However, only recent
> > > > binutils understand the new syntax. This patch introduces msr_s/mrs_s
> > > > assembly macros which generate the equivalent instructions above and
> > > > converts the existing GICv3 code (both drivers/irqchip/ and
> > > > arch/arm64/kernel/).
> > > > 
> > > > Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
> > > > Suggested-by: Mark Rutland <mark.rutland@arm.com>
> > > > Reported-by: Olof Johansson <olof@lixom.net>
> > > > Cc: Will Deacon <will.deacon@arm.com>
> > > > Cc: Marc Zyngier <marc.zyngier@arm.com>
> > > > ---
> > > >  arch/arm64/include/asm/sysreg.h    | 60 ++++++++++++++++++++++++++++++++++++++
> > > >  arch/arm64/kernel/head.S           |  6 ++--
> > > >  drivers/irqchip/irq-gic-v3.c       | 16 +++++-----
> > > >  include/linux/irqchip/arm-gic-v3.h | 42 +++++++++++++-------------
> > > >  4 files changed, 93 insertions(+), 31 deletions(-)
> > > >  create mode 100644 arch/arm64/include/asm/sysreg.h
> > > 
> > > I'm going to assume this goes on top of Marc's series, and that you'll
> > > take it through arm64:
> > > 
> > > Acked-by: Jason Cooper <jason@lakedaemon.net>
> > 
> > Thanks. I'll let Marc decide (he's back next week) as I go on holiday
> > soon. Ideally it should go into -next and upstream together with the
> > rest of the GICv3 patches but I (or Will if I'm way) am happy to take
> > the patch once GICv3 hits mainline (I would like to avoid merging the
> > irqchip tree into the arm64 tree just to be able to apply this fix).
> 
> That's why I created a topic branch for GICv3. ;-)  If you pull:
> 
>   git://git.infradead.org/users/jcooper/linux.git tags/deps-irqchip-gic-3.17
> 
> You'll get:
> 
>   021f653791ad irqchip: gic-v3: Initial support for GICv3
>   d51d0af43b30 irqchip: gic: Move some bits of GICv2 to a library-type file
> 
> based on v3.16-rc1 and nothing more.
> 
> That tag is on the irqchip/gic branch, which I'll put all the other
> changes to gic on top of once Marc has had a chance to review them.
> 
> The intent was for arm64 to pull the above, and apply the rest of Marc's
> series on top.  The fix just posted would go on top of that.  But if you
> want to wait...

That's great, thanks. I wasn't aware (or maybe I forgot) of the plans
for how to get GICv3 merged. I pulled the tag above and applied the fix
on top.

-- 
Catalin
