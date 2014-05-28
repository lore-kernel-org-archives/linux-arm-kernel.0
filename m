From: peterz@infradead.org (Peter Zijlstra)
Date: Wed, 28 May 2014 17:17:30 +0200
Subject: [PATCH v2 08/11] sched: get CPU's activity statistic
In-Reply-To: <20140528121001.GI19967@e103034-lin>
References: <1400860385-14555-1-git-send-email-vincent.guittot@linaro.org>
 <1400860385-14555-9-git-send-email-vincent.guittot@linaro.org>
 <20140528121001.GI19967@e103034-lin>
Message-ID: <20140528151730.GW11096@twins.programming.kicks-ass.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 28, 2014 at 01:10:01PM +0100, Morten Rasmussen wrote:
> The basic problem is that worst case: sum starting from 0 and period
> already at LOAD_AVG_MAX = 47742, it takes LOAD_AVG_MAX_N = 345 periods
> (ms) for sum to reach 47742. 

But it takes only 4 periods (4*32ms) to get ~94% of the way there, 

So our half-time is 32 * 1024 ms, now look at \Sum_i=1,4 1/(2^i) =
0.9375. So 4 periods (4*32*1024=131072 ms) gets us ~94% of the way
there.

Now, granted, 4 periods of 32-ish ms is still very long, but nowhere
near as horrid as the full convergence.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140528/e764fce4/attachment.sig>
