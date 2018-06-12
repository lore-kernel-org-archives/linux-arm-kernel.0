From: sudeep.holla@arm.com (Sudeep Holla)
Date: Tue, 12 Jun 2018 10:06:27 +0100
Subject: [PATCH 0/5] arm64: numa/topology/smp: fix the cpumasks for CPU
 hotplug
In-Reply-To: <23796631-312b-82a0-fe03-cb7985433727@huawei.com>
References: <1528108797-13743-1-git-send-email-sudeep.holla@arm.com>
 <23796631-312b-82a0-fe03-cb7985433727@huawei.com>
Message-ID: <d6a7fc3c-fc3d-ac3c-cc6b-213e6da54598@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 12/06/18 02:14, Hanjun Guo wrote:
> Hi Sudeep,
> 
> On 2018/6/4 18:39, Sudeep Holla wrote:
>> Hi Will, Catalin, Jeremy, Morten,
>>
>> This is the fix I could come up for the issues we are seeing with arm64
>> for-next branch, in particular with commit 37c3ec2d810f ("arm64: topology:
>> divorce MC scheduling domain from core_siblings").
>>
>> The solution is to update the CPU topology during CPU hotplug operations
>> similar to other architectures like x86 and PPC. This is also inline
>> with the expection from the scheduler.
>>
>> I have cc-ed few Cavium and Huawei guys as they seem to have added or
>> modified the numa related code in the past.
> 
> Sorry for the late response, I can test on ARM64 NUMA systems
> with PPTT enabled, before I'm doing that, could you give some
> suggestion of the testing? what specific test case should I
> test? doing CPU offline/online when PPTT is enabled?
> 

Thanks for the response. I plan to post v2 after -rc1 which will have
some delta from this. So don't test this for now. Yes CPU hotplug tests
will be good. Also some NUMA based(numactl) assignments and try
hotplugging all CPUs in a node and similar tests with PPTT would be good.

-- 
Regards,
Sudeep
