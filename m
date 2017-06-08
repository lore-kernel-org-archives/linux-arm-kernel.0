From: vladimir.murzin@arm.com (Vladimir Murzin)
Date: Thu, 8 Jun 2017 09:29:24 +0100
Subject: [PATCH] ARM: V7M: Set cacheid iff DminLine or IminLine is nonzero
In-Reply-To: <bf924528-164b-8dda-eeea-376f1faa5eb8@arm.com>
References: <1493201074-35472-1-git-send-email-vladimir.murzin@arm.com>
 <6c933cd2-bfaf-e7d3-b868-9d9955a1a105@arm.com>
 <20170503191437.GB22219@n2100.armlinux.org.uk>
 <8e0ee9d1-ba0e-9083-0299-80f9f32444ce@arm.com>
 <bf924528-164b-8dda-eeea-376f1faa5eb8@arm.com>
Message-ID: <43dbdd8a-3806-34bb-1388-3a3428d7d0c1@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ping!

On 26/05/17 10:52, Vladimir Murzin wrote:
> Gentle ping...
> 
> On 04/05/17 09:13, Vladimir Murzin wrote:
>> On 03/05/17 20:14, Russell King - ARM Linux wrote:
>>> On Tue, May 02, 2017 at 09:31:24AM +0100, Vladimir Murzin wrote:
>>>> On 26/04/17 11:04, Vladimir Murzin wrote:
>>>>> Cache support is optional feature in M-class cores, thus DminLine or
>>>>> IminLine of Cache Type Register is zero if caches are not implemented,
>>>>> but we check the whole CTR which has other features encoded there.
>>>>> Let's be more precise and check for DminLine and IminLine of CTR
>>>>> before we set cacheid.
>>>>>
>>>>> Signed-off-by: Vladimir Murzin <vladimir.murzin@arm.com>
>>>>> ---
>>>>>  arch/arm/kernel/setup.c | 2 +-
>>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
>>>>> index f4e5450..231a1d83 100644
>>>>> --- a/arch/arm/kernel/setup.c
>>>>> +++ b/arch/arm/kernel/setup.c
>>>>> @@ -315,7 +315,7 @@ static void __init cacheid_init(void)
>>>>>  	if (arch >= CPU_ARCH_ARMv6) {
>>>>>  		unsigned int cachetype = read_cpuid_cachetype();
>>>>>  
>>>>> -		if ((arch == CPU_ARCH_ARMv7M) && !cachetype) {
>>>>> +		if ((arch == CPU_ARCH_ARMv7M) && !(cachetype & 0xf000f)) {
>>>>>  			cacheid = 0;
>>>>>  		} else if ((cachetype & (7 << 29)) == 4 << 29) {
>>>>>  			/* ARMv7 register format */
>>>>>
>>>>
>>>> Ok for patch tracker?
>>>
>>> Not yet, I've been away and I've no time right now to evaluate this
>>> change.  I'm hopefully going to catch up with some email in the coming
>>> days.
>>>
>>
>> Noted.
>>
>> Cheers
>> Vladimir
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel at lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>>
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
