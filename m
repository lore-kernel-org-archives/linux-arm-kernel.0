From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Mon, 9 Oct 2017 13:56:17 +0200
Subject: [PATCH v2 2/2] arm64: dts: r8a7796: Add OPPs table for cpu devices
In-Reply-To: <1507209984-17123-3-git-send-email-horms+renesas@verge.net.au>
References: <1507209984-17123-1-git-send-email-horms+renesas@verge.net.au>
 <1507209984-17123-3-git-send-email-horms+renesas@verge.net.au>
Message-ID: <CAMuHMdWnpx4UUSgWv5oPyqPBb2EHtGH8BpZ_zxtv+BdWwgmNaw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Simon,

On Thu, Oct 5, 2017 at 3:26 PM, Simon Horman <horms+renesas@verge.net.au> wrote:
> From: Dien Pham <dien.pham.ry@rvc.renesas.com>
>
> Current, OPP tables are defined temporary,
> they are being evaluated and adjust in future.
>
> Based in part on work by Hien Dang.

> --- a/arch/arm64/boot/dts/renesas/r8a7796.dtsi
> +++ b/arch/arm64/boot/dts/renesas/r8a7796.dtsi

> @@ -108,6 +116,56 @@
>                 };
>         };
>
> +       cluster0_opp: opp_table0 {
> +               compatible = "operating-points-v2";
> +               opp-shared;
> +
> +               opp at 500000000 {

As reported before, with "make dtbs W=1":

arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dtb: Warning
(unit_address_vs_reg): Node /opp_table0/opp at 500000000 has a unit name,
but no reg property

etc.

opp-500000000

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
