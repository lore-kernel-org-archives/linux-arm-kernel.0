From: cwchoi00@gmail.com (=?UTF-8?B?7LWc7LCs7Jqw?=)
Date: Sat, 12 Apr 2014 07:49:22 +0900
Subject: [PATCH] iio: adc: exynos_adc: Control special clock of ADC to
 support Exynos3250 ADC
In-Reply-To: <5347BE67.1080209@samsung.com>
References: <1397181640-18513-1-git-send-email-cw00.choi@samsung.com>
 <5347BE67.1080209@samsung.com>
Message-ID: <CAGTfZH1t9QEZk5qaDRnGkeMatwtTXFq5SGgR27-4nXhdzKU-Ng@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sylwester,

On Fri, Apr 11, 2014 at 7:05 PM, Sylwester Nawrocki
<s.nawrocki@samsung.com> wrote:
> Hi Chanwoo,
>
> On 11/04/14 04:00, Chanwoo Choi wrote:
>> This patch control special clock for ADC in Exynos series's FSYS block.
>> If special clock of ADC is registerd on clock list of common clk framework,
>> Exynos ADC drvier have to control this clock.
>>
>> Exynos3250/Exynos4/Exynos5 has 'adc' clock as following:
>> - 'adc' clock: bus clock for ADC
>>
>> Exynos3250 has additional 'sclk_tsadc' clock as following:
>> - 'sclk_tsadc' clock: special clock for ADC which provide clock to internal ADC
>>
>> Exynos 4210/4212/4412 and Exynos5250/5420 has not included 'sclk_tsadc' clock
>> in FSYS_BLK. But, Exynos3250 based on Cortex-A7 has only included 'sclk_tsadc'
>> clock in FSYS_BLK.
>
> I think a new compatible should be added for the ADC device for Exynos3250
> and the required clocks should be handled properly, based on compatible
> value. This could be handled, e.g. through some flags in driver's data
> selected based on the compatible property value.

OK, I'll consider new patch using new compatible string according to
your comment.

>
> And the new clocks should be documented in Documentation/devicetree/bindings
> /arm/samsung/exynos-adc.txt.

OK, I'll modify it. Thanks,

Best Regards,
Chanwoo Choi
