From: Sudeep.KarkadaNagesha@arm.com (Sudeep KarkadaNagesha)
Date: Wed, 30 Oct 2013 14:22:35 +0000
Subject: [PATCH -next v2] arm64: use for_each_node_by_type() macro
In-Reply-To: <20131030121610.GJ3975@mbp>
References: <CAPgLHd_aQROa0-vycghYz9A9Jx4MbC131C819xPHZg_hrTQC7w@mail.gmail.com>
 <52709A9E.8060800@gmail.com>
 <CAPgLHd_r3_svSfrraO-oHyZbXg0O9brsjheO6ds9jL9rYbOfmA@mail.gmail.com>
 <5270F238.6010602@arm.com> <20131030121610.GJ3975@mbp>
Message-ID: <5271162B.9070804@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 30/10/13 12:16, Catalin Marinas wrote:
> On Wed, Oct 30, 2013 at 11:49:12AM +0000, Sudeep KarkadaNagesha wrote:
>> On 30/10/13 05:54, Wei Yongjun wrote:
>>> From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
>>>
>>> Use for_each_node_by_type() macro instead of open coding it.
>>>
>>> Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
>>> ---
>>> v1 -> v2: remove extra space
>>> ---
>>>  arch/arm64/kernel/cpu_ops.c | 4 ++--
>>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/arch/arm64/kernel/cpu_ops.c b/arch/arm64/kernel/cpu_ops.c
>>> index aa0c9e7..37a4977 100644
>>> --- a/arch/arm64/kernel/cpu_ops.c
>>> +++ b/arch/arm64/kernel/cpu_ops.c
>>> @@ -78,10 +78,10 @@ int __init cpu_read_ops(struct device_node *dn, int cpu)
>>>  
>>>  void __init cpu_read_bootcpu_ops(void)
>>>  {
>>> -	struct device_node *dn = NULL;
>>> +	struct device_node *dn;
>>>  	u64 mpidr = cpu_logical_map(0);
>>>  
>>> -	while ((dn = of_find_node_by_type(dn, "cpu"))) {
>>> +	for_each_node_by_type(dn, "cpu") {
>>>  		u64 hwid;
>>>  		const __be32 *prop;
>>>  
>>
>> In fact this function can be simplified by making use of OF helper directly,
>> something like below snippet. But it requires [1] for correct functionality.
> 
> Thanks. Could you please send a properly formatted patch on top of [1]?

Yes it's done [2]

Regards,
Sudeep

[2] http://www.spinics.net/lists/arm-kernel/msg283243.html
