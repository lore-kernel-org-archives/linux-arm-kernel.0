From: f.fainelli@gmail.com (Florian Fainelli)
Date: Tue, 6 Dec 2016 14:47:01 -0800
Subject: [PATCH 1/3] ARM: Define KERNEL_START and KERNEL_END
In-Reply-To: <SG2PR06MB116569D2A9756BE11131CB4B8A820@SG2PR06MB1165.apcprd06.prod.outlook.com>
References: <1480445729-27130-1-git-send-email-labbott@redhat.com>
 <20161206195312.22354-1-f.fainelli@gmail.com>
 <20161206195312.22354-2-f.fainelli@gmail.com>
 <SG2PR06MB116569D2A9756BE11131CB4B8A820@SG2PR06MB1165.apcprd06.prod.outlook.com>
Message-ID: <cb35df10-feac-6eff-f847-4cfba74a5bca@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/06/2016 02:43 PM, Chris Brandt wrote:
> On 12/6/2016, Florian Fainelli wrote:
>> diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
>> index 4001dd15818d..18ef688a796e 100644
>> --- a/arch/arm/mm/mmu.c
>> +++ b/arch/arm/mm/mmu.c
>> @@ -1437,12 +1437,8 @@ static void __init kmap_init(void)
>>  static void __init map_lowmem(void)
>>  {
>>  	struct memblock_region *reg;
>> -#ifdef CONFIG_XIP_KERNEL
>> -	phys_addr_t kernel_x_start = round_down(__pa(_sdata), SECTION_SIZE);
>> -#else
>> -	phys_addr_t kernel_x_start = round_down(__pa(_stext), SECTION_SIZE);
>> -#endif
>> -	phys_addr_t kernel_x_end = round_up(__pa(__init_end), SECTION_SIZE);
>> +	phys_addr_t kernel_x_start = round_down(__pa(KERNEL_START),
>> SECTION_SIZE);
>> +	phys_addr_t kernel_x_end = round_down(__pa(_end), SECTION_SIZE);
> 
> Why are you changing the end of executable kernel (hence the 'x' in
> kernel_x_end) from __init_end to _end which basically maps the entire
> kernel image including text and data?

That's a typo, was not intentional thanks for spotting it.
-- 
Florian
