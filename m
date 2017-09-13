From: hoegeun.kwon@samsung.com (Hoegeun Kwon)
Date: Wed, 13 Sep 2017 18:28:02 +0900
Subject: [PATCH v3 4/6] [media] exynos-gsc: Add hardware rotation limits
In-Reply-To: <a915a1f7-2c01-472b-b9ee-5367c488a89f@samsung.com>
References: <1504850560-27950-1-git-send-email-hoegeun.kwon@samsung.com>
 <CGME20170908060309epcas1p3d48dd0871d3fde02ba3c9921bbe5a7a6@epcas1p3.samsung.com>
 <1504850560-27950-5-git-send-email-hoegeun.kwon@samsung.com>
 <27b46679-e6c7-2471-f10e-3f0634178ebf@samsung.com>
 <bb025fcb-e316-dfe9-a8eb-8a9535f35b93@samsung.com>
 <a915a1f7-2c01-472b-b9ee-5367c488a89f@samsung.com>
Message-ID: <21b6ae5d-a77b-3ab1-bc84-5f30e76fab50@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/13/2017 06:11 PM, Sylwester Nawrocki wrote:
> Hi Hoegeun,
>
> On 09/13/2017 04:33 AM, Hoegeun Kwon wrote:
>>>> @@ -1017,8 +1083,12 @@ static irqreturn_t gsc_irq_handler(int irq,
>>>> void *priv)
>>>>       static const struct of_device_id exynos_gsc_match[] = {
>>>>         {
>>>> -        .compatible = "samsung,exynos5-gsc",
>>>> -        .data = &gsc_v_100_drvdata,
>>> Can you keep the "samsung,exynos5-gsc" entry with the gsc_v_5250_variant
>>> data, so that it can work with "samsung,exynos5-gsc" compatible in DT
>>> on both exynos5250 and exynos5420 SoCs?
>>>
>> Thank you for your question.
>>
>> Exynos 5250 and 5420 have different hardware rotation limits.
>> Exynos 5250 is '.real_rot_en_w/h = 2016' and 5420 is '.real_rot_en_w/h =
>> 2048'.
>>
>> So my opinion they must have different compatible.
> I think there is some misunderstanding, mu suggestion was to keep the
> "samsung,exynos5-gsc" compatible entry in addition to the new introduced
> ones: "samsung,exynos5250-gsc" and "samsung,exynos5420-gsc". That's in
> order to make your changes possibly backward compatible, in theory
> the updated driver should still work without changes in dts.


Thank you again for your explanation.

Yes, I understood.
I will keep "samsung,exynos5-gsc" compatible,
and add Exynos 5250/5420/5433 compatible.

Best regards,
Hoegeun
