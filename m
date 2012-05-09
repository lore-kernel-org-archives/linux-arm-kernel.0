From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 09 May 2012 14:15:18 +0100
Subject: [PATCH] mach-shmobile: Emma Mobile EV2 SMP prototype code
In-Reply-To: <201205091212.08239.arnd@arndb.de>
References: <20120509075407.5991.60556.sendpatchset@w520>
 <201205091212.08239.arnd@arndb.de>
Message-ID: <4FAA6DE6.3040001@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/05/12 13:12, Arnd Bergmann wrote:
> On Wednesday 09 May 2012, Magnus Damm wrote:
>>  static unsigned int __init shmobile_smp_get_core_count(void)
>>  {
>> @@ -31,6 +32,9 @@ static unsigned int __init shmobile_smp_
>>  	if (is_r8a7779())
>>  		return r8a7779_get_core_count();
>>  
>> +	if (is_emev2())
>> +		return emev2_get_core_count();
>> +
>>  	return 1;
>>  }
>>  
>> @@ -41,6 +45,9 @@ static void __init shmobile_smp_prepare_
>>  
>>  	if (is_r8a7779())
>>  		r8a7779_smp_prepare_cpus();
>> +
>> +	if (is_emev2())
>> +		emev2_smp_prepare_cpus();
>>  }
>>  
>>  int shmobile_platform_cpu_kill(unsigned int cpu)
>> ...
> 
> This shows that we really want an abstraction for soc-specific SMP ops
> even within one platform, and we'll need the same thing for multiplatform.
> 
> Marc Zyngier already proposed a solution for this last year, but I
> think we couldn't agree on the details back then before he lost interest.
> I think we should pick that up again and get it into 3.6 so the code above
> can be simplified and we can do the multiplatform solution. We'll probably
> discuss the details in Hong Kong in a couple of weeks, so there is no
> point in changing it now, but I'd hope that you can migrate this to
> whatever we come up with in the following merge window.

I'm happy to revive the series if there is an interest.

	M.
-- 
Jazz is not dead. It just smells funny...
