From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Wed, 26 Feb 2014 09:13:47 +0100
Subject: [PATCH v3 04/20] ARM: shmobile: r8a7779: Add clocks
In-Reply-To: <1393400016-23433-5-git-send-email-horms+renesas@verge.net.au>
References: <1393400016-23433-1-git-send-email-horms+renesas@verge.net.au>
 <1393400016-23433-5-git-send-email-horms+renesas@verge.net.au>
Message-ID: <CAMuHMdWUWeqhH_OeOOFDhTFAGfa3EtTSfMWEkYUrQNV4OT1DLA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 26, 2014 at 8:33 AM, Simon Horman
<horms+renesas@verge.net.au> wrote:
> +               /* Gate clocks */
> +               mstp0_clks: mstp0_clks {
> +                       compatible = "renesas,r8a7779-mstp-clocks", "renesas,cpg-mstp-clocks";
> +                       reg = <0 0xffc80030 0 4>;
> +                       clocks = <&cpg_clocks R8A7779_CLK_P>, <&cpg_clocks R8A7779_CLK_P>, <&cpg_clocks R8A7779_CLK_P>,
> +                                <&cpg_clocks R8A7779_CLK_P>, <&cpg_clocks R8A7779_CLK_P>, <&cpg_clocks R8A7779_CLK_P>,
> +                                <&cpg_clocks R8A7779_CLK_P>, <&cpg_clocks R8A7779_CLK_P>, <&cpg_clocks R8A7779_CLK_P>,
> +                                <&cpg_clocks R8A7779_CLK_P>, <&cpg_clocks R8A7779_CLK_P>, <&cpg_clocks R8A7779_CLK_P>,
> +                                <&cpg_clocks R8A7779_CLK_P>, <&cpg_clocks R8A7779_CLK_P>, <&cpg_clocks R8A7779_CLK_P>,
> +                                <&cpg_clocks R8A7779_CLK_P>;

Is there any rationale behind the decision to (not) split long lines?
The above are really long.

> +                       #clock-cells = <1>;
> +                       renesas,clock-indices = <
> +                               R8A7779_CLK_HSPI R8A7779_CLK_TMU0 R8A7779_CLK_TMU0
> +                               R8A7779_CLK_TMU0 R8A7779_CLK_SCIF5 R8A7779_CLK_SCIF4
> +                               R8A7779_CLK_SCIF3 R8A7779_CLK_SCIF2 R8A7779_CLK_SCIF1
> +                               R8A7779_CLK_SCIF0 R8A7779_CLK_I2C3 R8A7779_CLK_I2C2
> +                               R8A7779_CLK_I2C1 R8A7779_CLK_I2C0

A bit longer than 80 characters (fine for me, though).

> +                       >;
> +                       clock-output-names =
> +                               "hspi", "tmu00", "tmu01",
> +                               "tmu02", "scif5", "scif4",
> +                               "scif3", "scif2", "scif1",
> +                               "scif0", "i2c3", "i2c2",
> +                               "i2c1", "i2c0";

Much shorter than 80 characters (to match the above?).

> +               };
> +               mstp1_clks: mstp1_clks {
> +                       compatible = "renesas,r8a7779-mstp-clocks", "renesas,cpg-mstp-clocks";
> +                       reg = <0 0xffc80034 0 4>, <0 0xffc80044 0 4>;
> +                       clocks = <&cpg_clocks R8A7779_CLK_P>, <&cpg_clocks R8A7779_CLK_P>,
> +                                <&cpg_clocks R8A7779_CLK_P>, <&cpg_clocks R8A7779_CLK_P>,
> +                                <&cpg_clocks R8A7779_CLK_P>, <&cpg_clocks R8A7779_CLK_P>,
> +                                <&cpg_clocks R8A7779_CLK_P>, <&cpg_clocks R8A7779_CLK_P>,
> +                                <&cpg_clocks R8A7779_CLK_P>, <&cpg_clocks R8A7779_CLK_P>,
> +                                <&cpg_clocks R8A7779_CLK_P>, <&cpg_clocks R8A7779_CLK_P>;
> +                       #clock-cells = <1>;
> +                       renesas,clock-indices = <
> +                               R8A7779_CLK_USB01 R8A7779_CLK_USB01

Fits in 80 characters.

> +                               R8A7779_CLK_USB2 R8A7779_CLK_USB2
> +                               R8A7779_CLK_DU R8A7779_CLK_VIN2
> +                               R8A7779_CLK_VIN1 R8A7779_CLK_VIN0
> +                               R8A7779_CLK_ETHER R8A7779_CLK_SATA
> +                               R8A7779_CLK_PCIE R8A7779_CLK_VIN3
> +                       >;
> +                       clock-output-names =
> +                               "ehci0", "ohci0",
> +                               "ehci1", "ohci1",
> +                               "du", "vin2",
> +                               "vin1", "vin0",
> +                               "ether", "sata",
> +                               "pcie", "vin3";

Reallt short, could be compacted a lot.

> +               };

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
