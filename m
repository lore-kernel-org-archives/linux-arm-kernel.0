From: Suzuki.Poulose@arm.com (Suzuki K Poulose)
Date: Fri, 17 Jun 2016 17:39:55 +0100
Subject: [PATCH 1/2] arm64: smp: Add function to determine if cpus are
 stuck in the kernel
In-Reply-To: <1466181432.7965.2.camel@infradead.org>
References: <1466156097-20028-1-git-send-email-james.morse@arm.com>
 <1466156097-20028-2-git-send-email-james.morse@arm.com>
 <1466181432.7965.2.camel@infradead.org>
Message-ID: <576427DB.6020600@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17/06/16 17:37, Geoff Levand wrote:
> On Fri, 2016-06-17 at 10:34 +0100, James Morse wrote:
>> +bool cpus_are_stuck_in_kernel(void)
>> +{
>> +> 	> bool ret = !!cpus_stuck_in_kernel;
>> +#ifdef CONFIG_HOTPLUG_CPU
>
> How about using 'if (IS_ENABLED(CONFIG_HOTPLUG_CPU))' here?
>
>> +	int any_cpu = raw_smp_processor_id();
>> +
>> +> 	> if (num_possible_cpus() > 1 && !cpu_ops[any_cpu]->cpu_die)
>> +> 	> 	> ret = true;
>> +#endif
>

That won't work, as the cpu_ops->cpu_die is defined only if CONFIG_HOTPLUG_CPU.

May be we should fix that.

Suzuki
