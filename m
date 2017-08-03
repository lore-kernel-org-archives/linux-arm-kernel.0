From: panand@redhat.com (Pratyush Anand)
Date: Thu, 3 Aug 2017 09:26:24 +0530
Subject: rcu_sched stall while waiting in csd_lock_wait()
In-Reply-To: <f0fa028b-b690-2b85-ca01-3642ff883e30@arm.com>
References: <da7c56d6-066a-d123-f0cf-d9a3b97b001e@redhat.com>
 <20170802080827.GA15219@arm.com>
 <f0fa028b-b690-2b85-ca01-3642ff883e30@arm.com>
Message-ID: <29ea458d-f415-4913-8b54-db5c334ce829@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marc,

On Wednesday 02 August 2017 02:14 PM, Marc Zyngier wrote:
> On 02/08/17 09:08, Will Deacon wrote:
>> Hi Pratyush,
>>
>> On Wed, Aug 02, 2017 at 09:01:19AM +0530, Pratyush Anand wrote:
>>> I am observing following rcu_sched stall while executing `perf record -a  --
>>> sleep 1` with one of the arm64 platform. It looks like that stalled cpu was
>>> waiting in csd_lock_wait() from where it never came out,and so the stall.
>>> Any help/pointer for further debugging would be very helpful. Problem also
>>> reproduced with 4.13.0-rc3.
>>
>> When you say "also", which other kernel(s) show the problem? Is this a
>> recent regression? Which platform are you running on?
>>
>> It would be interesting to know what the other CPUs are doing, in particular
>> the target of the cross-call. Either it crashed spectacularly and didn't
>> unlock the csd lock, or the IPI somehow wasn't delivered.
>>
>> Do you see any other splats if you enable lock debugging?
> 
> Also, is that in a guest, or bare metal? If that's a guest, what's the
> host's kernel version?

Its a host.
-- 
Regards
Pratyush
