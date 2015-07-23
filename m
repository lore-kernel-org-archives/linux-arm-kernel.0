From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Thu, 23 Jul 2015 17:18:38 +0900
Subject: [GIT PULL] ARM: EXYNOS: mach: Improvements for 4.3
In-Reply-To: <02f701d0c51f$29219870$7b64c950$@kernel.org>
References: <1437014519-19571-1-git-send-email-k.kozlowski@samsung.com>
 <1437014519-19571-2-git-send-email-k.kozlowski@samsung.com>
 <06bb01d0c372$756f2250$604d66f0$@kernel.org>
 <CAJKOXPeHu7WB7ZJJsjMSPXgiB24ryqufSuPDhFxiXoYDMjLHcg@mail.gmail.com>
 <CAJKOXPeJyoG1sw_Oxznx75WPrk2CcQMxtXrq_MiPHm15E7k+8g@mail.gmail.com>
 <55AED996.9090208@samsung.com> <028b01d0c51d$553710e0$ffa532a0$@kernel.org>
 <02f701d0c51f$29219870$7b64c950$@kernel.org>
Message-ID: <55B0A35E.1000405@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 23.07.2015 17:11, Kukjin Kim wrote:
> Kukjin Kim wrote:
>>
>> Krzysztof Kozlowski wrote:
>>>
>>> On 21.07.2015 14:21, Krzysztof Kozlowski wrote:
>>>> 2015-07-21 14:13 GMT+09:00 Krzysztof Kozlowski <k.kozlowski@samsung.com>:
>>>>> 2015-07-21 14:02 GMT+09:00 Kukjin Kim <kgene@kernel.org>:
>>>>>> Krzysztof Kozlowski wrote:
>>
>> [...]
>>
>>>>>>> --
>>>>>>
>>>>>> Applied above changes into fixes/non-critical, next/cleanup-samsung,
>>>>>> next/dt-samsung and next/cpufreq-clk-samsung according to the change.
>>>>
>>>> Cc-ed Bartlomiej,
>>>>
>>>> One issue found: splitting DTS change for Exynos 5250 cpufreq to
>>>> separate branch will break bisectability. The commit "ARM: dts:
>>>> Exynos5250: add CPU OPP and regulator supply property":
>>>> 1. MUST be put after "clk: samsung: exynos5250: add cpu clock
>>>> configuration data and instantiate cpu clock" to prevent build
>>>> failures,
>>>> 2. should be put before "ARM: Exynos: switch to using generic cpufreq
>>>> driver for Exynos5250" to prevent lost cpufreq functionality.
>>>>
>>>> Doing otherwise would lose bisectability which is really unfortunate
>>>> when you can simply avoid it. This should remain in the same branch -
>>>> next/cpufreq-clk-samsung.
>>>
>>> Dear Kukjin,
>>>
>>> Nothing changed since yesterday... so let me point this in a more clear
>>> way. The way you divided the patchset causes build errors:
>>>
>>> --------------
>>> HEAD is now at 565872a601c4... ARM: dts: add CPU OPP and regulator
>>> supply property for exynos5250
>>>
>>> ERROR: Failed build: -A arm -c exynos on
>>> 565872a601c4d91a75b917b1fb40ff27ad7ebb08
>>>
>>> LOGS:
>>> Error: ../arch/arm/boot/dts/exynos5250.dtsi:65.21-22 syntax error
>>> FATAL ERROR: Unable to parse input tree
>>> make[2]: *** [arch/arm/boot/dts/exynos5250-arndale.dtb] Error 1
>>> make[1]: *** [dtbs] Error 2
>>> make[1]: *** Waiting for unfinished jobs....
>>> make: *** [sub-make] Error 2
>>> --------------
>>>
>>> This breaks bisectability without any special valid reason.
>>>
>> Hi,
>>
>> I couldn't check e-mail yesterday because of annual health check.
>> Anyway, I'll look at the error and handle it soon.
>>
> OK, the change for the include/dt-bindings/clock/exynos5250.h file which is in
> next/cpufreq-clk-samsung branch should be provided in next/dt-samsung branch.
> It should be fine tonight in my time.
> 
> One more thing, the splitting changes into dt and driver side would be required
> generally and if it has dependency like this, proper merge topic branch is
> required by maintainer. But I've missed last action :(

You prepared a topic branch - next/cpufreq-clk-samsung. I think
everything can be put in it and this would solve any issues.

Best regards,
Krzysztof
