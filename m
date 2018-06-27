From: sudeep.holla@arm.com (Sudeep Holla)
Date: Wed, 27 Jun 2018 10:31:12 +0100
Subject: [PATCH v2 0/7] arm64: numa/topology/smp: update the cpumasks for
 CPU hotplug
In-Reply-To: <5B332228.40204@caviumnetworks.com>
References: <1529327923-17911-1-git-send-email-sudeep.holla@arm.com>
 <5B332228.40204@caviumnetworks.com>
Message-ID: <62111bfd-87a7-061b-9934-5c3bf2be9dbe@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 27/06/18 06:35, Ganapatrao Kulkarni wrote:
> 
> Hi Sudeep,
> 
> On 06/18/2018 06:48 PM, Sudeep Holla wrote:
>>
>> Hi,
>>
>> Commit 37c3ec2d810f ("arm64: topology: divorce MC scheduling domain
>> from core_siblings")
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
> testing looks ok on Cavium's ThunderX2 system.
> please feel free to add,
> 
> Tested-by: Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>
> 

Thanks Ganapat.

-- 
Regards,
Sudeep
