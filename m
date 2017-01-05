From: Chris.Packham@alliedtelesis.co.nz (Chris Packham)
Date: Thu, 5 Jan 2017 20:49:49 +0000
Subject: [PATCHv2 2/5] arm: mvebu: support for SMP on 98DX3336 SoC
References: <20170105033641.6212-1-chris.packham@alliedtelesis.co.nz>
 <20170105033641.6212-3-chris.packham@alliedtelesis.co.nz>
 <5edb6751-d15b-6654-f4ae-adf38fafb8a4@gmail.com>
 <dd384eda81d2420dafe740bf5bb4dae0@svr-chch-ex1.atlnz.lc>
Message-ID: <b71083040acf4fbb9341be3c1e70a930@svr-chch-ex1.atlnz.lc>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/01/17 17:46, Chris Packham wrote:
> On 05/01/17 17:04, Florian Fainelli wrote:
>> Le 01/04/17 ? 19:36, Chris Packham a ?crit :
>>> +}
>>> +
>>> +static int __init mv98dx3236_resume_init(void)
>>> +{
>>> +	struct device_node *np;
>>> +	struct resource res;
>>> +	int ret = 0;
>>> +
>>> +	np = of_find_matching_node(NULL, of_mv98dx3236_resume_table);
>>> +	if (!np)
>>> +		return 0;
>>
>> Can't this function be implemented as a smp_ops::smp_init_cpus instead
>> of having this initialization done at arch_initcall time?
>>
>
> I'll look into it. My initial reaction is no because I still need
> armada_xp_smp_init_cpus().
>

I looked at this. I could write a mv98dx3236_smp_init_cpus() that calls 
armada_xp_smp_init_cpus() and inits the resume controller address. My 
original reason for this approach was to parallel mvebu_v7_pmsu_init. I 
won't do anything just yet but is there any downside to the current 
approach?
