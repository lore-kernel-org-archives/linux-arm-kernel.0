From: m.slodczyk2@partner.samsung.com (Maciej Slodczyk)
Date: Thu, 25 Jan 2018 11:42:23 +0100
Subject: [PATCH 7/7] arm64: uprobes - ARM32 instruction probing
In-Reply-To: <20180124161338.GA23561@redhat.com>
References: <1516797274-20320-1-git-send-email-m.slodczyk2@partner.samsung.com>
 <CGME20180124123458eucas1p2658b7f63104190fbbf12d06a9692a3a7@eucas1p2.samsung.com>
 <1516797274-20320-8-git-send-email-m.slodczyk2@partner.samsung.com>
 <20180124161338.GA23561@redhat.com>
Message-ID: <866e65ee-a12f-3c71-33cf-cde29f4e5e2c@partner.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/24/2018 05:13 PM, Oleg Nesterov wrote:
> On 01/24, Maciej Slodczyk wrote:
>>
>> Detect what kind of instruction is being probed and depending on the result:
>> - if an A64 instruction handle it the old way, using existing A64 instructions
>> probing code,
>> - if an A32 instruction decode it and handle using the new code, moved from
>> 32 bit arm kernel tree.
> 
> how this connects to the change in prepare_uretprobe(),
> 
>> --- a/kernel/events/uprobes.c
>> +++ b/kernel/events/uprobes.c
>> @@ -1566,6 +1566,9 @@ static void prepare_uretprobe(struct uprobe *uprobe, struct pt_regs *regs)
>>   	unsigned long orig_ret_vaddr, trampoline_vaddr;
>>   	bool chained;
>>
>> +	if (!current->mm)
>> +		return;
>> +
> 
> ?
> 
> and how it is possible to hit ->mm == NULL here?
> 

That's obviously something that shouldn't have been left here. NULL was 
there because of other bug that's been fixed. I put it for testing only 
and for some reason forgot to remove. Thanks for pointing that out!

Regards,
Maciej
