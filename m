From: will.deacon@arm.com (Will Deacon)
Date: Mon, 9 Apr 2018 11:58:40 +0100
Subject: [PATCH 02/10] locking/qspinlock: Remove unbounded cmpxchg loop
 from locking slowpath
In-Reply-To: <20180407084732.GO4082@hirez.programming.kicks-ass.net>
References: <1522947547-24081-1-git-send-email-will.deacon@arm.com>
 <1522947547-24081-3-git-send-email-will.deacon@arm.com>
 <dc5f5e43-a60a-05f2-16fb-46960c40459e@redhat.com>
 <20180406210953.GA24165@linux.vnet.ibm.com>
 <20180407084732.GO4082@hirez.programming.kicks-ass.net>
Message-ID: <20180409105840.GD23134@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Apr 07, 2018 at 10:47:32AM +0200, Peter Zijlstra wrote:
> On Fri, Apr 06, 2018 at 02:09:53PM -0700, Paul E. McKenney wrote:
> > It would indeed be good to not be in the position of having to trade off
> > forward-progress guarantees against performance, but that does appear to
> > be where we are at the moment.
> 
> Depends of course on how unfair cmpxchg is. On x86 we trade one cmpxchg
> loop for another so the patch doesn't cure anything at all there. And
> our cmpxchg has 'some' hardware fairness to it.
> 
> So while the patch is 'good' for platforms that have native fetch-or,
> it doesn't help (or in our case even hurts) those that do not.

We need to get to the bottom of this, otherwise we're just relying on
Waiman's testing to validate any changes to this code!

Will
