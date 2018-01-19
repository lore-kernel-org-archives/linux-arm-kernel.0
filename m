From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Fri, 19 Jan 2018 21:13:04 +0100
Subject: [PATCH 4/5] arm64: dts: renesas: r8a77970: add LVDS support
In-Reply-To: <20180119195439.145129729@cogentembedded.com>
References: <20180119195439.145129729@cogentembedded.com>
Message-ID: <CAMuHMdXOLLizyzm6wFbV-0_oYXvF5xmRQBQn20f6oCe4HOe8CA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sergei,

On Fri, Jan 19, 2018 at 8:42 PM, Sergei Shtylyov
<sergei.shtylyov@cogentembedded.com> wrote:
> Define the generic R8A77970 part of the LVDS device node.
>
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

I love your patch! Yet something to improve...

> --- renesas.orig/arch/arm64/boot/dts/renesas/r8a77970.dtsi
> +++ renesas/arch/arm64/boot/dts/renesas/r8a77970.dtsi
> @@ -654,6 +654,31 @@
>                                 port at 1 {
>                                         reg = <1>;
>                                         du_out_lvds: endpoint {
> +                                               remote-endpoint = <&lvds_in>;
> +                                       };
> +                               };
> +                       };
> +               };
> +
> +               lvds: lvds at feb90000 {
> +                       compatible = "renesas,r8a77970-lvds";
> +                       reg = <0 0xfeb90000 0 0x14>;
> +                       clocks = <&cpg CPG_MOD 727>;

Missing resets and power-domains properties.

> +                       status = "disabled";
> +
> +                       ports {
> +                               #address-cells = <1>;
> +                               #size-cells = <0>;
> +
> +                               port at 0 {
> +                                       reg = <0>;
> +                                       lvds_in: endpoint {
> +                                               remote-endpoint = <&du_out_lvds>;
> +                                       };
> +                               };
> +                               port at 1 {
> +                                       reg = <1>;
> +                                       lvds_out: endpoint {
>                                         };
>                                 };
>                         };
>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
