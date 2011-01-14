From: viresh.kumar@st.com (viresh kumar)
Date: Fri, 14 Jan 2011 15:39:18 +0530
Subject: [PATCH V3 07/63] ST SPEAr13XX: Adding machine specific src files
In-Reply-To: <4D302081.3040708@windriver.com>
References: <cover.1292833228.git.viresh.kumar@st.com>
	<a2b0ef370a46a862cd4c745c04bb73c4c4657103.1292833228.git.viresh.kumar@st.com>
	<4D302081.3040708@windriver.com>
Message-ID: <4D3020CE.6000602@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Stanley,

Thanks for reviewing!!

On 01/14/2011 03:38 PM, stanley.miao wrote:
> Viresh Kumar wrote:
>> <snip>
>> +
>> +void __cpuinit platform_secondary_init(unsigned int cpu)
>> +{
>> <snip>
>> +
>> +	/*
>> +	 * let the primary processor know we're out of the
>> +	 * pen, then head off into the C entry point
>> +	 */
>> +	pen_release = -1;
>> +	smp_wmb();
>>   
> 
> Russell has fixed this line. See commit
> 3705ff6da538aff6dba535e2e9cbcbb9456d0d53 in the latest kernel.
> 

Ya. I have already seen that in latest kernel and have updated it in
V4.

>> +
>> +	/*
>> +	 * Synchronise with the boot thread.
>> +	 */
>> +	spin_lock(&boot_lock);
>> +	spin_unlock(&boot_lock);
>> +}
>> +
>> <snip>
>> +void __init smp_prepare_cpus(unsigned int max_cpus)
>> +{
>> +	unsigned int ncores = get_core_count();
>> +	unsigned int cpu = smp_processor_id();
>> +	int i;
>> +
>> +	/* sanity check */
>> +	if (ncores == 0) {
>> +		pr_err("Realview: strange CM count of 0? Default to 1\n");
>>   
> 
> RealView ?

Oops!! Anyway this routine is changed now and this error is
also removed.

-- 
viresh
