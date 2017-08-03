From: panand@redhat.com (Pratyush Anand)
Date: Thu, 3 Aug 2017 09:26:06 +0530
Subject: rcu_sched stall while waiting in csd_lock_wait()
In-Reply-To: <20170802081437.24skpbdglcymd5em@hirez.programming.kicks-ass.net>
References: <da7c56d6-066a-d123-f0cf-d9a3b97b001e@redhat.com>
 <20170802081437.24skpbdglcymd5em@hirez.programming.kicks-ass.net>
Message-ID: <00171457-416c-94c6-21c7-28817e7367ab@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Peter,

On Wednesday 02 August 2017 01:44 PM, Peter Zijlstra wrote:
> On Wed, Aug 02, 2017 at 09:01:19AM +0530, Pratyush Anand wrote:
>> Hi,
>>
>> I am observing following rcu_sched stall while executing `perf record -a  --
>> sleep 1` with one of the arm64 platform. It looks like that stalled cpu was
>> waiting in csd_lock_wait() from where it never came out,and so the stall.
>> Any help/pointer for further debugging would be very helpful. Problem also
>> reproduced with 4.13.0-rc3.
> 
> I'm sitting on this patch:
> 
>    https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git/commit/?h=locking/core&id=15377ef4fe0c86eb7fa1099575b2e86357d99e42
> 
> please give that a spin.

Thanks for the pointer.
Tried, but it did not help.

-- 
Regards
Pratyush
