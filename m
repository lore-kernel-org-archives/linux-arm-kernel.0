From: sudeep.holla@arm.com (Sudeep Holla)
Date: Wed, 4 Jul 2018 15:01:23 +0100
Subject: [PATCH v2 0/7] arm64: numa/topology/smp: update the cpumasks for
 CPU hotplug
In-Reply-To: <20180704140034.GC4828@arm.com>
References: <1529327923-17911-1-git-send-email-sudeep.holla@arm.com>
 <20180704140034.GC4828@arm.com>
Message-ID: <6351d9eb-3c7e-cee4-5948-9e84a9eb0bad@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 04/07/18 15:00, Will Deacon wrote:
> Hi Sudeep,
> 
> On Mon, Jun 18, 2018 at 02:18:36PM +0100, Sudeep Holla wrote:
>> was reported to cause some hotplug and system suspend regressions when
>> it was merged. On investigation, it was found that unlike x86/PPC,
>> arm64 doesn't update the cpu and numa masks on CPU hotplug. That's
>> somewhat expected from the scheduler.
>>
>> Since these changes were bit invasive as a solution to the above
>> mentioned regression, as small change was temporarily applied as a fix.
>> This series updates the cpu and numa masks on CPU hotplug and reverts
>> that temporary fix.
>>
>> It would be good to get this tested(CPU hotplug - few and all CPUs in
>> a socket) on multi-socket/NUMA systems from Cavium and Huawei/Hisilicon.
> 
> This is looking pretty good to me. I've made some minor comments on a couple
> of the patches, so please address those and repost with the Tested-bys that
> you received, then I can queue this for 4.19.
> 

Sure, will do so. Thanks Will.

-- 
Regards,
Sudeep
