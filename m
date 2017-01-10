From: labbott@redhat.com (Laura Abbott)
Date: Mon, 9 Jan 2017 17:07:53 -0800
Subject: [PATCHv2 1/2] arm: Cleanup sanity_check_meminfo
In-Reply-To: <alpine.LFD.2.20.1701052308020.21662@knanqh.ubzr>
References: <1483657274-11346-1-git-send-email-labbott@redhat.com>
 <1483657274-11346-2-git-send-email-labbott@redhat.com>
 <alpine.LFD.2.20.1701052308020.21662@knanqh.ubzr>
Message-ID: <7d93f84e-c533-4295-7361-bd4455592584@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/05/2017 08:17 PM, Nicolas Pitre wrote:
> On Thu, 5 Jan 2017, Laura Abbott wrote:
> 
>>
>> The logic for sanity_check_meminfo has become difficult to
>> follow. Clean up the code so it's more obvious what the code
>> is actually trying to do. Additionally, meminfo is now removed
>> so rename the function to better describe it's purpose.
> 
> s/it's/its/
> 
>> Signed-off-by: Laura Abbott <lauraa@codeaurora.org>
>> Signed-off-by: Laura Abbott <labbott@redhat.com>
>> ---
>> v2: Fixed code so b9a019899f61 ("ARM: 8590/1: sanity_check_meminfo():
>> avoid overflow on vmalloc_limit") should stay fixed. The casting and assignment
>> still seem ugly.
> 
> Are you referring to the initial vmalloc_limit assignment?
> 

I was referring to the min_t with u64 that gets assigned to phys_addr_t.
for lowmem_limit

>> @@ -1172,43 +1170,19 @@ void __init sanity_check_meminfo(void)
>>  	for_each_memblock(memory, reg) {
>>  		phys_addr_t block_start = reg->base;
>>  		phys_addr_t block_end = reg->base + reg->size;
>> -		phys_addr_t size_limit = reg->size;
>>  
>> -		if (reg->base >= vmalloc_limit)
>> -			highmem = 1;
>> -		else
>> -			size_limit = vmalloc_limit - reg->base;
>>  
>> -
> [...]
> 
> This leaves a spurious empty line. One was already there before your 
> patch but this would be a good opportunity to remove it.
> 
> Other than that...
> 
> Reviewed-by: Nicolas Pitre <nico@linaro.org>
> 
> 
> Nicolas
> 

Thanks,
Laura
