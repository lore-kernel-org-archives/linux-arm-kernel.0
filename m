From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Tue, 8 Mar 2016 09:58:24 +0100
Subject: [PATCH v2] ARM: dts: add "simple-bus" where "arm,amba-bus" is
 used alone
In-Reply-To: <CAL_JsqJvT+4efH-+_EhehzwhHZsrYTX8pa1NLsg_Wn4YReN4Ag@mail.gmail.com>
References: <1457415977-3401-1-git-send-email-yamada.masahiro@socionext.com>
 <CAL_JsqJvT+4efH-+_EhehzwhHZsrYTX8pa1NLsg_Wn4YReN4Ag@mail.gmail.com>
Message-ID: <CAMuHMdWwCdFSN7tAMa7ffjhSFD2DppV4SrzFB0pmshYvA2RYmw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 8, 2016 at 9:49 AM, Rob Herring <robh+dt@kernel.org> wrote:
>> diff --git a/arch/arm/boot/dts/axm55xx.dtsi b/arch/arm/boot/dts/axm55xx.dtsi
>> index ea288f0..8da4582 100644
>> --- a/arch/arm/boot/dts/axm55xx.dtsi
>> +++ b/arch/arm/boot/dts/axm55xx.dtsi
>> @@ -107,7 +107,7 @@
>>                 };
>>
>>                 amba {
>> -                       compatible = "arm,amba-bus";
>> +                       compatible = "arm,amba-bus", "simple-bus";
>
> As I mentioned in the last version, I think you should remove
> arm,amba-bus and just have simple-bus. I don't believe anything relies
> on having arm,amba-bus.

It may have a side-effect: currently "arm.amba-bus" is only treated equivalent
to  "simple-bus" if CONFIG_ARM_AMBA is enabled.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
