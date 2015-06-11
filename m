From: javier@dowhile0.org (Javier Martinez Canillas)
Date: Thu, 11 Jun 2015 14:15:38 +0200
Subject: [PATCH 1/2] clk: exynos4: Add PCLK_ADC gate clock on Exynos4x12
In-Reply-To: <55796660.1070702@samsung.com>
References: <1434011190-24563-1-git-send-email-k.kozlowski@samsung.com>
 <55796660.1070702@samsung.com>
Message-ID: <CABxcv=kNb2ERqLL2gG73nkU+kpPsYAWKSyu=bkjfxZBMKOwyPQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Krzysztof,

On Thu, Jun 11, 2015 at 12:43 PM, Krzysztof Kozlowski
<k.kozlowski@samsung.com> wrote:
> W dniu 11.06.2015 o 17:26, Krzysztof Kozlowski pisze:
>> Add proper gate clock for the Analog to Digital Converter (ADC) on
>> Exynos4x12.
>>
>> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
>> ---
>>  drivers/clk/samsung/clk-exynos4.c   | 3 +++
>>  include/dt-bindings/clock/exynos4.h | 5 ++++-
>>  2 files changed, 7 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/clk/samsung/clk-exynos4.c b/drivers/clk/samsung/clk-exynos4.c
>> index 714d6ba782c8..5f32410a01f8 100644
>> --- a/drivers/clk/samsung/clk-exynos4.c
>> +++ b/drivers/clk/samsung/clk-exynos4.c
>> @@ -85,6 +85,7 @@
>>  #define DIV_PERIL4           0xc560
>>  #define DIV_PERIL5           0xc564
>>  #define E4X12_DIV_CAM1               0xc568
>> +#define E4X12_GATE_BUS_FSYS1 0xc744
>>  #define GATE_SCLK_CAM                0xc820
>>  #define GATE_IP_CAM          0xc920
>>  #define GATE_IP_TV           0xc924
>> @@ -1095,6 +1096,8 @@ static struct samsung_gate_clock exynos4x12_gate_clks[] __initdata = {
>>               0),
>>       GATE(CLK_PPMUIMAGE, "ppmuimage", "aclk200", E4X12_GATE_IP_IMAGE, 9, 0,
>>               0),
>> +     GATE(CLK_PCLK_ADC, "pclk_adc", "aclk133", E4X12_GATE_BUS_FSYS1, 16, 0,
>> +             0),
>
> Now I have even simpler idea. Don't add new clock id but just define
> here the CLK_TSADC as:
> GATE(CLK_TSADC, "tsadc", "aclk133", E4X12_GATE_BUS_FSYS1, 16, 0, 0);
>
> With this change the second patch wouldn't be needed however this does
> not reflect the Exynos 4x12 datasheet.
>
> Any comments?
>

I think it's better to reflect the datasheet so I prefer your original
patch. Also, wouldn't changing the CLK_TSADC gate definition cause a
regression on an Exynos4210 board that is using the tsadc clock? or
maybe I misunderstood the explanation of your Patch 2/2?

> Best regards,
> Krzysztof
>

Best regards,
Javier
