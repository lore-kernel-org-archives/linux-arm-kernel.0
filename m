From: sudeep.holla@arm.com (Sudeep Holla)
Date: Thu, 19 Jul 2018 16:04:15 +0100
Subject: [PATCH v2] drivers/firmware: psci_checker: stash and use
 topology_core_cpumask for hotplug tests
In-Reply-To: <20180719142016.GD9213@e107981-ln.cambridge.arm.com>
References: <1531913132-21022-1-git-send-email-sudeep.holla@arm.com>
 <1532007349-9498-1-git-send-email-sudeep.holla@arm.com>
 <20180719142016.GD9213@e107981-ln.cambridge.arm.com>
Message-ID: <a1e03cce-4127-c959-8dc0-855636f6102c@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 19/07/18 15:20, Lorenzo Pieralisi wrote:
> On Thu, Jul 19, 2018 at 02:35:49PM +0100, Sudeep Holla wrote:

[...]

>> +static cpumask_var_t *alloc_cpu_groups(int num)
>> +{
>> +	int i;
>> +	cpumask_var_t *cpu_groups;
>> +
>> +	cpu_groups = kcalloc(num, sizeof(cpu_groups), GFP_KERNEL);
>> +	if (!cpu_groups)
>> +		return NULL;
>> +
>> +	for (i = 0; i < num; ++i)
>> +		if (!alloc_cpumask_var(&cpu_groups[i], GFP_KERNEL)) {
>> +			free_cpu_groups(num, cpu_groups);
>> +			return NULL;
>> +		}
>> +
>> +	return cpu_groups;
>> +}
> 
> Sorry for being a PITA - I meant we could remove find_cpu_groups()


Sorry that's exactly what I understood when I read it, but ...
got distracted with something else and when I returned back to it,
implemented something else.

> entirely and embed it in alloc_cpu_groups(), that takes a cpumask_t
> pointer and return the number of groups, again, to make it more
> readable but that's just my opinion.
> 

Sorry for not showing that much love to this, not paying too much
attention as it's test code :).

-- 
Regards,
Sudeep
