From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Fri, 30 Jun 2017 12:47:09 +0200
Subject: [PATCH 1/2] ARM: dts: r8a7792: add IMR-L[S]X3 clocks
In-Reply-To: <20170630100114.GG26710@verge.net.au>
References: <20170321194820.477663240@cogentembedded.com>
 <20170630100114.GG26710@verge.net.au>
Message-ID: <CAMuHMdVt8q3k00QPisEMu0L6ed_9JPnZUe8JYvaEo-hphQ+NrA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 30, 2017 at 12:01 PM, Simon Horman <horms@verge.net.au> wrote:
> On Thu, Jan 01, 1970 at 03:00:01AM +0300, Sergei Shtylyov wrote:
>> Add the IMR-L[S]X3 clocks to the R8A7792 device tree.
>>
>> Based on the original patch by Roman Meshkevich
>> <roman.meshkevich@cogentembedded.com>.
>>
>> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
>>
>> ---
>>  arch/arm/boot/dts/r8a7792.dtsi            |   15 ++++++++++++---
>>  include/dt-bindings/clock/r8a7792-clock.h |    7 +++++++
>>  2 files changed, 19 insertions(+), 3 deletions(-)
>>
>> Index: renesas/arch/arm/boot/dts/r8a7792.dtsi
>> ===================================================================
>> --- renesas.orig/arch/arm/boot/dts/r8a7792.dtsi
>> +++ renesas/arch/arm/boot/dts/r8a7792.dtsi
>> @@ -927,16 +927,25 @@
>>                                    "renesas,cpg-mstp-clocks";
>>                       reg = <0 0xe6150990 0 4>, <0 0xe61509a0 0 4>;
>>                       clocks = <&zg_clk>, <&zg_clk>, <&zg_clk>, <&zg_clk>,
>> -                              <&zg_clk>, <&zg_clk>, <&hp_clk>;
>> +                              <&zg_clk>, <&zg_clk>, <&hp_clk>, <&zg_clk>,
>> +                              <&zg_clk>, <&zg_clk>, <&zg_clk>, <&zg_clk>,
>> +                              <&zg_clk>, <&zg_clk>;
>>                       #clock-cells = <1>;
>>                       clock-indices = <
>>                               R8A7792_CLK_VIN5 R8A7792_CLK_VIN4
>>                               R8A7792_CLK_VIN3 R8A7792_CLK_VIN2
>>                               R8A7792_CLK_VIN1 R8A7792_CLK_VIN0
>> -                             R8A7792_CLK_ETHERAVB
>> +                             R8A7792_CLK_ETHERAVB R8A7792_CLK_IMR_LX3
>> +                             R8A7792_CLK_IMR_LSX3_1 R8A7792_CLK_IMR_LSX3_0
>> +                             R8A7792_CLK_IMR_LSX3_5 R8A7792_CLK_IMR_LSX3_4
>> +                             R8A7792_CLK_IMR_LSX3_3 R8A7792_CLK_IMR_LSX3_2
>>                       >;
>>                       clock-output-names = "vin5", "vin4", "vin3", "vin2",
>> -                                          "vin1", "vin0", "etheravb";
>> +                                          "vin1", "vin0",
>> +                                          "etheravb", "imr-lx3",
>> +                                          "imr-lsx3-1", "imr-lsx3-0",
>> +                                          "imr-lsx3-5", "imr-lsx3-4",
>> +                                          "imr-lsx3-3", "imr-lsx3-2";
>>               };
>>               mstp9_clks: mstp9_clks at e6150994 {
>>                       compatible = "renesas,r8a7792-mstp-clocks",
>> Index: renesas/include/dt-bindings/clock/r8a7792-clock.h
>> ===================================================================
>> --- renesas.orig/include/dt-bindings/clock/r8a7792-clock.h
>> +++ renesas/include/dt-bindings/clock/r8a7792-clock.h
>> @@ -70,6 +70,13 @@
>>  #define R8A7792_CLK_VIN1             10
>>  #define R8A7792_CLK_VIN0             11
>>  #define R8A7792_CLK_ETHERAVB         12
>> +#define R8A7792_CLK_IMR_LX3          21
>> +#define R8A7792_CLK_IMR_LSX3_1               22
>> +#define R8A7792_CLK_IMR_LSX3_0               23
>> +#define R8A7792_CLK_IMR_LSX3_5               25
>> +#define R8A7792_CLK_IMR_LSX3_4               26
>> +#define R8A7792_CLK_IMR_LSX3_3               27
>> +#define R8A7792_CLK_IMR_LSX3_2               28
>>
>>  /* MSTP9 */
>>  #define R8A7792_CLK_GPIO7            4
>>
>
> I think this patch needs to be split in two, one for each file,
> to allow queuing bindings and DT changes in different branches.

I don't know if it's worth still adding this.
About 47 years after the original patch date, my plan is to convert r8a7792.dtsi
to the new CPG/MSSR bindings, cfr. latest renesas-drivers.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
