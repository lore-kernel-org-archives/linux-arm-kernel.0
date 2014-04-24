From: t.figa@samsung.com (Tomasz Figa)
Date: Thu, 24 Apr 2014 18:01:06 +0200
Subject: [PATCH v8 1/3] ARM: EXYNOS: Add support for EXYNOS5410 SoC
In-Reply-To: <534BCD88.4020108@samsung.com>
References: <1397459860-21869-1-git-send-email-t.dakhran@samsung.com>
 <1397459860-21869-2-git-send-email-t.dakhran@samsung.com>
 <5617478.sn2TYu7iO3@wuerfel> <534BCD88.4020108@samsung.com>
Message-ID: <53593542.9010106@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tarek,

On 14.04.2014 13:59, Tarek Dakhran wrote:
> On 04/14/2014 03:03 PM, Arnd Bergmann wrote:
>> On Monday 14 April 2014 11:17:38 Tarek Dakhran wrote:
>>> --- a/arch/arm/mach-exynos/exynos.c
>>> +++ b/arch/arm/mach-exynos/exynos.c
>>> @@ -159,6 +159,15 @@ static struct map_desc exynos5250_iodesc[]
>>> __initdata = {
>>>          },
>>>   };
>>> +static struct map_desc exynos5410_iodesc[] __initdata = {
>>> +       {
>>> +               .virtual        = (unsigned long)S5P_VA_SYSRAM_NS,
>>> +               .pfn            =
>>> __phys_to_pfn(EXYNOS5410_PA_SYSRAM_NS),
>>> +               .length         = SZ_4K,
>>> +               .type           = MT_DEVICE,
>>> +       },
>>> +};
>>> +
>>>   static struct map_desc exynos5_iodesc[] __initdata = {
>> NAK
>>
>> Why does this keep coming up?
>>
>>     Arnd
>>
> We need this memory region because boot address for exynos5410 located
> here, same as for 5250.
>

Is there really no way to map this region dynamically in the entity 
(driver, source file, whatever) that actually uses it? The goal is to 
get rid of all the static mappings entirely, so adding new one makes us 
further from it.

Best regards,
Tomasz
