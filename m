From: peterz@infradead.org (Peter Zijlstra)
Date: Tue, 30 Sep 2014 21:08:59 +0200
Subject: [PATCH] sched, time: fix build error with 64 bit cputime_t on 32
 bit systems
In-Reply-To: <20140930190611.GA5702@lerouge>
References: <2547036.UshV4pXvhf@wuerfel>
 <20140930134011.232bc7bf@annuminas.surriel.com>
 <20140930190611.GA5702@lerouge>
Message-ID: <20140930190859.GO4241@worktop.programming.kicks-ass.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 30, 2014 at 09:06:13PM +0200, Frederic Weisbecker wrote:
> Maybe cmpxchg() should itself be a wrapper that does this build time choice
> between cmpxchg32() and cmpxchg64().
> 
> And if it looks too dangerous to convert all users, this could be cmpxchg_t().

It cannot, not all 32bit archs can do a 64bit cmpxchg.
