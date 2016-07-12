From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Tue, 12 Jul 2016 10:49:00 +0200
Subject: [PATCH 2/2] soc: samsung: Add support for Exynos7 PMU
In-Reply-To: <CAM4voanpvkQJ5GcKeXoLcpmTMXkh7f8aznQHDS-0O5YeaVpeuw@mail.gmail.com>
References: <1467750507-13853-1-git-send-email-a.kesavan@samsung.com>
 <1467750507-13853-3-git-send-email-a.kesavan@samsung.com>
 <CAJKOXPc=RZEe_zQvnmxXRttppJfGJwyjmkF0XxAnV0YnGxvcyA@mail.gmail.com>
 <CAM4voanpvkQJ5GcKeXoLcpmTMXkh7f8aznQHDS-0O5YeaVpeuw@mail.gmail.com>
Message-ID: <5784AEFC.7040406@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/11/2016 04:44 PM, Abhilash Kesavan wrote:
> Hi Krzysztof,
> 
> [...]
>>> diff --git a/drivers/soc/samsung/exynos-pmu.c b/drivers/soc/samsung/exynos-pmu.c
>>> index 0acdfd8..7cda8fb 100644
>>> --- a/drivers/soc/samsung/exynos-pmu.c
>>> +++ b/drivers/soc/samsung/exynos-pmu.c
>>> @@ -88,6 +88,9 @@ static const struct of_device_id exynos_pmu_of_device_ids[] = {
>>>         }, {
>>>                 .compatible = "samsung,exynos5420-pmu",
>>>                 .data = &exynos5420_pmu_data,
>>> +       }, {
>>> +               .compatible = "samsung,exynos7-pmu",
>>> +               .data = &exynos7_pmu_data,
>>
>> Hi,
>>
>> Thanks for the patch. Few comments:
> 
> Thanks for the review.
>>
>> You set here compatible for Exynos7. However there are at least three
>> publicly known Exynos7 chipsets (7420, 7580, 7870 -
>> https://en.wikipedia.org/wiki/Exynos). My questions are:
>> 1. Are all of these share the same PMU configuration?
>> 2. New different Exynos7 may be released, right?
> 
> Exynos7 is a Quad Core A57 based SoC that pre-dates all the above
> mentioned SoCs. It is the closest to the exynos7420 in terms of the
> IPs present.

Hmm, okay... It is confusing because Samsung Semiconductors calls both
7420 and 5433 as "Exynos 7 Octa":
http://www.samsung.com/semiconductor/minisite/Exynos/w/solution/mobile_ap/7420/
The marketing uses term "Exynos7" for a generation of SoCs.

However if there is really a design called Exynos7 and a board with it
(Espresso), then I don't mind. Let it be Exynos7 but keeping in mind
that this is a specific SoC, not a calls of products.

> The PMU configuration between exynos7 and exynos7420 is
> identical except for the extra A53 configuration required in case of
> the 7420.

That is additional argument in favor of "Exynos7" naming.

> The PMU configuration for 7580 and 7870 differ from that of
> eynos7 and 7420 in terms of  the registers offsets, number of
> registers being configured and some extra configurations. So, while
> sharing of some functions is possible across the SoCs, each SoC should
> ideally have its own PMU file. The posted patch adds PMU support for
> only the exynos7 SoC.

Thanks for explanation.

>>
>> The exynos7 compatible is already spread all over DTS... but probably
>> it is safer to use a specific SoC revision. Unless you are sure that
>> all Exynos7 SoCs will be 100% compatible here and there won't be
>> another exynos7xxx-pmu.
> Please let me know if I can continue to use the exynos7 compatible
> since it is a distinct SoC and not indicative of a series. However, if
> you feel strongly about it then I can change the compatible to use
> 7420 since they are quite similar.

Exynos7 is fine. Thanks for the details!

Best regards,
Krzysztof
