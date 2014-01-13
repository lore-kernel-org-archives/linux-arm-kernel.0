From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 13 Jan 2014 13:58:58 +0000
Subject: [PATCH v5 1/3] ARM: Introduce atomic MMIO modify
In-Reply-To: <20140112145206.GD6099@localhost>
References: <1386686497-20335-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1386686497-20335-2-git-send-email-ezequiel.garcia@free-electrons.com>
 <20140102113057.GI16456@n2100.arm.linux.org.uk>
 <20140102144724.GF19878@titan.lakedaemon.net>
 <20140102145835.GA6883@localhost> <20140112145206.GD6099@localhost>
Message-ID: <20140113135858.GE11805@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jan 12, 2014 at 02:52:07PM +0000, Ezequiel Garcia wrote:
> On Thu, Jan 02, 2014 at 11:58:35AM -0300, Ezequiel Garcia wrote:
> > On Thu, Jan 02, 2014 at 09:47:24AM -0500, Jason Cooper wrote:
> > > On Thu, Jan 02, 2014 at 11:30:57AM +0000, Russell King - ARM Linux wrote:
> > > > On Tue, Dec 10, 2013 at 11:41:35AM -0300, Ezequiel Garcia wrote:
> > > > > Some SoC have MMIO regions that are shared across orthogonal
> > > > > subsystems. This commit implements a possible solution for the
> > > > > thread-safe access of such regions through a spinlock-protected API.
> > > > > 
> > > > > Concurrent access is protected with a single spinlock for the
> > > > > entire MMIO address space. While this protects shared-registers,
> > > > > it also serializes access to unrelated/unshared registers.
> > > > > 
> > > > > We add relaxed and non-relaxed variants, by using writel_relaxed and writel,
> > > > > respectively. The rationale for this is that some users may not require
> > > > > register write completion but only thread-safe access to a register.
> > > > > 
> > > > > Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
> > > > 
> > > > Okay, so this patch has been submitted to the patch system, but it
> > > > contains no other tags other than Ezequiel's sign-off.  Clearly
> > > > other people *have* reviewed it.
> > > > 
> > > > Can we please have some acks etc for it please?
> > > 
> > > Acked-by: Jason Cooper <jason@lakedaemon.net>
> 
> Catalin, Will: Can you ack as well, so Russell can take this?

Acked-by: Catalin Marinas <catalin.marinas@arm.com>

(with the condition that Will promises to sort out the generic relaxed
IO accessors and move this to generic code ;))
