From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Tue, 17 Jan 2017 15:08:21 +0100
Subject: [PATCH 3/4] arm64: dts: r8a7795: Link ARM GIC to clock and clock
 domain
In-Reply-To: <HK2PR06MB05451777E7151CA9C7EF8990C37C0@HK2PR06MB0545.apcprd06.prod.outlook.com>
References: <1484657360-13101-1-git-send-email-geert+renesas@glider.be>
 <1484657360-13101-4-git-send-email-geert+renesas@glider.be>
 <HK2PR06MB05451777E7151CA9C7EF8990C37C0@HK2PR06MB0545.apcprd06.prod.outlook.com>
Message-ID: <CAMuHMdUjtwv=iVcfNsA4uB_OdUZQgp8XyonWVgbqsPjqwAtwtQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ramesh,

On Tue, Jan 17, 2017 at 3:00 PM, Ramesh Shanmugasundaram
<ramesh.shanmugasundaram@bp.renesas.com> wrote:
>> --- a/arch/arm64/boot/dts/renesas/r8a7795.dtsi
>> +++ b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
>> @@ -166,6 +166,9 @@
>>                             <0x0 0xf1060000 0 0x20000>;
>>                       interrupts = <GIC_PPI 9
>>                                       (GIC_CPU_MASK_SIMPLE(4) |
>> IRQ_TYPE_LEVEL_HIGH)>;
>> +                     clocks = <&cpg CPG_MOD 408>;
>> +                     clock-names = "clk";
>
> Should the module clock be named "fck"?

Not according to
Documentation/devicetree/bindings/interrupt-controller/arm,gic.txt.

P.S. If you use "git blame", you may think I'm cheating, but naming was
     ased on the actual Technical Reference Manuals ;-)

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
