From: vladimir.murzin@arm.com (Vladimir Murzin)
Date: Tue, 22 Nov 2016 11:50:57 +0000
Subject: [RFC PATCH 09/11] ARM: NOMMU: define SECTION_xxx macros
In-Reply-To: <20161122100713.GW1041@n2100.armlinux.org.uk>
References: <1479806768-39911-1-git-send-email-vladimir.murzin@arm.com>
 <1479806768-39911-10-git-send-email-vladimir.murzin@arm.com>
 <20161122100713.GW1041@n2100.armlinux.org.uk>
Message-ID: <58343121.4030906@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 22/11/16 10:07, Russell King - ARM Linux wrote:
> On Tue, Nov 22, 2016 at 09:26:06AM +0000, Vladimir Murzin wrote:
>> Pickup defines from pgtable-2level.h to make NOMMU build happy.
> 
> This needs more detail.
> 

It comes from

  CC      arch/arm/kernel/setup.o
arch/arm/kernel/setup.c: In function 'reserve_crashkernel':
arch/arm/kernel/setup.c:1001:25: error: 'SECTION_SIZE' undeclared (first use in this function)
             crash_size, SECTION_SIZE);
                         ^
arch/arm/kernel/setup.c:1001:25: note: each undeclared identifier is reported only once for each function it appears in
make[1]: *** [arch/arm/kernel/setup.o] Error 1
make: *** [arch/arm/kernel] Error 2

Cheers
Vladimir

>>
>> Cc: Russell King <linux@armlinux.org.uk>
>> Signed-off-by: Vladimir Murzin <vladimir.murzin@arm.com>
>> ---
>>  arch/arm/include/asm/pgtable-nommu.h |    5 +++++
>>  1 file changed, 5 insertions(+)
>>
>> diff --git a/arch/arm/include/asm/pgtable-nommu.h b/arch/arm/include/asm/pgtable-nommu.h
>> index add094d..9115801 100644
>> --- a/arch/arm/include/asm/pgtable-nommu.h
>> +++ b/arch/arm/include/asm/pgtable-nommu.h
>> @@ -35,6 +35,11 @@
>>  
>>  #define PGDIR_SIZE		(1UL << PGDIR_SHIFT)
>>  #define PGDIR_MASK		(~(PGDIR_SIZE-1))
>> +
>> +#define SECTION_SHIFT           20
>> +#define SECTION_SIZE            (1UL << SECTION_SHIFT)
>> +#define SECTION_MASK            (~(SECTION_SIZE-1))
>> +
>>  /* FIXME */
>>  
>>  #define PAGE_NONE	__pgprot(0)
>> -- 
>> 1.7.9.5
>>
> 
