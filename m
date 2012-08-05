From: cyril@ti.com (Cyril Chemparathy)
Date: Sun, 5 Aug 2012 10:23:20 -0400
Subject: [PATCH 08/22] ARM: LPAE: use phys_addr_t for initrd location
 and size
In-Reply-To: <alpine.LFD.2.02.1208040255100.5231@xanadu.home>
References: <1343775898-28345-1-git-send-email-cyril@ti.com>
 <1343775898-28345-9-git-send-email-cyril@ti.com>
 <alpine.LFD.2.02.1208040255100.5231@xanadu.home>
Message-ID: <501E81D8.1010600@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 8/4/2012 2:57 AM, Nicolas Pitre wrote:
> On Tue, 31 Jul 2012, Cyril Chemparathy wrote:
>
>> From: Vitaly Andrianov <vitalya@ti.com>
>>
>> This patch fixes the initrd setup code to use phys_addr_t instead of assuming
>> 32-bit addressing.  Without this we cannot boot on systems where initrd is
>> located above the 4G physical address limit.
>>
>> Signed-off-by: Vitaly Andrianov <vitalya@ti.com>
>> Signed-off-by: Cyril Chemparathy <cyril@ti.com>
>> ---
>>   arch/arm/mm/init.c |   14 +++++++-------
>>   1 file changed, 7 insertions(+), 7 deletions(-)
>>
>> diff --git a/arch/arm/mm/init.c b/arch/arm/mm/init.c
>> index 8252c31..51f3e92 100644
>> --- a/arch/arm/mm/init.c
>> +++ b/arch/arm/mm/init.c
>> @@ -36,12 +36,12 @@
>>
>>   #include "mm.h"
>>
>> -static unsigned long phys_initrd_start __initdata = 0;
>> -static unsigned long phys_initrd_size __initdata = 0;
>> +static phys_addr_t phys_initrd_start __initdata = 0;
>> +static phys_addr_t phys_initrd_size __initdata = 0;
>
> phys_addr_t for the initrd size is rather overkill, isn't it?
>

Fair enough. :-)

>
> Nicolas
>

-- 
Thanks
- Cyril
