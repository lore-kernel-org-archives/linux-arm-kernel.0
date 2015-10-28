From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Wed, 28 Oct 2015 18:36:04 +0900
Subject: [PATCH v2 1/4] ARM: dts: Add SROMc to Exynos 5410
In-Reply-To: <563095BE.9050106@samsung.com>
References: <cover.1445935215.git.p.fedin@samsung.com>
 <91ae80f172192fa4dbc8bf8ee5a9068661592de6.1445935215.git.p.fedin@samsung.com>
 <56302F1F.5090206@samsung.com> <009001d1114f$3c7a1f60$b56e5e20$@samsung.com>
 <56307824.1050302@samsung.com> <563095BE.9050106@samsung.com>
Message-ID: <56309704.90904@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 28.10.2015 18:30, Pankaj Dubey wrote:
> Hi
> 
> On Wednesday 28 October 2015 12:54 PM, Krzysztof Kozlowski wrote:
>> On 28.10.2015 16:06, Pavel Fedin wrote:
>>>   Hello!
>>>
>>>>> +        sromc: sromc at 12250000 {
>>>>> +            compatible = "samsung,exynos-srom";
>>>>> +            reg = <0x12250000 0x10>;
>>>>
>>>> Isn't 0x10 too small (SROM_BC3 won't be mapped)?
>>>
>>>   Muhaha, indeed, thanks for noticing this.
>>>   By the way, i've just checked exynos4.dtsi and exynos5.dtsi, they
>>> specify the same size. Did reviewers overlook this small thing?
>>
>> Yep, I pointed that 0x100 (from first version of patchset) is too big...
>> but did not exactly check the length of new value.
>>
> 
> Yes, once you pointed out I checked UM for Exynos4415, Exynos5250,
> Exynos5420 and Exynos5410 and all these manuals talks about SROM_BC{0-3}
> only. There is no offset such as SROM_BC{4,5} at least in these SoC
> manuals. Accordingly I modified size from 0x100 to 0x10. But looks like
> I missed to remove SROM_BC{{4,5} from exynos-srom.h. I checked only
> these registers are used in the driver, so as such it should not cause
> any issue in driver as of now, only we have some redundant entry in
> exynos-srom.h which can be removed if it's not applicable for any of
> Exynos SoC, after confirmation from Kukjin.

I was not referring to SROM_BC[45] but to SROM_BC3 which has the offset
of 0x10.

Best regards,
Krzysztof
