From: bgolaszewski@baylibre.com (Bartosz Golaszewski)
Date: Tue, 13 Dec 2016 11:18:45 +0100
Subject: [PATCH v6 4/5] ARM: dts: da850-lcdk: add the vga-bridge node
In-Reply-To: <9d5fa409-bb4f-f62b-2548-0a3b82228e08@ti.com>
References: <1481547942-24775-1-git-send-email-bgolaszewski@baylibre.com>
 <1481547942-24775-5-git-send-email-bgolaszewski@baylibre.com>
 <9d5fa409-bb4f-f62b-2548-0a3b82228e08@ti.com>
Message-ID: <CAMpxmJU2Xn8NZnx7S6Eo0Syh-KVKWVNsJ1zATkwYciXPdDfdTw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2016-12-13 9:46 GMT+01:00 Tomi Valkeinen <tomi.valkeinen@ti.com>:
> Hi,
>
> On 12/12/16 15:05, Bartosz Golaszewski wrote:
>
>> +&lcdc {
>> +     status = "okay";
>> +     pinctrl-names = "default";
>> +     pinctrl-0 = <&lcd_pins>;
>> +
>> +     ports {
>> +             #address-cells = <1>;
>> +             #size-cells = <0>;
>> +
>> +             lcdc_out: port at 1 {
>> +                     #address-cells = <1>;
>> +                     #size-cells = <0>;
>> +                     reg = <1>;
>> +
>> +                     lcdc_out_vga: endpoint {
>> +                             reg = <0>;
>> +                             remote-endpoint = <&vga_bridge_in>;
>> +                     };
>> +             };
>> +     };
>> +};
>>
>
> This is not correct. LCDC has just one output, so port at 1 doesn't make
> sense. It's port at 0. But with just one port, you can leave "ports" away.
> And you don't need the port's label for anything, if I'm not mistaken. So:
>
> &lcdc {
>         status = "okay";
>         pinctrl-names = "default";
>         pinctrl-0 = <&lcd_pins>;
>
>         port {
>                 lcdc_out_vga: endpoint {
>                         remote-endpoint = <&vga_bridge_in>;
>                 };
>         };
> };
>
>  Tomi
>

Right, fixed in v7.

Thanks,
Bartosz
