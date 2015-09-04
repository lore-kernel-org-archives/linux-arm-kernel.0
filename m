From: lina.iyer@linaro.org (Lina Iyer)
Date: Fri, 4 Sep 2015 09:13:05 -0600
Subject: [PATCH v2 7/7] ARM: smp: Add runtime PM support for CPU hotplug
In-Reply-To: <20150904035910.GL15099@codeaurora.org>
References: <1441310314-8857-1-git-send-email-lina.iyer@linaro.org>
 <1441310314-8857-8-git-send-email-lina.iyer@linaro.org>
 <20150904035910.GL15099@codeaurora.org>
Message-ID: <20150904151305.GB876@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 03 2015 at 21:59 -0600, Stephen Boyd wrote:
>On 09/03, Lina Iyer wrote:
>> @@ -137,7 +138,6 @@ int __cpu_up(unsigned int cpu, struct task_struct *idle)
>>  		pr_err("CPU%u: failed to boot: %d\n", cpu, ret);
>>  	}
>>
>> -
>
>Please remove noise.
>
Sorry, I forgot to address it earlier. Thought I did.
Apologize.

>>  	memset(&secondary_data, 0, sizeof(secondary_data));
>>  	return ret;
>>  }
>> @@ -271,6 +271,16 @@ void __cpu_die(unsigned int cpu)
>>  void __ref cpu_die(void)
>>  {
>>  	unsigned int cpu = smp_processor_id();
>> +	struct device *cpu_dev;
>> +
>> +	/*
>> +	 * We dont need the CPU device anymore.
>
>s/dont/don't/
>
>> +	 * Lets do this before IRQs are disabled to allow
>
>s/Lets/Let's/
>
>> +	 * runtime PM to suspend the domain as well.
>> +	 */
>
>-- 
>Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
>a Linux Foundation Collaborative Project
