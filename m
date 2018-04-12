From: peterz@infradead.org (Peter Zijlstra)
Date: Thu, 12 Apr 2018 20:22:11 +0200
Subject: [PATCH] sched: support dynamiQ cluster
In-Reply-To: <20180410131950.GU4589@e105550-lin.cambridge.arm.com>
References: <CAKfTPtD4skW_3SAk--vBEC5-m1Ua48bjOQYS0pDqW3nPSpsENg@mail.gmail.com>
 <74865492-d9a6-649d-d37c-a5a6a8c28f23@arm.com>
 <CAKfTPtDy2uUj4amA9MARUz9qS=+urwV2edyQn+fW70hkN+CgoQ@mail.gmail.com>
 <e8e6e7d0-7744-1dab-7b24-b7ff37df60c8@arm.com>
 <CAKfTPtCQayuu5-84931ZxzXV1-roV_CfRd_5wXG1oxOEUZmZgw@mail.gmail.com>
 <20180405154630.GS4589@e105550-lin.cambridge.arm.com>
 <CAKfTPtBv7BzAqZWTxU9HaCoNjQa2B8usk6dfO1qgofjGYG7S=w@mail.gmail.com>
 <20180406125825.GT4589@e105550-lin.cambridge.arm.com>
 <CAKfTPtCfCZzuBgdYzWW_KcT34VTgj6utUF+Q5zSpre+Ky2r4eA@mail.gmail.com>
 <20180410131950.GU4589@e105550-lin.cambridge.arm.com>
Message-ID: <20180412182211.GC4082@hirez.programming.kicks-ass.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 10, 2018 at 02:19:50PM +0100, Morten Rasmussen wrote:
> As said above, I see your point about completion time might suffer in
> some cases for low utilization tasks, but I don't see how you can fix
> that automagically. ASYM_PACKING has a lot of problematic side-effects.
> If use-space knows that completion time is important for a task, there
> are already ways to improve that somewhat in mainline (task priority and
> pinning), and more powerful solutions in the Android kernel which
> Patrick is currently pushing upstream.

So I tend to side with Morten on this one. I don't particularly like
ASYM_PACKING much, but we already had it for PPC and it works for the
small difference in performance ITMI has.

At the time Morten already objected to using it for ITMI, and I just
haven't had time to look into his proposal for using capacity.

But I don't see it working right for big.litte/dynamiq, simply because
it is a very strong always big preference, which is against the whole
design premisis of big.little (as Morten has been trying to argue).
