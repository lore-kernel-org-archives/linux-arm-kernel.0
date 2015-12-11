From: paulmck@linux.vnet.ibm.com (Paul E. McKenney)
Date: Fri, 11 Dec 2015 05:42:26 -0800
Subject: [PATCH] arm64: spinlock: serialise spin_unlock_wait against
 concurrent lockers
In-Reply-To: <20151211094651.GA18828@arm.com>
References: <20151201164035.GE27751@arm.com>
 <20151203001141.GO28602@linux.vnet.ibm.com>
 <20151203132839.GA3816@twins.programming.kicks-ass.net>
 <20151203163243.GI11337@arm.com>
 <20151203172207.GR28602@linux.vnet.ibm.com>
 <20151206081617.GB1549@fixme-laptop.cn.ibm.com>
 <20151206192734.GT28602@linux.vnet.ibm.com>
 <20151207002601.GB13845@fixme-laptop.cn.ibm.com>
 <20151211080911.GD1072@fixme-laptop.cn.ibm.com>
 <20151211094651.GA18828@arm.com>
Message-ID: <20151211134226.GM28602@linux.vnet.ibm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 11, 2015 at 09:46:52AM +0000, Will Deacon wrote:
> On Fri, Dec 11, 2015 at 04:09:11PM +0800, Boqun Feng wrote:
> > In conclusion, we have more than a half of uses working well already,
> > and each of the fix-needed ones has only one related critical section
> > and only one related data access in it. So on PPC, I think my proposal
> > won't have more smp_mb() instances to fix all current use cases than
> > adding smp_mb__after_unlock_lock() after the lock acquisition in each
> > related lock critical section.
> > 
> > Of course, my proposal needs the buy-ins of both PPC and ARM64v8, so
> > Paul and Will, what do you think? ;-)
> 
> I already queued the change promoting it to LOCK for arm64. It makes the
> semantics easy to understand and I've failed to measure any difference
> in performance. It's also robust against any future users of the macro
> and matches what other architectures do.

What size system did you do your performance testing on?

							Thanx, Paul
