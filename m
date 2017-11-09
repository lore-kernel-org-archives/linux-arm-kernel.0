From: xuyiping@hisilicon.com (YiPing Xu)
Date: Thu, 9 Nov 2017 16:17:15 +0800
Subject: [PATCH] arm64: dts: hi3660: improve pmu description
In-Reply-To: <CAL_JsqKFMSvRCB48X4eiPpi5nAL4WGGVGh8GRJpp_JMNdALjbw@mail.gmail.com>
References: <1510131578-84235-1-git-send-email-xuyiping@hisilicon.com>
 <CAL_JsqKFMSvRCB48X4eiPpi5nAL4WGGVGh8GRJpp_JMNdALjbw@mail.gmail.com>
Message-ID: <6b698589-3847-020e-563d-b7807ddb50d4@hisilicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 2017/11/8 23:55, Rob Herring wrote:
> On Wed, Nov 8, 2017 at 2:59 AM, Xu YiPing <xuyiping@hisilicon.com> wrote:
>> cortex a73 pmu is supported, use it instead of armpmu-v3
>
> The subject is misleading and you need a better commit message. Why is
> this change needed? You are going from 1 to 2 devices.
>
> Missing your S-o-B, too.
>
>> ---
>>  arch/arm64/boot/dts/hisilicon/hi3660.dtsi | 22 +++++++++++++---------
>>  1 file changed, 13 insertions(+), 9 deletions(-)
>>
>> diff --git a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
>> index 13ae69f..f638897 100644
>> --- a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
>> +++ b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
>> @@ -203,21 +203,25 @@
>>                                          IRQ_TYPE_LEVEL_HIGH)>;
>>         };
>>
>> -       pmu {
>> -               compatible = "arm,armv8-pmuv3";
>> +       pmu_a53 {
>
> Don't use '_' in node names. Building with W=2 will tell you this.

OK, i'll modify it
>
>> +               compatible = "arm,cortex-a53-pmu";
>>                 interrupts = <GIC_SPI 24 IRQ_TYPE_LEVEL_HIGH>,
>>                              <GIC_SPI 25 IRQ_TYPE_LEVEL_HIGH>,
>>                              <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>,
>> -                            <GIC_SPI 27 IRQ_TYPE_LEVEL_HIGH>,
>> -                            <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>,
>> -                            <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>,
>> -                            <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>,
>> -                            <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>;
>> +                            <GIC_SPI 27 IRQ_TYPE_LEVEL_HIGH>;
>>                 interrupt-affinity = <&cpu0>,
>>                                      <&cpu1>,
>>                                      <&cpu2>,
>> -                                    <&cpu3>,
>> -                                    <&cpu4>,
>> +                                    <&cpu3>;
>> +       };
>> +
>> +       pmu_a73 {
>> +               compatible = "arm,cortex-a73-pmu";
>> +               interrupts = <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>,
>> +                            <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>,
>> +                            <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>,
>> +                            <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>;
>> +               interrupt-affinity = <&cpu4>,
>>                                      <&cpu5>,
>>                                      <&cpu6>,
>>                                      <&cpu7>;
>> --
>> 2.7.4
>>
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel at lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
> .
>
