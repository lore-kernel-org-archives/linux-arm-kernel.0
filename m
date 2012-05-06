From: mturquette@ti.com (Mike Turquette)
Date: Sun, 6 May 2012 16:49:58 -0700
Subject: common clock framework
In-Reply-To: <CAG9bXv=T7v_MBUOmCsp4n0SNmYY_DOEkhQXAp0rTGpdi6KkXNA@mail.gmail.com>
References: <AAD1C6EB06EE3649B35B7E026785068D1A74A94270@SC-VEXCH2.marvell.com>
 <20120504082110.GB16535@pengutronix.de>
 <CAJOA=zOs8FLTRUh=LOd2f=YxFz7Sdxgp2JJurpQkdDFALcCiVw@mail.gmail.com>
 <CAG9bXv=T7v_MBUOmCsp4n0SNmYY_DOEkhQXAp0rTGpdi6KkXNA@mail.gmail.com>
Message-ID: <20120506234958.GA14559@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20120505-13:33, Raul Xiong wrote:
> 2012/5/5 Turquette, Mike <mturquette@ti.com>
> > Bad news: lockdep gets cranky about possible deadlocks due to holding
> > prepare_lock and then trying to hold it again in a rate-change
> > notifier handler (from OMAP's regulator code).  Specifically
> >
> 
> Glad to see common clock framework will support DVFS. Can we use different
> spinlock for different clocks with different lockdep lock classes to avoid
> the dead lock and lockdep warnings?

I understand that different lockdep classes could allow for nested
locking, but I don't have a good idea of how that would actually be
implemented.  Could you elaborate a bit more?

In the mean time I'm looking at some different locking semantics that
don't involve lockdep class mangling, just a more fine-grained approach
to locking exactly what we want.

Regards,
Mike
