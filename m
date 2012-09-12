From: cyril@ti.com (Cyril Chemparathy)
Date: Wed, 12 Sep 2012 19:45:57 -0400
Subject: [PATCH] of: specify initrd location using 64-bit
In-Reply-To: <5050EF3F.6030003@gmail.com>
References: <1347465937-7056-1-git-send-email-cyril@ti.com>
 <5050EF3F.6030003@gmail.com>
Message-ID: <50511EB5.800@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 9/12/2012 4:23 PM, Rob Herring wrote:
> On 09/12/2012 11:05 AM, Cyril Chemparathy wrote:
>> On some PAE architectures, the entire range of physical memory could reside
>> outside the 32-bit limit.  These systems need the ability to specify the
>> initrd location using 64-bit numbers.
>>
>> This patch globally modifies the early_init_dt_setup_initrd_arch() function to
>> use 64-bit numbers instead of the current unsigned long.
>
> S-o-B?
>

Sorry about that, will include in v2.

[...]
>> --- a/arch/arm/mm/init.c
>> +++ b/arch/arm/mm/init.c
>> @@ -76,7 +76,7 @@ static int __init parse_tag_initrd2(const struct tag *tag)
>>   __tagtable(ATAG_INITRD2, parse_tag_initrd2);
>>
>>   #ifdef CONFIG_OF_FLATTREE
>> -void __init early_init_dt_setup_initrd_arch(unsigned long start, unsigned long end)
>> +void __init early_init_dt_setup_initrd_arch(u64 start, u64 end)
>
> phys_initrd_start/size need to change too. Not sure about similar things
> on other arches.
>

I've fixed phys_initrd_start (not size) in another patch, please see [1].

> Does u-boot need similar fixes?
>

We aren't there yet :-)  We are currently running this platform without 
u-boot.


[1] http://permalink.gmane.org/gmane.linux.kernel/1356713

-- 
Thanks
- Cyril
