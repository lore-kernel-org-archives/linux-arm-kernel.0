From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Mon, 6 Jul 2015 10:08:48 +0900
Subject: [PATCH] ARM: dts: Add CPU cooling binding for Exynos3250-based
 Rinato/Monk board
In-Reply-To: <5594E57C.2010300@samsung.com>
References: <1435815465-501-1-git-send-email-cw00.choi@samsung.com>
 <5594D22C.4040206@samsung.com> <5594D5F4.3060508@samsung.com>
 <5594E57C.2010300@samsung.com>
Message-ID: <CAJKOXPfknRZ0ewSv=awo1ay4uWHAXM_kCiLPN4MpxN2-bSNq0g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2015-07-02 16:17 GMT+09:00 Krzysztof Kozlowski <k.kozlowski@samsung.com>:
> On 02.07.2015 15:11, Chanwoo Choi wrote:
>> On 07/02/2015 02:54 PM, Krzysztof Kozlowski wrote:
>>> On 02.07.2015 14:37, Chanwoo Choi wrote:
>>>> This patch add the cooling device to control the overheating issue on
>>>> Exynos3250-based Rinato/Monk board.
>>>>
>>>> Cc: Kukjin Kim <kgene@kernel.org>
>>>> Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>
>>>> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
>>>> Acked-by: Kyungmin Park <kyungmin.park@samsung.com>
>>>> ---
>>>> Depends on:
>>>> This patch needs the cpufreq support of Exynos3250 SoC. So, this patch has the
>>>> dependency on patch[1] which support the generic cpufreq for Exynos3250 SoC.
>>>> [1] https://lkml.org/lkml/2015/7/1/696
>>>>     : [PATCH v6 0/3] cpufreq: Use cpufreq-dt driver for Exynos3250
>>>>
>>>>  arch/arm/boot/dts/exynos3250-monk.dts   | 15 +++++++++++++++
>>>>  arch/arm/boot/dts/exynos3250-rinato.dts | 15 +++++++++++++++
>>>>  arch/arm/boot/dts/exynos3250.dtsi       |  1 +
>>>>  3 files changed, 31 insertions(+)
>>>>
>>>> diff --git a/arch/arm/boot/dts/exynos3250-monk.dts b/arch/arm/boot/dts/exynos3250-monk.dts
>>>> index 7863265d4868..540a0adf2be6 100644
>>>> --- a/arch/arm/boot/dts/exynos3250-monk.dts
>>>> +++ b/arch/arm/boot/dts/exynos3250-monk.dts
>>>> @@ -116,6 +116,21 @@
>>>>             min-microvolt = <1100000>;
>>>>             max-microvolt = <2700000>;
>>>>     };
>>>> +
>>>> +   thermal-zones {
>>>> +           cpu_thermal: cpu-thermal {
>>>> +                   cooling-maps {
>>>> +                           map0 {
>>>> +                                   /* Correspond to 500MHz at freq_table */
>>>> +                                   cooling-device = <&cpu0 5 5>;
>>>> +                           };
>>>> +                           map1 {
>>>> +                                   /* Correspond to 200MHz at freq_table */
>>>> +                                   cooling-device = <&cpu0 8 8>;
>>>> +                           };
>>>> +                   };
>>>> +           };
>>>> +   };
>>>>  };
>>>>
>>>>  &adc {
>>>> diff --git a/arch/arm/boot/dts/exynos3250-rinato.dts b/arch/arm/boot/dts/exynos3250-rinato.dts
>>>> index ddd7ac283045..0e62a6435e07 100644
>>>> --- a/arch/arm/boot/dts/exynos3250-rinato.dts
>>>> +++ b/arch/arm/boot/dts/exynos3250-rinato.dts
>>>> @@ -107,6 +107,21 @@
>>>>             min-microvolt = <1100000>;
>>>>             max-microvolt = <2700000>;
>>>>     };
>>>> +
>>>> +   thermal-zones {
>>>> +           cpu_thermal: cpu-thermal {
>>>> +                   cooling-maps {
>>>> +                           map0 {
>>>> +                                   /* Corresponds to 500MHz */
>>>> +                                   cooling-device = <&cpu0 5 5>;
>>>> +                           };
>>>> +                           map1 {
>>>> +                                   /* Corresponds to 200MHz */
>>>> +                                   cooling-device = <&cpu0 8 8>;
>>>> +                           };
>>>> +                   };
>>>> +           };
>>>> +   };
>>>>  };
>>>>
>>>>  &adc {
>>>> diff --git a/arch/arm/boot/dts/exynos3250.dtsi b/arch/arm/boot/dts/exynos3250.dtsi
>>>> index e0f3b2ed41a3..a4931b660ddb 100644
>>>> --- a/arch/arm/boot/dts/exynos3250.dtsi
>>>> +++ b/arch/arm/boot/dts/exynos3250.dtsi
>>>> @@ -55,6 +55,7 @@
>>>>                     clock-frequency = <1000000000>;
>>>>                     clocks = <&cmu CLK_ARM_CLK>;
>>>>                     clock-names = "cpu";
>>>> +                   #cooling-cells = <2>;
>>>>
>>>
>>> Don't you need also cooling-{min,max}-state properties?
>>
>> Yes, it is well working without cooling-{min,max}-state or cooling-{min,max}-level.
>>
>> I look for the some code to parse "cooling-{min,max}-state or cooling-{min,max}-level"
>> in drivers/thermal/*. But, there are no any code to parse it.
>>
>> But, Documentation/devicetree/bindings/thermal/thermal.txt contains just the 'cooling-{min,max}-state.
>>
>> I think that there are mismatch between document and thermal core driver.
>
> Thanks for explanation, looks good.
> Acked-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
>
> Best regards,
> Krzysztof

Dear Kukjin,

Recent four patchsets (4210 CPU OPP in DTS, cpufreq-dt 5250,
cpufreq-dt 3250, this patch) are actually an one continuous chain.
Dependencies are already in mainline. Are you gonna to pick up
everything?

Best regards,
Krzysztof
