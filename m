From: romain.perier@gmail.com (Romain Perier)
Date: Sun, 30 Nov 2014 15:10:13 +0100
Subject: [PATCH v1] ARM: dts: rockchip: Update LEDs to work with the last
 leds-gpio driver on radxarock
In-Reply-To: <CABgxDoLwqYttcPYc+Wth3B17P=e2cbV8G=hqbRfWx+PVTiAPig@mail.gmail.com>
References: <1416759575-774-1-git-send-email-romain.perier@gmail.com>
 <CABgxDoLwqYttcPYc+Wth3B17P=e2cbV8G=hqbRfWx+PVTiAPig@mail.gmail.com>
Message-ID: <CABgxDoLx+5Bc_7TfRLOTrhP26=xQF8dawmEENqmXTUpBep_b4w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ping :)

2014-11-23 17:20 GMT+01:00 Romain Perier <romain.perier@gmail.com>:
> See https://www.kernel.org/doc/Documentation/leds/leds-class.txt for
> LEDs device naming
>
> 2014-11-23 17:19 GMT+01:00 Romain Perier <romain.perier@gmail.com>:
>> The leds-gpio driver recently switched to the device property API. The device_node
>> name is no longer retrieved if the "label" devicetree property is not found.
>> In this case the driver tries to create entries with (null) name in
>> /sys/class/leds, which is wrong and generates backtrace as several gpio_leds have
>> the same name. Also renamed subnode "yellow" to "blue" to match the last
>> schematics updates.
>>
>> Signed-off-by: Romain Perier <romain.perier@gmail.com>
>> ---
>>  arch/arm/boot/dts/rk3188-radxarock.dts | 5 ++++-
>>  1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/arm/boot/dts/rk3188-radxarock.dts b/arch/arm/boot/dts/rk3188-radxarock.dts
>> index 6eb62c0..9a09579 100644
>> --- a/arch/arm/boot/dts/rk3188-radxarock.dts
>> +++ b/arch/arm/boot/dts/rk3188-radxarock.dts
>> @@ -43,16 +43,19 @@
>>                 compatible = "gpio-leds";
>>
>>                 green {
>> +                       label = "rock:green:user1";
>>                         gpios = <&gpio0 12 GPIO_ACTIVE_LOW>;
>>                         default-state = "off";
>>                 };
>>
>> -               yellow {
>> +               blue {
>> +                       label = "rock:blue:user2";
>>                         gpios = <&gpio0 14 GPIO_ACTIVE_LOW>;
>>                         default-state = "off";
>>                 };
>>
>>                 sleep {
>> +                       label = "rock:red:power";
>>                         gpios = <&gpio0 15 0>;
>>                         default-state = "off";
>>                 };
>> --
>> 1.9.1
>>
