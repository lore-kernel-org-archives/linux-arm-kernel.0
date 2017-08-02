From: peterz@infradead.org (Peter Zijlstra)
Date: Wed, 2 Aug 2017 10:14:37 +0200
Subject: rcu_sched stall while waiting in csd_lock_wait()
In-Reply-To: <da7c56d6-066a-d123-f0cf-d9a3b97b001e@redhat.com>
References: <da7c56d6-066a-d123-f0cf-d9a3b97b001e@redhat.com>
Message-ID: <20170802081437.24skpbdglcymd5em@hirez.programming.kicks-ass.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 02, 2017 at 09:01:19AM +0530, Pratyush Anand wrote:
> Hi,
> 
> I am observing following rcu_sched stall while executing `perf record -a  --
> sleep 1` with one of the arm64 platform. It looks like that stalled cpu was
> waiting in csd_lock_wait() from where it never came out,and so the stall.
> Any help/pointer for further debugging would be very helpful. Problem also
> reproduced with 4.13.0-rc3.

I'm sitting on this patch:

  https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git/commit/?h=locking/core&id=15377ef4fe0c86eb7fa1099575b2e86357d99e42

please give that a spin.
