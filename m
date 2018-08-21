From: hejianet@gmail.com (Jia He)
Date: Tue, 21 Aug 2018 14:14:30 +0800
Subject: [RESEND PATCH v10 3/6] mm: page_alloc: reduce unnecessary binary
 search in memblock_next_valid_pfn()
In-Reply-To: <61ca29b9-a985-cce0-03e9-d216791c802c@microsoft.com>
References: <1530867675-9018-1-git-send-email-hejianet@gmail.com>
 <1530867675-9018-4-git-send-email-hejianet@gmail.com>
 <61ca29b9-a985-cce0-03e9-d216791c802c@microsoft.com>
Message-ID: <334337ca-811e-4a2e-09ff-65ebe37ef6df@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Pasha

On 8/17/2018 9:08 AM, Pasha Tatashin Wrote:
> 
>> Signed-off-by: Jia He <jia.he@hxt-semitech.com>
>> ---
>>  mm/memblock.c | 37 +++++++++++++++++++++++++++++--------
>>  1 file changed, 29 insertions(+), 8 deletions(-)
>>
>> diff --git a/mm/memblock.c b/mm/memblock.c
>> index ccad225..84f7fa7 100644
>> --- a/mm/memblock.c
>> +++ b/mm/memblock.c
>> @@ -1140,31 +1140,52 @@ int __init_memblock memblock_set_node(phys_addr_t base, phys_addr_t size,
>>  #endif /* CONFIG_HAVE_MEMBLOCK_NODE_MAP */
>>  
>>  #ifdef CONFIG_HAVE_MEMBLOCK_PFN_VALID
>> +static int early_region_idx __init_memblock = -1;
> 
> One comment:
> 
> This should be __initdata, but even better bring it inside the function
> as local static variable.
> 
Seems it should be __initdata_memblock instead of __initdata?

-- 
Cheers,
Jia
>>  ulong __init_memblock memblock_next_valid_pfn(ulong pfn)
>>  {
> 
> Otherwise looks good:
> 
> Reviewed-by: Pavel Tatashin <pavel.tatashin@microsoft.com>
> 
