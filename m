From: eddie.cai.linux@gmail.com (Eddie Cai)
Date: Fri, 20 Jan 2017 15:10:47 +0800
Subject: [PATCH 2/2] ARM: dts: rockchip: add dts for RK3288-Tinker board
In-Reply-To: <40159140.kOHBSj8v8b@phil>
References: <1484791919-4665-1-git-send-email-eddie.cai@rock-chips.com>
 <1484791919-4665-3-git-send-email-eddie.cai@rock-chips.com>
 <40159140.kOHBSj8v8b@phil>
Message-ID: <CAJrj+DM5hVsmB_q+P8WPd0z_F1cYcGafyYZHXdX6P=nrqxpFyA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2017-01-19 17:58 GMT+08:00 Heiko Stuebner <heiko@sntech.de>:
> Hi Eddie,
>
> Am Donnerstag, 19. Januar 2017, 10:11:59 CET schrieb Eddie Cai:
>> This patch add basic support for RK3288-Tinker board. We can boot in to
>> rootfs with this patch.
>>
>> Signed-off-by: Eddie Cai <eddie.cai@rock-chips.com>
>
> looks good in general, just some small question down below.
>
> [...]
>
>> +     /*
>> +      * NOTE: vcc_sd isn't hooked up on v1.0 boards where power comes from
>> +      * vcc_io directly.  Those boards won't be able to power cycle SD cards
>> +      * but it shouldn't hurt to toggle this pin there anyway.
>> +      */
>
> just to clarify, later board will have that pin connected, right?
Copy from rk3288-evb.dtsi. forgot to delete it. I will remove it in next version
>
>> +     vcc_sd: sdmmc-regulator {
>> +             compatible = "regulator-fixed";
>> +             gpio = <&gpio7 11 GPIO_ACTIVE_LOW>;
>> +             pinctrl-names = "default";
>> +             pinctrl-0 = <&sdmmc_pwr>;
>> +             regulator-name = "vcc_sd";
>> +             regulator-min-microvolt = <3300000>;
>> +             regulator-max-microvolt = <3300000>;
>> +             startup-delay-us = <100000>;
>> +             vin-supply = <&vcc_io>;
>> +     };
>> +};
>
> [...]
>
>> +&hdmi {
>> +     #address-cells = <1>;
>> +     #size-cells = <0>;
>> +     #sound-dai-cells = <0>;
>> +     ddc-i2c-bus = <&i2c5>;
>> +     status = "okay";
>> +     /* Don't use vopl for HDMI */
>> +     ports {
>> +             hdmi_in: port {
>> +                     /delete-node/ endpoint at 1;
>> +             };
>
> what is the reason for this? You enable both VOPs below and the linux display
> subsystem should be able to select an appropriate VOP for output just fine on
> its own. So there should be no reason for capping the hdmi's connection to one
> of the vops.
The VOP big support 4k display. is designed for HDMI  4K display. VOP
little is for other display(eDP, LVDS, Mipi etc)
>
>> +     };
>> +};
>
> [...]
>
>> +&usb_host0_ehci {
>> +     no-relinquish-port;
>
> This seems like an unused/undocumented property
I will remove it in next version
>
>> +     status = "okay";
>> +};
>
> [...]
>
>> +&vopl {
>> +     status = "okay";
>> +     /* Don't use vopl for HDMI */
>> +     vopl_out: port {
>> +             /delete-node/ endpoint at 0;
>> +     };
>
> see comment at the hdmi node
>
>> +};
>
>
> Thanks
> Heiko
