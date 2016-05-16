From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Mon, 16 May 2016 10:15:52 +0200
Subject: [PATCH 02/23] ARM: dts: r8a73a4: Fix W=1 dtc warnings
In-Reply-To: <1463126163-29423-3-git-send-email-geert+renesas@glider.be>
References: <1463126163-29423-1-git-send-email-geert+renesas@glider.be>
 <1463126163-29423-3-git-send-email-geert+renesas@glider.be>
Message-ID: <CAMuHMdVvQGgdfT+ddu7gun7awkm0P4C85cBJq6SZQxoY7ua4XQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 13, 2016 at 9:55 AM, Geert Uytterhoeven
<geert+renesas@glider.be> wrote:
> --- a/arch/arm/boot/dts/r8a73a4.dtsi
> +++ b/arch/arm/boot/dts/r8a73a4.dtsi
> @@ -31,6 +31,24 @@
>                         power-domains = <&pd_a2sl>;
>                         next-level-cache = <&L2_CA15>;
>                 };
> +
> +               L2_CA15: cache-controller at 0 {
> +                       compatible = "cache";
> +                       reg = <0>;
> +                       clocks = <&cpg_clocks R8A73A4_CLK_Z>;
> +                       power-domains = <&pd_a3sm>;
> +                       cache-unified;
> +                       cache-level = <2>;
> +               };
> +
> +               L2_CA7: cache-controller at 100 {
> +                       compatible = "cache";
> +                       reg = <100>;

Oops, <0x100>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
