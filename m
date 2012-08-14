From: Sudeep.KarkadaNagesha@arm.com (Sudeep KarkadaNagesha)
Date: Tue, 14 Aug 2012 09:43:12 +0100
Subject: [PATCH 4/9] ARM: pmu: remove arm_pmu_type enumeration
In-Reply-To: <50297838.7080208@broadcom.com>
References: <1344620195-22372-1-git-send-email-will.deacon@arm.com>
 <1344620195-22372-5-git-send-email-will.deacon@arm.com>
 <50297838.7080208@broadcom.com>
Message-ID: <502A0FA0.3010602@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jiandong,

On 13/08/12 22:57, Jiandong Zheng wrote:
> On 8/10/2012 10:36 AM, Will Deacon wrote:
>> From: Sudeep KarkadaNagesha <Sudeep.KarkadaNagesha@arm.com>
>>    static struct platform_device pmu_device = {
>>    	.name		= "arm-pmu",
>> -	.id		= ARM_PMU_DEVICE_CPU,
>> +	.id		= -1,
>>    	.resource	= &pmu_resource,
>>    	.num_resources	= 1,
>>    };
>>
> Isn't it clearer to define a meaningful name for "-1", esp. if "-1" is
> being checked somewhere else?

No platform_device->id is not being referred anywhere. 
ARM_PMU_DEVICE_CPU was initially assigned to id to identify different 
PMU types through platform_device->id variable but was never used.

Also for all new platforms that might support multiple PMUs, we can use 
device tree to identify them.

Regards,
Sudeep
