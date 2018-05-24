From: peterz@infradead.org (Peter Zijlstra)
Date: Fri, 25 May 2018 00:32:44 +0200
Subject: [PATCH 6/9] asm-generic/bitops/atomic.h: Rewrite using
 atomic_fetch_*
In-Reply-To: <20180524220610.GA7607@andrea>
References: <1527159586-8578-1-git-send-email-will.deacon@arm.com>
 <1527159586-8578-7-git-send-email-will.deacon@arm.com>
 <20180524124410.GF12198@hirez.programming.kicks-ass.net>
 <20180524124734.GE8689@arm.com>
 <20180524130948.f37eltocl5tnittp@lakrids.cambridge.arm.com>
 <20180524220610.GA7607@andrea>
Message-ID: <20180524223244.GO12198@hirez.programming.kicks-ass.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 25, 2018 at 12:06:10AM +0200, Andrea Parri wrote:
> Hi Mark,
> 
> > As an aside, If I complete the autogeneration stuff, it'll be possible
> > to generate those. I split out the necessary barriers in [1], but I
> > still have a lot of other preparatory cleanup to do.
> 
> I do grasp the rationale behind that naming:
> 
>   __atomic_mb_{before,after}_{acquire,release,fence}()
> 
> and yet I remain puzzled by it:
> 
> For example, can you imagine (using):
> 
>   __atomic_mb_before_acquire() ?
> 
> (as your __atomic_mb_after_acquire() is whispering me "acquire-fences"...)

Yes, I really do think he means acquire-fence. It is however something I
have vague memories of not being liked much because it is the memop
itself that carries the ordering.

That said, this is only an implementation detail and not a public
interface, so maybe we can get away with it.
