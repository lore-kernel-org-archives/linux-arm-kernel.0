From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Wed, 25 Feb 2015 11:27:37 +0100
Subject: [PATCH 2/2] ARM: shmobile: r8a7794: add GPIO DT support
In-Reply-To: <2292882.LbM0mNWfOj@avalon>
References: <6954455.LyoCrfjM8R@wasted.cogentembedded.com>
 <3082195.zNdUtZ8oMM@wasted.cogentembedded.com>
 <2292882.LbM0mNWfOj@avalon>
Message-ID: <CAMuHMdU9QD_4UOBPm850HtUPAOOEY4JA7cztpUyKSGog6VYUNA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Laurent,

On Wed, Feb 25, 2015 at 11:11 AM, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>> --- renesas.orig/arch/arm/boot/dts/r8a7794.dtsi
>> +++ renesas/arch/arm/boot/dts/r8a7794.dtsi
>> @@ -50,6 +50,90 @@

>> +     gpio1: gpio at e6051000 {
>> +             compatible = "renesas,gpio-r8a7794", "renesas,gpio-rcar";
>> +             reg = <0 0xe6051000 0 0x50>;
>> +             interrupts = <0 5 IRQ_TYPE_LEVEL_HIGH>;
>> +             #gpio-cells = <2>;
>> +             gpio-controller;
>> +             gpio-ranges = <&pfc 0 32 32>;
>
> This GPIO block has 26 GPIOs only.

>> +     gpio5: gpio at e6055000 {
>> +             compatible = "renesas,gpio-r8a7794", "renesas,gpio-rcar";
>> +             reg = <0 0xe6055000 0 0x50>;
>> +             interrupts = <0 9 IRQ_TYPE_LEVEL_HIGH>;
>> +             #gpio-cells = <2>;
>> +             gpio-controller;
>> +             gpio-ranges = <&pfc 0 160 32>;
>
> This GPIO block has 28 GPIOs only.

>> +     gpio6: gpio at e6055400 {
>> +             compatible = "renesas,gpio-r8a7794", "renesas,gpio-rcar";
>> +             reg = <0 0xe6055400 0 0x50>;
>> +             interrupts = <0 10 IRQ_TYPE_LEVEL_HIGH>;
>> +             #gpio-cells = <2>;
>> +             gpio-controller;
>> +             gpio-ranges = <&pfc 0 192 32>;
>
> This GPIO block has 26 GPIOs only.

I guess you hear me coming... r8a779[01].dtsi need to be fixed, too.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
