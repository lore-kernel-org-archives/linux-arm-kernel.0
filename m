From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 30 Aug 2012 18:23:04 +0100
Subject: [PATCH v2] ARM: Build dtb files in all target
In-Reply-To: <20120830165224.GR19437@titan.lakedaemon.net>
References: <1346303687-7795-1-git-send-email-andrew@lunn.ch>
 <20120830165224.GR19437@titan.lakedaemon.net>
Message-ID: <20120830172304.GA18957@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 30, 2012 at 12:52:24PM -0400, Jason Cooper wrote:
> On Thu, Aug 30, 2012 at 07:14:47AM +0200, Andrew Lunn wrote:
> > Tools like kisskb are good at finding build regressions in the kernel
> > sources. However, regressions in the DT desscriptions are not found,
> > because generally these build systems don't build the DT binary blobs.
> > 
> > Extend the ARM all target to build all enabled DTB files.
> > 
> > Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> 
> Acked-by: Jason Cooper <jason@lakedaemon.net>
> 
> I've CC'd stable to see if they want to pick this up.

That's not how stable works - and you'll probably receive a standard form
whinge from them about that.  Please read up on the submission requirements
to the stable kernel trees.

> It does depend on
> having dtc built.  A patch already exists to build dtc on demand, but
> I'm not sure if it has made it into mainline yet.  It may be in
> Russell's queue.

At the moment, the only stuff I have outstanding for -rc is:

36418c5 ARM: 7499/1: mm: Fix vmalloc overlap check for !HIGHMEM
df547e0 ARM: 7503/1: mm: only flush both pmd entries for classic MMU
ae3790b ARM: 7502/1: contextidr: avoid using bfi instruction during notifier
dbece45 ARM: 7501/1: decompressor: reset ttbcr for VMSA ARMv7 cores
d968d2b ARM: 7497/1: hw_breakpoint: allow single-byte watchpoints on all addressbf88011 ARM: 7496/1: hw_breakpoint: don't rely on dfsr to show watchpoint accessa849088 ARM: Fix ioremap() of address zero

I have nothing queued for dtc building, and there's no sign of anything
new in the patch system.
