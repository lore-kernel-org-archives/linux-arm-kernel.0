From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Thu, 15 Feb 2018 10:07:14 +0100
Subject: [PATCH 5/8] arm64: dts: renesas: r8a77995: Add LVDS support
In-Reply-To: <1518683903-10681-6-git-send-email-kbingham@kernel.org>
References: <1518683903-10681-1-git-send-email-kbingham@kernel.org>
 <1518683903-10681-6-git-send-email-kbingham@kernel.org>
Message-ID: <CAMuHMdVKczZpoXgSDOSEJZb59LAZtbWsopRaa8PtHDoZcFEMTQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kieran,

On Thu, Feb 15, 2018 at 9:38 AM, Kieran Bingham <kbingham@kernel.org> wrote:
> From: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
>
> The r8a77995 D3 platform has 2 LVDS channels connected to the DU.
>
> Signed-off-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>

I love your patch!
Yet something to improve...

> --- a/arch/arm64/boot/dts/renesas/r8a77995.dtsi
> +++ b/arch/arm64/boot/dts/renesas/r8a77995.dtsi
> @@ -773,18 +773,70 @@
>                                 port at 1 {
>                                         reg = <1>;
>                                         du_out_lvds0: endpoint {
> +                                               remote-endpoint = <&du_out_lvds0>;
>                                         };
>                                 };
>
>                                 port at 2 {
>                                         reg = <2>;
>                                         du_out_lvds1: endpoint {
> +                                               remote-endpoint = <&du_out_lvds1>;
>                                         };
>                                 };
>                         };
>                 };
>         };
>
> +       lvds0: lvds at feb90000 {
> +               compatible = "renesas,lvds-r8a77995";
> +               reg = <0 0xfeb90000 0 0x20>;
> +               clocks = <&cpg CPG_MOD 727>;
> +               status = "disabled";

Missing resets, power-domains

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
