From: vladimir.murzin@arm.com (Vladimir Murzin)
Date: Tue, 03 Mar 2015 09:26:58 +0000
Subject: [RFC PATCH 3/4] arm64: add support for memtest
In-Reply-To: <20150302185607.GG7919@arm.com>
References: <1425308145-20769-1-git-send-email-vladimir.murzin@arm.com>
 <1425308145-20769-4-git-send-email-vladimir.murzin@arm.com>
 <20150302185607.GG7919@arm.com>
Message-ID: <54F57E62.6050206@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/03/15 18:56, Will Deacon wrote:
> On Mon, Mar 02, 2015 at 02:55:44PM +0000, Vladimir Murzin wrote:
>> Add support for memtest command line option.
>>
>> Signed-off-by: Vladimir Murzin <vladimir.murzin@arm.com>
>> ---
>>  arch/arm64/mm/init.c |    2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
>> index ae85da6..597831b 100644
>> --- a/arch/arm64/mm/init.c
>> +++ b/arch/arm64/mm/init.c
>> @@ -190,6 +190,8 @@ void __init bootmem_init(void)
>>  	min = PFN_UP(memblock_start_of_DRAM());
>>  	max = PFN_DOWN(memblock_end_of_DRAM());
>>  
>> +	early_memtest(min << PAGE_SHIFT, max << PAGE_SHIFT);
>> +
>>  	/*
>>  	 * Sparsemem tries to allocate bootmem in memory_present(), so must be
>>  	 * done after the fixed reservations.
> 
> This is really neat, thanks for doing this Vladimir!
> 
>   Acked-by: Will Deacon <will.deacon@arm.com>
> 
> For the series, modulo Baruch's comments about Documentation updates.
> 
> Will
> 

Thanks Will! I'll wait for awhile for other comments and repost updated
version.

I wonder which tree it might go?

Thanks
Vladimir

> --
> To unsubscribe, send a message with 'unsubscribe linux-mm' in
> the body to majordomo at kvack.org.  For more info on Linux MM,
> see: http://www.linux-mm.org/ .
> Don't email: <a href=mailto:"dont@kvack.org"> email at kvack.org </a>
> 
> 
