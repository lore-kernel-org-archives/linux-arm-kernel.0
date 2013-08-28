From: chander.kashyap@linaro.org (Chander Kashyap)
Date: Wed, 28 Aug 2013 17:36:50 +0530
Subject: [PATCH] ARM: DT: Exynos5250: fix number of interrupt-cells in mct
 node
In-Reply-To: <6294395.8UjbZM2KH4@amdc1227>
References: <1377687641-15376-1-git-send-email-chander.kashyap@linaro.org>
 <6294395.8UjbZM2KH4@amdc1227>
Message-ID: <CANuQgHG03q5mZALdyOaQv3ndD45n4UjmsuoHE7F96WM0ueKw0g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 28 August 2013 16:48, Tomasz Figa <t.figa@samsung.com> wrote:
> Hi Chander,
>
> On Wednesday 28 of August 2013 16:30:41 Chander Kashyap wrote:
>> Two cells were used to specify interrupts in mct node, while second cell
>> always remains unused. Hence use only one cell.
>> Suggested by Tomasz Figa.
>>
>> Signed-off-by: Chander Kashyap <chander.kashyap@linaro.org>
>> ---
>> changes in v2:
>>       - Drop Changes for Exynos4 as done in separate patch by Tomasz
>>
>>  arch/arm/boot/dts/exynos5250.dtsi |   19 +++++++++----------
>>  1 file changed, 9 insertions(+), 10 deletions(-)
>>
>> diff --git a/arch/arm/boot/dts/exynos5250.dtsi
>> b/arch/arm/boot/dts/exynos5250.dtsi index ef57277..f2f178a 100644
>> --- a/arch/arm/boot/dts/exynos5250.dtsi
>> +++ b/arch/arm/boot/dts/exynos5250.dtsi
>> @@ -102,23 +102,22 @@
>>               compatible = "samsung,exynos4210-mct";
>>               reg = <0x101C0000 0x800>;
>>               interrupt-controller;
>> -             #interrups-cells = <2>;
>> +             #interrups-cells = <1>;
>
> Those two properties above are unused and in fact incorrect, because MCT is
> not an interrupt controller, so they could be removed in a follow-up patch.

Thanks for the correction. I will remove them.

>
> You can also check out the clean-up series I mentioned for other things
> that could be cleaned up in Exynos 5 dtsi files.

ok

>
>>               interrupt-parent = <&mct_map>;
>> -             interrupts = <0 0>, <1 0>, <2 0>, <3 0>,
>> -                          <4 0>, <5 0>;
>> +             interrupts = <0>, <1>, <2>, <3>, <4>, <5>;
>>               clocks = <&clock 1>, <&clock 335>;
>>               clock-names = "fin_pll", "mct";
>>
>>               mct_map: mct-map {
>> -                     #interrupt-cells = <2>;
>> +                     #interrupt-cells = <1>;
>>                       #address-cells = <0>;
>>                       #size-cells = <0>;
>> -                     interrupt-map = <0x0 0 &combiner 23 3>,
>> -                                     <0x1 0 &combiner 23 4>,
>> -                                     <0x2 0 &combiner 25 2>,
>> -                                     <0x3 0 &combiner 25 3>,
>> -                                     <0x4 0 &gic 0 120 0>,
>> -                                     <0x5 0 &gic 0 121 0>;
>> +                     interrupt-map = <0 &combiner 23 3>,
>> +                                     <1 &combiner 23 4>,
>> +                                     <2 &combiner 25 2>,
>> +                                     <3 &combiner 25 3>,
>> +                                     <4 &gic 0 120 0>,
>> +                                     <5 &gic 0 121 0>;
>>               };
>>       };
>
> Otherwise, looks fine. Thanks.

Thanks

>
> Best regards,
> Tomasz
>



-- 
with warm regards,
Chander Kashyap
