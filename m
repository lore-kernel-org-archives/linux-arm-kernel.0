From: florian.vaussard@epfl.ch (Florian Vaussard)
Date: Thu, 24 Jan 2013 16:42:27 +0100
Subject: [PATCH 1/2] ARM: dts: omap3-overo: Add support for pwm-leds
In-Reply-To: <5101510C.9050407@ti.com>
References: <1358963812-19947-1-git-send-email-florian.vaussard@epfl.ch>
 <1358963812-19947-2-git-send-email-florian.vaussard@epfl.ch>
 <5101510C.9050407@ti.com>
Message-ID: <51015663.8080109@epfl.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Peter,

>>
>> diff --git a/arch/arm/boot/dts/omap3-overo.dtsi b/arch/arm/boot/dts/omap3-overo.dtsi
>> index 89808ce..800be29 100644
>> --- a/arch/arm/boot/dts/omap3-overo.dtsi
>> +++ b/arch/arm/boot/dts/omap3-overo.dtsi
>> @@ -14,12 +14,13 @@
>>   /include/ "omap3.dtsi"
>>
>>   / {
>> -	leds {
>> -		compatible = "gpio-leds";
>> +	pwmleds {
>> +		compatible = "pwm-leds";
>> +
>>   		overo {
>>   			label = "overo:blue:COM";
>> -			gpios = <&twl_gpio 19 0>;
>> -			linux,default-trigger = "mmc0";
>
> You can keep the default trigger for the pwm-leds as well.
> The best way to test this is on top of linux-next which already have the
> leds-pwm DT bindings.
>

I did it at first, but the led API executes in atomic context, where the 
pwm-twl-led driver uses i2c communication. Setting a trigger will result 
in a kernel panic.

I am working on a patch for pwm-twl-led to defer using a workqueue right 
now.

Cheers,

Florian
