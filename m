From: icenowy@aosc.xyz (Icenowy Zheng)
Date: Wed, 27 Jul 2016 10:38:10 +0800
Subject: [PATCH v4] ARM: dts: sun8i: Add dts file for Olimex A33-OLinuXino
In-Reply-To: <20160726153352.GH7190@lukather>
References: <1469450243-19138-1-git-send-email-stefan.mavrodiev@gmail.com>
 <20160726153352.GH7190@lukather>
Message-ID: <5601469587090@web14m.yandex.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



26.07.2016, 23:38, "Maxime Ripard" <maxime.ripard@free-electrons.com>:
> Hi Stefan,
>
> On Mon, Jul 25, 2016 at 03:37:23PM +0300, Stefan Mavrodiev wrote:
>> ?A33-OLinuXino is A33 development board designed by Olimex LTD.
>>
>> ?It has AXP233 PMU, 1GB DRAM, a micro SD card, one USB-OTG connector,
>> ?headphone and mic jacks, connector for LiPo battery and optional
>> ?4GB NAND Flash.
>>
>> ?It has two 40-pin headers. One for LCD panel, and one for
>> ?additional modules. Also there is CSI/DSI connector.
>>
>> ?Signed-off-by: Stefan Mavrodiev <stefan.mavrodiev@gmail.com>
>
> It looks mostly good, a few comments though.
>> ?+&pio {
>> ?+ led_pin_olinuxino: led_pins at 0 {
>> ?+ allwinner,pins = "PB7";
>> ?+ allwinner,function = "gpio_out";
>
> This line is not properly indented.
>
>> ?+ allwinner,drive = <SUN4I_PINCTRL_10_MA>;
>> ?+ allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
>> ?+ };
>
> And this one too.
>
>> ?+&reg_dc1sw {
>> ?+ regulator-name = "vcc-lcd";
>> ?+};
>
> No constraints on this one?
The "regulator" dc1sw is, in fact, a switch (so it's named as "sw").
So it have only on-off status.

The constraints in dc1sw has prevented one of my A31s tablet from booting
when it's not removed.
>
>> ?+&reg_dcdc1 {
>> ?+ regulator-always-on;
>> ?+ regulator-min-microvolt = <3300000>;
>> ?+ regulator-max-microvolt = <3300000>;
>> ?+ regulator-name = "vcc-dsi";
>> ?+};
>
> What is it used for? Is it really necessary to keep it on at all time?
>
> Thanks,
> Maxime
>
> --
> Maxime Ripard, Free Electrons
> Embedded Linux and Kernel engineering
> http://free-electrons.com
> ,
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
