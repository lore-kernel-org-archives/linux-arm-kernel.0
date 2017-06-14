From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 14 Jun 2017 09:04:16 +0100
Subject: [PATCH v2 4/5] ARM: perf: Allow the use of the PMUv3 driver on
 32bit ARM
In-Reply-To: <3598f402-172d-b901-f4b8-1f0050abcd24@arm.com>
References: <20170613142837.29738-1-marc.zyngier@arm.com>
 <20170613142837.29738-5-marc.zyngier@arm.com>
 <3598f402-172d-b901-f4b8-1f0050abcd24@arm.com>
Message-ID: <a0ec870f-4c7b-7064-2904-ece7ef1ba733@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13/06/17 16:40, Vladimir Murzin wrote:
> Hi Marc,
> 
> On 13/06/17 15:28, Marc Zyngier wrote:
>> +static inline int read_pmuver(void)
>> +{
>> +	u32 dfr0 = read_sysreg(ID_DFR0);
>> +	int vers = (s8)((dfr0 >> 24) & 0xff);
>> +
>> +	if (vers < 3)
>> +		vers = -1;
>> +
>> +	return vers;
>> +}
> 
> Alternatively, PMU version can be extracted with existent helper:
> 
> int vers = cpuid_feature_extract(CPUID_EXT_DFR0, 24);
> 
> Not sure which of these two is preferred...

Clearly, your solution looks much better than my open-coded version.
I'll use that in the next round.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
