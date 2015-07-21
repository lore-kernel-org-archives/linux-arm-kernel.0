From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Wed, 22 Jul 2015 08:41:01 +0900
Subject: [PATCH v2] clk: exynos4: Fix wrong clock for Exynos4x12 ADC
In-Reply-To: <20150721224235.GA30021@codeaurora.org>
References: <1434074005-18846-1-git-send-email-k.kozlowski@samsung.com>
 <20150721224235.GA30021@codeaurora.org>
Message-ID: <55AED88D.2060009@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 22.07.2015 07:42, Stephen Boyd wrote:
> On 06/12, Krzysztof Kozlowski wrote:
>> The TSADC gate clock was used in Exynos4x12 DTSI for exynos-adc driver.
>> However TSADC is present only on Exynos4210 so on Trats2 board (with
>> Exynos4412 SoC) the exynos-adc driver could not be probed:
>>    ERROR: could not get clock /adc at 126C0000:adc(0)
>>    exynos-adc 126c0000.adc: failed getting clock, err = -2
>>    exynos-adc: probe of 126c0000.adc failed with error -2
>>
>> Instead on Exynos4x12 SoCs the main clock used by Analog to Digital
>> Converter is located in different register and it is named in datasheet
>> as PCLK_ADC. Regardless of the name the purpose of this PCLK_ADC clock
>> is the same as purpose of TSADC from Exynos4210.
>>
>> The patch adds gate clock for Exynos4x12 using the proper register so
>> backward compatibility is preserved. This fixes the probe of exynos-adc
>> driver on Exynos4x12 boards and allows accessing sensors connected to it
>> on Trats2 board (ntc,ncp15wb473 AP and battery thermistors).
>>
>> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
>> Cc: <stable@vger.kernel.org>
>> Fixes: c63c57433003 ("ARM: dts: Add ADC's dt data to read raw data for exynos4x12")
>> Link: https://lkml.org/lkml/2015/6/11/85
>>
> 
> Did you want clk maintainers to apply this? The To: list is not
> helping so I'm not sure what's going on and it seems to have
> slipped through the cracks.

Thank you for being proactive! I appreciate this.
Some time ago Sylwester replied that he took care about this patch so I
think this will go through Samsung clock tree.


Sylwester, are you planning to send this as fix for 4.2-rc?

Best regards,
Krzysztof
