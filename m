From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Mon, 16 May 2016 10:16:24 +0200
Subject: [PATCH 22/23] arm64: dts: r8a7795: Fix W=1 dtc warnings
In-Reply-To: <1463126163-29423-23-git-send-email-geert+renesas@glider.be>
References: <1463126163-29423-1-git-send-email-geert+renesas@glider.be>
 <1463126163-29423-23-git-send-email-geert+renesas@glider.be>
Message-ID: <CAMuHMdV6QwYwWkNfnBZZZdJG7=19ip81kYRKB4MTKH_K857fKA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 13, 2016 at 9:56 AM, Geert Uytterhoeven
<geert+renesas@glider.be> wrote:
> --- a/arch/arm64/boot/dts/renesas/r8a7795.dtsi
> +++ b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
> @@ -69,20 +69,22 @@
>                         next-level-cache = <&L2_CA57>;
>                         enable-method = "psci";
>                 };
> -       };
>
> -       L2_CA57: cache-controller at 0 {
> -               compatible = "cache";
> -               power-domains = <&sysc R8A7795_PD_CA57_SCU>;
> -               cache-unified;
> -               cache-level = <2>;
> -       };
> +               L2_CA57: cache-controller at 0 {
> +                       compatible = "cache";
> +                       reg = <0>;
> +                       power-domains = <&sysc R8A7795_PD_CA57_SCU>;
> +                       cache-unified;
> +                       cache-level = <2>;
> +               };
>
> -       L2_CA53: cache-controller at 1 {
> -               compatible = "cache";
> -               power-domains = <&sysc R8A7795_PD_CA53_SCU>;
> -               cache-unified;
> -               cache-level = <2>;
> +               L2_CA53: cache-controller at 100 {
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
