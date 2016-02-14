From: wangkefeng.wang@huawei.com (Kefeng Wang)
Date: Sun, 14 Feb 2016 16:57:18 +0800
Subject: [PATCH] arm64: mm: dump: Use VA_START directly instead of private
 LOWEST_ADDR
In-Reply-To: <20160201102345.GB674@leverpostej>
References: <1454140521-741-1-git-send-email-wangkefeng.wang@huawei.com>
 <20160201102345.GB674@leverpostej>
Message-ID: <56C0416E.6050908@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Catalin and Will,  ping...

On 2016/2/1 18:23, Mark Rutland wrote:
> On Sat, Jan 30, 2016 at 03:55:21PM +0800, Kefeng Wang wrote:
>> Use VA_START macro in asm/memory.h instead of private LOWEST_ADDR
>> definition in dump.c.
>>
>> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> 
> FWIW:
> 
> Acked-by: Mark Rutland <mark.rutland@arm.com>
> 
> Mark.
> 
>> ---
>>  arch/arm64/mm/dump.c | 4 +---
>>  1 file changed, 1 insertion(+), 3 deletions(-)
>>
>> diff --git a/arch/arm64/mm/dump.c b/arch/arm64/mm/dump.c
>> index 0adbebb..b3c62b1 100644
>> --- a/arch/arm64/mm/dump.c
>> +++ b/arch/arm64/mm/dump.c
>> @@ -27,8 +27,6 @@
>>  #include <asm/pgtable.h>
>>  #include <asm/pgtable-hwdef.h>
>>  
>> -#define LOWEST_ADDR	(UL(0xffffffffffffffff) << VA_BITS)
>> -
>>  struct addr_marker {
>>  	unsigned long start_address;
>>  	const char *name;
>> @@ -316,7 +314,7 @@ static int ptdump_show(struct seq_file *m, void *v)
>>  		.marker = address_markers,
>>  	};
>>  
>> -	walk_pgd(&st, &init_mm, LOWEST_ADDR);
>> +	walk_pgd(&st, &init_mm, VA_START);
>>  
>>  	note_page(&st, 0, 0, 0);
>>  	return 0;
>> -- 
>> 2.6.0.GIT
>>
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel at lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>>
> 
> .
> 
