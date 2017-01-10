From: sudeep.holla@arm.com (Sudeep Holla)
Date: Tue, 10 Jan 2017 10:01:37 +0000
Subject: [QUESTION] Arm64: Query L3 cache info via DT
In-Reply-To: <5874A03A.9000901@huawei.com>
References: <58633494.9030708@huawei.com>
 <81784854-11f8-468a-a280-69be0a714a3b@arm.com> <5874A03A.9000901@huawei.com>
Message-ID: <536f64cc-357c-40a1-b2a0-1db0c4280fc0@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 10/01/17 08:50, Tan Xiaojun wrote:
> I add this patch, and test in Hisilicon D02/D03. It can work well.
> 
> I'm sorry to reply so late. I took some time to debug, because I am not familiar with the code.
> 
>> +	if (level < of_level) {
>> +		/*
>> +		 * some external caches not specified in CLIDR_EL1
>> +		 * the information may be available in the device tree
>> +		 * only unified external caches are considered here
>> +		 */
>> +		level = of_level;
>> +		leaves += (of_level - level);
> 
> The above two lines need to exchange the location.
> 

Ah crap, sorry for such a silly mistake.
I will post proper patch(es) soon.

-- 
Regards,
Sudeep
