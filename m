From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Wed, 18 Dec 2013 09:42:22 +0100
Subject: [PATCH 5/5] i2c: riic: add driver
In-Reply-To: <1387316678-10174-6-git-send-email-wsa@the-dreams.de>
References: <1387316678-10174-1-git-send-email-wsa@the-dreams.de>
 <1387316678-10174-6-git-send-email-wsa@the-dreams.de>
Message-ID: <CAMuHMdV0X6ZUN4YOnCHOGGFTtMWJ5s1D1fOene04KzbMg+nWFQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

CC devicetree at vger.kernel.org for the bindings part.

On Tue, Dec 17, 2013 at 10:44 PM, Wolfram Sang <wsa@the-dreams.de> wrote:
> From: Wolfram Sang <wsa@sang-engineering.com>
>
> Tested with a r7s72100 genmai board acessing an eeprom.
>
> Signed-off-by: Wolfram Sang <wsa@sang-engineering.com>
> ---
>  Documentation/devicetree/bindings/i2c/i2c-riic.txt |  29 ++
>  drivers/i2c/busses/Kconfig                         |  10 +
>  drivers/i2c/busses/Makefile                        |   1 +
>  drivers/i2c/busses/i2c-riic.c                      | 426 +++++++++++++++++++++
>  4 files changed, 466 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/i2c/i2c-riic.txt
>  create mode 100644 drivers/i2c/busses/i2c-riic.c
>
> diff --git a/Documentation/devicetree/bindings/i2c/i2c-riic.txt b/Documentation/devicetree/bindings/i2c/i2c-riic.txt
> new file mode 100644
> index 0000000..900d129
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/i2c/i2c-riic.txt
> @@ -0,0 +1,29 @@
> +Device tree configuration for i2c-ocores

(e.g.) ... for Renesas RIIC SPI

> +
> +Required properties:
> +- compatible      : "renesas,riic-<soctype>". "renesas,riic-rz" as fallback
> +- reg             : address start and address range size of device
> +- interrupts      : 8 interrupts (TEI, RI, TI, SPI, STI, NAKI, ALI, TMOI)
> +- clock-frequency : frequency of bus clock in Hz
> +- #address-cells  : should be <1>
> +- #size-cells     : should be <0>
> +
> +Pinctrl properties might be needed, too. See there.
> +
> +Example:
> +
> +       i2c0: i2c at fcfee000 {
> +               compatible = "renesas,riic-r7s72100", "renesas,riic-rz";
> +               reg = <0xfcfee000 0x44>;
> +               interrupts = <0 157 IRQ_TYPE_LEVEL_HIGH>,
> +                            <0 158 IRQ_TYPE_EDGE_RISING>,
> +                            <0 159 IRQ_TYPE_EDGE_RISING>,
> +                            <0 160 IRQ_TYPE_LEVEL_HIGH>,
> +                            <0 161 IRQ_TYPE_LEVEL_HIGH>,
> +                            <0 162 IRQ_TYPE_LEVEL_HIGH>,
> +                            <0 163 IRQ_TYPE_LEVEL_HIGH>,
> +                            <0 164 IRQ_TYPE_LEVEL_HIGH>;
> +               clock-frequency = <100000>;
> +               #address-cells = <1>;
> +               #size-cells = <0>;
> +       };

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
