From: paulmck@linux.vnet.ibm.com (Paul E. McKenney)
Date: Fri, 30 Jun 2017 10:29:43 -0700
Subject: [PATCH RFC 12/26] arm64: Remove spin_unlock_wait() arch-specific
 definitions
In-Reply-To: <20170630092057.GD9726@arm.com>
References: <20170629235918.GA6445@linux.vnet.ibm.com>
 <1498780894-8253-12-git-send-email-paulmck@linux.vnet.ibm.com>
 <20170630092057.GD9726@arm.com>
Message-ID: <20170630172943.GY2393@linux.vnet.ibm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 30, 2017 at 10:20:57AM +0100, Will Deacon wrote:
> On Thu, Jun 29, 2017 at 05:01:20PM -0700, Paul E. McKenney wrote:
> > There is no agreed-upon definition of spin_unlock_wait()'s semantics,
> > and it appears that all callers could do just as well with a lock/unlock
> > pair.  This commit therefore removes the underlying arch-specific
> > arch_spin_unlock_wait().
> > 
> > Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > Cc: Will Deacon <will.deacon@arm.com>
> > Cc: <linux-arm-kernel@lists.infradead.org>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: Alan Stern <stern@rowland.harvard.edu>
> > Cc: Andrea Parri <parri.andrea@gmail.com>
> > Cc: Linus Torvalds <torvalds@linux-foundation.org>
> > ---
> >  arch/arm64/include/asm/spinlock.h | 58 ++++-----------------------------------
> >  1 file changed, 5 insertions(+), 53 deletions(-)
> 
> I'm going to miss this code.

;-) ;-) ;-)

> Acked-by: Will Deacon <will.deacon@arm.com>

Applied, thank you!

							Thanx, Paul
