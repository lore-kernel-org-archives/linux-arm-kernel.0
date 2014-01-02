From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Thu, 2 Jan 2014 11:58:36 -0300
Subject: [PATCH v5 1/3] ARM: Introduce atomic MMIO modify
In-Reply-To: <20140102144724.GF19878@titan.lakedaemon.net>
References: <1386686497-20335-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1386686497-20335-2-git-send-email-ezequiel.garcia@free-electrons.com>
 <20140102113057.GI16456@n2100.arm.linux.org.uk>
 <20140102144724.GF19878@titan.lakedaemon.net>
Message-ID: <20140102145835.GA6883@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 02, 2014 at 09:47:24AM -0500, Jason Cooper wrote:
> On Thu, Jan 02, 2014 at 11:30:57AM +0000, Russell King - ARM Linux wrote:
> > On Tue, Dec 10, 2013 at 11:41:35AM -0300, Ezequiel Garcia wrote:
> > > Some SoC have MMIO regions that are shared across orthogonal
> > > subsystems. This commit implements a possible solution for the
> > > thread-safe access of such regions through a spinlock-protected API.
> > > 
> > > Concurrent access is protected with a single spinlock for the
> > > entire MMIO address space. While this protects shared-registers,
> > > it also serializes access to unrelated/unshared registers.
> > > 
> > > We add relaxed and non-relaxed variants, by using writel_relaxed and writel,
> > > respectively. The rationale for this is that some users may not require
> > > register write completion but only thread-safe access to a register.
> > > 
> > > Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
> > 
> > Okay, so this patch has been submitted to the patch system, but it
> > contains no other tags other than Ezequiel's sign-off.  Clearly
> > other people *have* reviewed it.
> > 
> > Can we please have some acks etc for it please?
> 
> Acked-by: Jason Cooper <jason@lakedaemon.net>
> 

Thanks!

Will: Can you ack this patch as well?
-- 
Ezequiel Garc?a, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
