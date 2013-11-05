From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue, 05 Nov 2013 09:27:17 -0800
Subject: [PATCH 05/11] ARM: Introduce CPU_METHOD_OF_DECLARE() for cpu
 hotplug/smp
In-Reply-To: <E3155290-B7BD-4559-BB0E-6C6C7D74ACFB@codeaurora.org>
References: <1383343739-23080-1-git-send-email-sboyd@codeaurora.org>
 <1383343739-23080-6-git-send-email-sboyd@codeaurora.org>
 <E3155290-B7BD-4559-BB0E-6C6C7D74ACFB@codeaurora.org>
Message-ID: <52792A75.6060306@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/05/13 09:24, Kumar Gala wrote:
> On Nov 1, 2013, at 5:08 PM, Stephen Boyd wrote:
>
>> @@ -150,8 +182,14 @@ void __init arm_dt_init_cpu_maps(void)
>> 		}
>>
>> 		tmp_map[i] = hwid;
>> +
>> +		if (!found_method)
>> +			found_method = set_smp_ops_by_method(cpu);
>> 	}
>>
>> +	if (!found_method)
>> +		set_smp_ops_by_method(cpus);
>> +
> I assume this if for the case that the enable method is in the cpus{ } container but not in a specific cpu node?
>
> If so, the binding is not clear that we allow this.  Also a comment would probably be nice.

Sure I'll add a comment to that effect and clarify the binding.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
