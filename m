From: preeti@linux.vnet.ibm.com (Preeti U Murthy)
Date: Wed, 03 Sep 2014 14:11:14 +0530
Subject: [PATCH v5 04/12] sched: Allow all archs to set the capacity_orig
In-Reply-To: <CAKfTPtCNPYOi9OY37nbG9o71n4i5mxxvrRow0SgL_9pVK1LpMA@mail.gmail.com>
References: <1409051215-16788-1-git-send-email-vincent.guittot@linaro.org>
 <1409051215-16788-5-git-send-email-vincent.guittot@linaro.org>
 <540204DC.5090204@linux.vnet.ibm.com>
 <CAKfTPtCNPYOi9OY37nbG9o71n4i5mxxvrRow0SgL_9pVK1LpMA@mail.gmail.com>
Message-ID: <5406D42A.8090209@linux.vnet.ibm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/01/2014 01:35 PM, Vincent Guittot wrote:
> On 30 August 2014 19:07, Preeti U Murthy <preeti@linux.vnet.ibm.com> wrote:
>> Hi Vincent,
>>
>> On 08/26/2014 04:36 PM, Vincent Guittot wrote:
>>> capacity_orig is only changed for system with a SMT sched_domain level in order
>>
>> I think I had asked this before, but why only capacity_orig? The
>> capacity of a group is also being updated the same way. This patch fixes
>> the capacity of a group to reflect the capacity of the heterogeneous
>> CPUs in it, this capacity being both the full capacity of the group:
>> capacity_orig and the capacity available for the fair tasks. So I feel
>> in the subject as well as the changelog it would suffice to say 'capacity'.
> 
> IIRC, we discussed that point on a former version. The patch changes
> only the behavior of capacity_orig but the behavior of capacity stays
> unchanged as all archs can already set the capacity whereas the
> capacity_orig was configurable only if the SD_SHARE_CPUCAPACITY was
> set in the sched_domain. This is no more the case with this patch
> which creates arch_scale_cpu_capacity for setting capacity_orig.

Yes, sorry I overlooked that.

Reviewed-by: Preeti U. Murthy <preeti@linux.vnet.ibm.com>

Regards
Preeti U Murthy
