From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Tue, 10 Oct 2017 11:28:15 +0200
Subject: [PATCH] ARM: dts: r8a779x: add '#reset-cells' in cpg-mssr
In-Reply-To: <CAK8P3a0h0xGb3r=SdmyzNVGu5LmTG6GzvvxEsqmubBWJDFbG3A@mail.gmail.com>
References: <20171010084611.968735-1-arnd@arndb.de>
 <CAK8P3a0h0xGb3r=SdmyzNVGu5LmTG6GzvvxEsqmubBWJDFbG3A@mail.gmail.com>
Message-ID: <CAMuHMdWa+Ehhsd6QsDeNWm8OU6O-uUw3HZsj3b5LxTPE8ybHbA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

On Tue, Oct 10, 2017 at 11:07 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Tue, Oct 10, 2017 at 10:45 AM, Arnd Bergmann <arnd@arndb.de> wrote:
>> With the latest dtc, we get many warnings about the missing
>> '#reset-cells' property in these controllers, e.g.:
>>
>> arch/arm/boot/dts/r8a7790-lager.dtb: Warning (resets_property): Missing property '#reset-cells' in node /clock-controller at e6150000 or bad phandle (referred from /can at e6e80000:resets[0])
>> arch/arm/boot/dts/r8a7792-blanche.dtb: Warning (resets_property): Missing property '#reset-cells' in node /soc/clock-controller at e6150000 or bad phandle (referred from /soc/dma-controller at e6700000:resets[0])
>> arch/arm/boot/dts/r8a7792-wheat.dtb: Warning (resets_property): Missing property '#reset-cells' in node /soc/clock-controller at e6150000 or bad phandle (referred from /soc/ethernet at e6800000:resets[0])
>> arch/arm/boot/dts/r8a7793-gose.dtb: Warning (resets_property): Missing property '#reset-cells' in node /clock-controller at e6150000 or bad phandle (referred from /gpio at e6050000:resets[0])
>> arch/arm/boot/dts/r8a7794-alt.dtb: Warning (resets_property): Missing property '#reset-cells' in node /clock-controller at e6150000 or bad phandle (referred from /i2c at e6500000:resets[0])
>> arch/arm/boot/dts/r8a7794-silk.dtb: Warning (resets_property): Missing property '#reset-cells' in node /clock-controller at e6150000 or bad phandle (referred from /interrupt-controller at e61c0000:resets[0])
>>
>> This adds it for the three r8a779x chips that were lacking it. The
>> binding mandates this as <1>, so this is the value I use.
>>
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>> ---
>>  arch/arm/boot/dts/r8a7790.dtsi | 1 +
>>  arch/arm/boot/dts/r8a7792.dtsi | 1 +
>>  arch/arm/boot/dts/r8a7794.dtsi | 1 +
>
> It seems I missed the same problem in r8a7793. I'll do some more tests to
> see if there is more of the same, and will send an updated patch once
> I'm more confident I have the right version.

Thanks for catching this!

Seems I completely missed adding the #reset-cells for all but r8a7791.dtsi,
despite the commit message saying otherwise.

r8a7793.dtsi is the only extra missing one.

Fixes: 34fbd2b12761d111 ("ARM: dts: r8a7790: Add reset control properties")
Fixes: 6e11a322f1d7505d ("ARM: dts: r8a7792: Add reset control properties")
Fixes: 84fb19e1d201ba86 ("ARM: dts: r8a7793: Add reset control properties")
Fixes: 615beb759ca494a4 ("ARM: dts: r8a7794: Add reset control properties")

Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
