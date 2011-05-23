From: Marc.Zyngier@arm.com (Marc Zyngier)
Date: Mon, 23 May 2011 17:23:19 +0100
Subject: [PATCH] ARM: fix missing 'cpu_relax()' declaration
In-Reply-To: <20110523160944.GA15138@n2100.arm.linux.org.uk>
References: <1306157607-18406-1-git-send-email-marc.zyngier@arm.com>
	<20110523160944.GA15138@n2100.arm.linux.org.uk>
Message-ID: <1306167799.27474.83.camel@e102391-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2011-05-23 at 17:09 +0100, Russell King - ARM Linux wrote:
> On Mon, May 23, 2011 at 02:33:27PM +0100, Marc Zyngier wrote:
> > ARM build fails with the following symptom:
> > 
> >   CC      arch/arm/kernel/asm-offsets.s
> > In file included from include/linux/seqlock.h:29,
> >                  from include/linux/time.h:8,
> >                  from include/linux/timex.h:56,
> >                  from include/linux/sched.h:57,
> >                  from arch/arm/kernel/asm-offsets.c:13:
> > include/linux/spinlock.h: In function 'spin_unlock_wait':
> > include/linux/spinlock.h:360: error: implicit declaration of function 'cpu_relax'
> > make[1]: *** [arch/arm/kernel/asm-offsets.s] Error 1
> > 
> > Fix it by including <asm/processor.h>.
> > 
> > Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> 
> Wonder why we haven't see this before.  Could you send this to the patch
> system please?

Guess we were lucky. It is probably an effect of
e66eed651fd18a961f11cda62f3b5286c8cc4f9f (list: remove prefetching from
regular list iterators), which indirectly stopped asm/processor.h from
being pulled.

Now in the patch system (6939/1).

Cheers,

	M.
-- 
Reality is an implementation detail.
