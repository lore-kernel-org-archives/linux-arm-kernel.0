From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 13 May 2014 19:38:25 +0200
Subject: [PATCHv2] ARM: mvebu: use hardware I/O coherency also for PCI
 devices
In-Reply-To: <20140513163504.GF27822@titan.lakedaemon.net>
References: <1399997070-11434-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <20140513163504.GF27822@titan.lakedaemon.net>
Message-ID: <20140513193825.4196afe8@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Jason Cooper,

On Tue, 13 May 2014 12:35:04 -0400, Jason Cooper wrote:

> > Whether this commit qualifies as stable material can be
> > discussed. Technically, it was a mistake from the original I/O
> > coherency implementation. But in practice, besides not using the I/O
> > coherency, I don't think it's causing any specific problem other than
> > DMA transactions on PCI devices triggering unneeded cache maintenance
> > operations. So I'll leave it to the mvebu maintainers to decide
> > whether this qualifies as stable material or not. I've included the
> > relevant Fixes: and Cc: fields, but don't hesitate to rip them out if
> > you don't think this should go to stable.
> 
> If nothing is broken for users, I see no point backporting it.  Feel
> free to convince me otherwise...

As far as I can remember, it isn't broken, it's just sub-optimal. The
only situation where it would cause problem is on Armada 375/Armada 38x
with SMP support, due to the SMP/PCIe/PL310 deadlock for which I've
sent a v2 of the patches today on LAKML. In this case, not using our
specific DMA operations would cause many PL310 cache maintenance
operations, and therefore a high chance of hitting the deadlock.
However, this is only a new problem in 3.16, which has the SMP support
for Armada 375/Armada 38x.

So, as I said, feel free to drop the stable tags :)

Thanks!

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
