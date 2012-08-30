From: jason@lakedaemon.net (Jason Cooper)
Date: Thu, 30 Aug 2012 14:37:11 -0400
Subject: [PATCH v2] ARM: Build dtb files in all target
In-Reply-To: <20120830172304.GA18957@n2100.arm.linux.org.uk>
References: <1346303687-7795-1-git-send-email-andrew@lunn.ch>
 <20120830165224.GR19437@titan.lakedaemon.net>
 <20120830172304.GA18957@n2100.arm.linux.org.uk>
Message-ID: <20120830183711.GY19437@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 30, 2012 at 06:23:04PM +0100, Russell King - ARM Linux wrote:
> On Thu, Aug 30, 2012 at 12:52:24PM -0400, Jason Cooper wrote:
> > I've CC'd stable to see if they want to pick this up.
> 
> That's not how stable works - and you'll probably receive a standard form
> whinge from them about that.  Please read up on the submission requirements
> to the stable kernel trees.

Ah, thanks.  usually, I just add the Cc: line for fixes I send to
arm-soc.  Since this patch affects more than just kirkwood/marvell, I
didn't feel it was appropriate to pull it in through my tree.

> > It does depend on having dtc built.  A patch already exists to build
> > dtc on demand, but I'm not sure if it has made it into mainline yet.
> > It may be in Russell's queue.
> 
> At the moment, the only stuff I have outstanding for -rc is:
> 
> 36418c5 ARM: 7499/1: mm: Fix vmalloc overlap check for !HIGHMEM
> df547e0 ARM: 7503/1: mm: only flush both pmd entries for classic MMU
> ae3790b ARM: 7502/1: contextidr: avoid using bfi instruction during notifier
> dbece45 ARM: 7501/1: decompressor: reset ttbcr for VMSA ARMv7 cores
> d968d2b ARM: 7497/1: hw_breakpoint: allow single-byte watchpoints on all address
> bf88011 ARM: 7496/1: hw_breakpoint: don't rely on dfsr to show watchpoint access
> a849088 ARM: Fix ioremap() of address zero
> 
> I have nothing queued for dtc building, and there's no sign of anything
> new in the patch system.

What I'm referring to is here:

http://lkml.org/lkml/2012/8/28/257

I submitted a patch six months ago for the exact same thing and was
informed that others already had a pending patch in your queue for it.
However, I can't for the life of me locate the thread atm.  I remember
it because it was the first patch I did that needed to go into your
queue instead of through arm-soc.  Obviously, I did something horribly
wrong.  ;-)

thx,

Jason.
