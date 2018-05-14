From: hao5781286@gmail.com (Hao Zhang)
Date: Tue, 15 May 2018 00:08:57 +0800
Subject: [linux-sunxi] [PATCH v2 2/4] ARM: dtsi: add pwm node for sun8i.
In-Reply-To: <b8af4f6a-c2df-7382-9a1c-9c1a9ea5f8c4@arm.com>
References: <20180225135134.GA14529@arx-s1>
 <b8af4f6a-c2df-7382-9a1c-9c1a9ea5f8c4@arm.com>
Message-ID: <CAJeuY7876=WEpg9M240ygNv6KW68_+tpP9PxpSQfKHNR7=FO-Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2018-02-28 9:53 GMT+08:00 Andr? Przywara <andre.przywara@arm.com>:
> Hi,
>
> The subject line should mention the R40, there are far too many sun8i SoCs.

Okey.

>
> On 25/02/18 13:51, hao_zhang wrote:
>> This patch adds pwm node for sun8i.
>>
>> Signed-off-by: hao_zhang <hao5781286@gmail.com>
>> ---
>>  arch/arm/boot/dts/sun8i-r40.dtsi | 13 +++++++++++++
>>  1 file changed, 13 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/sun8i-r40.dtsi b/arch/arm/boot/dts/sun8i-r40.dtsi
>> index 173dcc1..99a0261 100644
>> --- a/arch/arm/boot/dts/sun8i-r40.dtsi
>> +++ b/arch/arm/boot/dts/sun8i-r40.dtsi
>> @@ -295,6 +295,11 @@
>>                               bias-pull-up;
>>                       };
>>
>> +                     pwm_ch0_pin: pwm-ch0-pin {
>> +                             pins = "PB2";
>> +                             function = "pwm";
>> +                     };
>> +
>>                       uart0_pb_pins: uart0-pb-pins {
>>                               pins = "PB22", "PB23";
>>                               function = "uart0";
>> @@ -306,6 +311,14 @@
>>                       reg = <0x01c20c90 0x10>;
>>               };
>>
>> +             pwm: pwm at 1c23400 {
>> +                          compatible = "allwinner,sun8i-r40-pwm";
>> +                          reg = <0x01c23400 0x154>;
>
> Following my comments on the binding document:
>                         interrupts = <GIC_SPI 47 IRQ_TYPE_LEVEL_HIGH>;
>
>> +                          clocks = <&osc24M>;
>
> And possibly multiple clocks here (though I fail to find the APB1 clock
> being exposed by our CCU).

It seem CCU dosen't support APB1 clock for R40 PWM...

>
> Cheers,
> Andre.
>
>> +                          #pwm-cells = <3>;
>> +                          status = "disabled";
>> +             };
>> +
>>               uart0: serial at 1c28000 {
>>                       compatible = "snps,dw-apb-uart";
>>                       reg = <0x01c28000 0x400>;
>>
>
