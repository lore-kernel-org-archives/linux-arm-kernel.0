From: will.deacon@arm.com (Will Deacon)
Date: Mon, 27 Jul 2015 14:00:53 +0100
Subject: [PATCH v2 02/20] documentation: Clarify failed cmpxchg memory
 ordering semantics
In-Reply-To: <20150727120201.GW19282@twins.programming.kicks-ass.net>
References: <1437734531-10698-1-git-send-email-will.deacon@arm.com>
 <1437734531-10698-3-git-send-email-will.deacon@arm.com>
 <20150727115822.GH3358@arm.com>
 <20150727120201.GW19282@twins.programming.kicks-ass.net>
Message-ID: <20150727130053.GI3358@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 27, 2015 at 01:02:01PM +0100, Peter Zijlstra wrote:
> On Mon, Jul 27, 2015 at 12:58:22PM +0100, Will Deacon wrote:
> > On Fri, Jul 24, 2015 at 11:41:53AM +0100, Will Deacon wrote:
> > > A failed cmpxchg does not provide any memory ordering guarantees, a
> > > property that is used to optimise the cmpxchg implementations on Alpha,
> > > PowerPC and arm64.
> > > 
> > > This patch updates atomic_ops.txt and memory-barriers.txt to reflect
> > > this.
> > > 
> > > Cc: Peter Zijlstra <peterz@infradead.org>
> > > Signed-off-by: Will Deacon <will.deacon@arm.com>
> > > ---
> > >  Documentation/atomic_ops.txt      | 4 +++-
> > >  Documentation/memory-barriers.txt | 6 +++---
> > >  2 files changed, 6 insertions(+), 4 deletions(-)
> > 
> > Peter: are you ok with me taking this via the arm64 tree (along with the
> > rest of the series), or would you prefer this patch routed through -tip?
> 
> So I have this one queued, and typically these changes go through tip
> because the RCU tree also ends up there, and Paul is the typical source
> of patches there.
> 
> So to minimize collisions on memory-barriers.txt i'd like to keep it if
> its not too much hassle.

No problem at all, just didn't want it to get dropped. Minimising conflicts
in memory-barriers.txt is definitely a good idea ;)

Thanks!

Will
