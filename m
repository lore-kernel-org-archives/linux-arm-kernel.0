From: yalin.wang2010@gmail.com (yalin wang)
Date: Fri, 24 Jul 2015 11:56:59 +0800
Subject: [RFC] arm64:use set_fixmap_offset to make it more clear
In-Reply-To: <20150723130344.GC27052@e104818-lin.cambridge.arm.com>
References: <A5D61263-B664-469F-9F49-160D6E17F432@gmail.com>
 <20150723130344.GC27052@e104818-lin.cambridge.arm.com>
Message-ID: <9E910A45-D4AB-44F6-878F-3CB2372B3660@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> On Jul 23, 2015, at 21:03, Catalin Marinas <catalin.marinas@arm.com> wrote:
> 
> On Thu, Jul 23, 2015 at 07:45:53PM +0800, yalin wang wrote:
>> A little change to patch_map() function,
>> use set_fixmap_offset() to make code more clear.
>> 
>> Signed-off-by: yalin wang <yalin.wang2010@gmail.com>
>> ---
>> arch/arm64/kernel/insn.c | 5 ++---
>> 1 file changed, 2 insertions(+), 3 deletions(-)
>> 
>> diff --git a/arch/arm64/kernel/insn.c b/arch/arm64/kernel/insn.c
>> index dd9671c..7dafd5a 100644
>> --- a/arch/arm64/kernel/insn.c
>> +++ b/arch/arm64/kernel/insn.c
>> @@ -101,9 +101,8 @@ static void __kprobes *patch_map(void *addr, int fixmap)
>> 		return addr;
>> 
>> 	BUG_ON(!page);
>> -	set_fixmap(fixmap, page_to_phys(page));
>> -
>> -	return (void *) (__fix_to_virt(fixmap) + (uintaddr & ~PAGE_MASK));
>> +	return (void *)set_fixmap_offset(fixmap, page_to_phys(page) +
>> +			(addr & ~PAGE_MASK));
> 
> It looks fine. Do you get any compiler warning for the automatic pointer
> to long conversion? You may want to add some explicit casts, otherwise:
> 
> Acked-by: Catalin Marinas <catalin.marinas@arm.com>
i have build it, there is no warning about this change. :)
Thanks
