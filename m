From: marcel@ziswiler.com (Marcel Ziswiler)
Date: Mon, 23 Jul 2018 06:34:31 +0200
Subject: [PATCH] ARM: dts: spear: fix stmpe811 interrupt properties
In-Reply-To: <20180723025747.ykxeqogyfn6wskvo@vireshk-i7>
References: <20180720075356.26156-1-marcel@ziswiler.com>
 <20180723025747.ykxeqogyfn6wskvo@vireshk-i7>
Message-ID: <883F78E9-45F8-4AA7-9702-330027ADD741@ziswiler.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On July 23, 2018 4:57:47 AM GMT+02:00, Viresh Kumar <viresh.kumar@linaro.org> wrote:
>On 20-07-18, 09:53, Marcel Ziswiler wrote:
>> From: Marcel Ziswiler <marcel.ziswiler@toradex.com>
>> 
>> The property "irq-over-gpio" simply does not exist (this is nowadays
>> actually auto detected) and the property "irq-gpios" is actually
>called
>> "irq-gpios".
>
>  "irq-gpio" ?

Yes, of course. Too many s' (;-p).

>> Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
>> 
>> ---
>> 
>>  arch/arm/boot/dts/spear320-hmi.dts | 3 +--
>>  1 file changed, 1 insertion(+), 2 deletions(-)
>> 
>> diff --git a/arch/arm/boot/dts/spear320-hmi.dts
>b/arch/arm/boot/dts/spear320-hmi.dts
>> index 0d0da1f65f0e..d2d1fe944407 100644
>> --- a/arch/arm/boot/dts/spear320-hmi.dts
>> +++ b/arch/arm/boot/dts/spear320-hmi.dts
>> @@ -241,8 +241,7 @@
>>  					#address-cells = <1>;
>>  					#size-cells = <0>;
>>  					reg = <0x41>;
>> -					irq-over-gpio;
>> -					irq-gpios = <&gpiopinctrl 29 0x4>;
>> +					irq-gpio = <&gpiopinctrl 29 0x4>;
>>  					id = <0>;
>>  					blocks = <0x5>;
>>  					irq-trigger = <0x1>;
