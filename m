From: cwchoi00@gmail.com (Chanwoo Choi)
Date: Sat, 19 Jul 2014 01:48:18 +0900
Subject: [PATCHv6 2/4] iio: adc: exynos_adc: Control special clock of ADC
 to support Exynos3250 ADC
In-Reply-To: <10264770.8SXiIS8qhq@wuerfel>
References: <1405663186-26464-1-git-send-email-cw00.choi@samsung.com>
 <32226622.5gSmvBRKvZ@wuerfel>
 <CAGTfZH3vz9MLN+1fPM22zKE64oMNDgcib3is0nfzZhhLkmdNvw@mail.gmail.com>
 <10264770.8SXiIS8qhq@wuerfel>
Message-ID: <CAGTfZH1jOEj8D6kJSd=-dgpSiU=sxs5W2TM=-rNtsZb-SkRD9Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jul 19, 2014 at 1:31 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Saturday 19 July 2014 01:11:53 Chanwoo Choi wrote:
>>
>>   Exynos3250/Exynos4/Exynos5 has 'adc' clock as following:
>>   - 'adc' clock: bus clock for ADC
>>
>>   Exynos3250 has additional 'sclk_adc' clock as following:
>>   - 'sclk_adc' clock: special clock for ADC which provide clock to internal ADC
>
> The bus clock is often named "apb_pclk", but it's too late to change
> that now, and it's not clear if the device is actually on APB.
>
> The problem with "sclk_adc" is that it's very close to the name used
> in the clock provider, with is CLK_SCLK_TSADC. Please try to avoid
> the ambiguity here and make it clear that they are not referring
> to the same thing. "internal" or "special" might be good if you want
> to avoid "sclk".

OK, thanks for your feedback.
I'll try to find proper name.

Chanwoo Choi
