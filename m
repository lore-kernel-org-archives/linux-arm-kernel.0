From: will.deacon@arm.com (Will Deacon)
Date: Mon, 19 Apr 2010 15:39:13 +0100
Subject: [PATCH] ARM: change definition of cpu_relax() for ARM11MPCore
In-Reply-To: <1271093038-31773-1-git-send-email-will.deacon@arm.com>
References: <1271093038-31773-1-git-send-email-will.deacon@arm.com>
Message-ID: <1271687953.11099.9.camel@e102144-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

> On Mon, Apr 12, 2010 at 06:23:58PM +0100, Will Deacon wrote:
> > This patch changes the definition of cpu_relax() to smp_mb() for ARMv6 cores,
> > forcing the write buffer to drain while inside a polling loop on an SMP system.
> > If the Kernel is not compiled for SMP support, this will expand to a barrier()
> > as before.
> 
> Linus asked how expensive (in terms of power rather than performance)
> this was; so far that question has remained unanswered.  Can someone
> please answer his question?

I gave my opinion on the potential performance impact here:

http://sourceforge.net/mailarchive/message.php?msg_name=000001cada64%24b9f84200%242de8c600%24%40deacon%40arm.com

To summarise: in the context of polling loops, I believe that the
performance impact of adding an smp_mb() to cpu_relax() for v6 SMP
is minimal. If cpu_relax() is used in other scenarios, the performance
impact can only be reviewed on a case-by-case basis.

Are there any other issues that need to be considered, or can I
submit this to the patch system?

Thanks,

Will
