From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Mon, 18 Apr 2016 14:04:39 +0200
Subject: [PATCH] ARM: dts: imx: ventana: add RS485 txen gpio support
In-Reply-To: <CAJ+vNU3-Ht7mVUn+T6n1YmYMwxzAW7X-ryccCZw0U_uNiGv2=A@mail.gmail.com>
References: <1460639949-26392-1-git-send-email-tharvey@gateworks.com>
 <20160414133237.GE2092@tarshish>
 <CAJ+vNU3-Ht7mVUn+T6n1YmYMwxzAW7X-ryccCZw0U_uNiGv2=A@mail.gmail.com>
Message-ID: <CAMuHMdWA1Q-UvLyBBaVEqF-x3okzqCnKPcb95Q66sKvKOtbe3g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 14, 2016 at 4:39 PM, Tim Harvey <tharvey@gateworks.com> wrote:
> On Thu, Apr 14, 2016 at 6:32 AM, Baruch Siach <baruch@tkos.co.il> wrote:
>> On Thu, Apr 14, 2016 at 06:19:09AM -0700, Tim Harvey wrote:
>>> diff --git a/arch/arm/boot/dts/imx6qdl-gw52xx.dtsi b/arch/arm/boot/dts/imx6qdl-gw52xx.dtsi
>>> index 8cccc4a..50d6039 100644
>>> --- a/arch/arm/boot/dts/imx6qdl-gw52xx.dtsi
>>> +++ b/arch/arm/boot/dts/imx6qdl-gw52xx.dtsi
>>> @@ -315,6 +315,8 @@
>>>  &uart1 {
>>>       pinctrl-names = "default";
>>>       pinctrl-0 = <&pinctrl_uart1>;
>>> +     fsl,uart-has-rtscts;
>>> +     rts-gpio = <&gpio7 1 GPIO_ACTIVE_LOW>;
>>
>> See http://marc.info/?l=linux-serial&m=146063601520851&w=2.
>
> Thanks - I didn't see this one yet. I will change the prop and re-submit.

I think it's a bit early to change the property, before the code handling
the changes has been accepted.

> I'm also not sure if there is a desire to define the prop as
> 'rts-gpios' or 'rts-gpio' - both are picked up and there are many dts
> props that use -gpios for a single gpio and I didn't see any
> devicetree binding documentation for SERIAL_MCTRL_GPIO.

Both are picked up by the core GPIO helpers for backwards compatibility.

Quoting Documentation/devicetree/bindings/gpio/gpio.txt:
| GPIO properties should be named "[<name>-]gpios", [...]
| Also, GPIO properties named "[<name>-]gpio" are valid and old bindings use it,
| but are only supported for compatibility reasons and should not be used for
| newer bindings since it has been deprecated.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
