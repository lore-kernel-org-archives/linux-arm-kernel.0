From: cwchoi00@gmail.com (Chanwoo Choi)
Date: Sat, 19 Jul 2014 00:15:35 +0900
Subject: [PATCHv6 2/4] iio: adc: exynos_adc: Control special clock of ADC
 to support Exynos3250 ADC
In-Reply-To: <6917971.QKItNU3coA@wuerfel>
References: <1405663186-26464-1-git-send-email-cw00.choi@samsung.com>
 <6485839.CnzmD0SeQj@wuerfel> <53C8F050.6060104@samsung.com>
 <6917971.QKItNU3coA@wuerfel>
Message-ID: <CAGTfZH1EHiTpo2Abua=+kDfNoOQx+ydPHU51=+qW8mgCL4Lwvg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 18, 2014 at 8:14 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Friday 18 July 2014 19:00:48 Chanwoo Choi wrote:
>> On 07/18/2014 06:47 PM, Arnd Bergmann wrote:
>> >
>> > Further, why is it called "sclk_adc" rather than just "sclk"?
>>
>> The sclk means 'special clock' in Exynos TRM. Exynos SoC has varisou sclk clocks.
>> 'sclk_adc' is only used for ADC IP.
>
> But that sounds like sclk_adc is the name of the global name
> of the clock signal coming out of the clock controller.
>
> I still think it would be best to name it 'sclk' as the input
> for the adc. It shouldn't rely on a particular name of the
> clock controller.

I think 'sclk' is too common name. 'sclk' don't include specific device name.
As I know, usual clock name includes the name of IP or includes the
specific meaning for each IP.

In my opinion, I think sclk_adc is better than 'sclk'.

Thanks,
Chanwoo Choi
