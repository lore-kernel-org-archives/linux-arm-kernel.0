From: cedric.madianga@gmail.com (M'boumba Cedric Madianga)
Date: Fri, 3 Jun 2016 09:57:11 +0200
Subject: [PATCH v2 3/5] ARM: dts: Add I2C1 support for STM32F429 SoC
In-Reply-To: <CALszF6D4K1GsFdb0z3Lkb=EJdhzNnZNnAxeyCZGq36+Cnwf+_A@mail.gmail.com>
References: <1464877568-21897-1-git-send-email-cedric.madianga@gmail.com>
 <1464877568-21897-4-git-send-email-cedric.madianga@gmail.com>
 <CALszF6D4K1GsFdb0z3Lkb=EJdhzNnZNnAxeyCZGq36+Cnwf+_A@mail.gmail.com>
Message-ID: <CAOAejn13uZq320pGgYY7PENC1VK+Og22S_yRYkcVAP6O87fTrw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2016-06-02 18:07 GMT+02:00 Maxime Coquelin <mcoquelin.stm32@gmail.com>:
> 2016-06-02 16:26 GMT+02:00 M'boumba Cedric Madianga <cedric.madianga@gmail.com>:
>> Signed-off-by: Patrice Chotard <patrice.chotard@st.com>
>> Signed-off-by: M'boumba Cedric Madianga <cedric.madianga@gmail.com>
>> ---
>>  arch/arm/boot/dts/stm32f429.dtsi | 24 ++++++++++++++++++++++++
>>  1 file changed, 24 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/stm32f429.dtsi b/arch/arm/boot/dts/stm32f429.dtsi
>> index 434d4b9..d5857eb 100644
>> --- a/arch/arm/boot/dts/stm32f429.dtsi
>> +++ b/arch/arm/boot/dts/stm32f429.dtsi
>> @@ -323,6 +323,18 @@
>>                                         slew-rate = <2>;
>>                                 };
>>                         };
>> +
>> +                       i2c1_sda_pin: i2c1_sda at 0 {
>> +                               pins {
>> +                                       pinmux = <STM32F429_PB9_FUNC_I2C1_SDA>;
>> +                                       drive-open-drain;
>> +                               };
>> +                       };
>> +                       i2c1_scl_pin: i2c1_scl at 0 {
>> +                               pins {
>> +                                       pinmux = <STM32F429_PB6_FUNC_I2C1_SCL>;
>> +                               };
>> +                       };
>>                 };
> Shouldn't be preferrable to group the two functions in a single one,
I agree. It is better.
>
>             usart1_pins_a: usart1 at 0 {
>                 pins1 {
>                     pinmux = <STM32F429_PA9_FUNC_USART1_TX>;
>                     bias-disable;
>                     drive-push-pull;
>                     slew-rate = <0>;
>                 };
>                 pins2 {
>                     pinmux = <STM32F429_PA10_FUNC_USART1_RX>;
>                     bias-disable;
>                 };
>             };
>
> Also, I would prefer the phandle to be suffixed with the port number,
> as multiple muxing options are available, for example "i2c1_pins_b".
Ok understood. I will fix that in the V3.
Thanks
>
> Thanks,
> Maxime
