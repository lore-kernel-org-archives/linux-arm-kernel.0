From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Tue, 7 Nov 2017 10:11:20 +0100
Subject: [PATCH v4 02/15] arm64: dts: renesas: r8a7795-es1: Add IPMMU
 device nodes
In-Reply-To: <20171101103452.7491-3-horms+renesas@verge.net.au>
References: <20171101103452.7491-1-horms+renesas@verge.net.au>
 <20171101103452.7491-3-horms+renesas@verge.net.au>
Message-ID: <CAMuHMdUgW=KNLAg-hEoOPCF0-q=iP+j_PLFb4Qfxt+HSobZgnA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 1, 2017 at 11:34 AM, Simon Horman
<horms+renesas@verge.net.au> wrote:
> From: Magnus Damm <damm+renesas@opensource.se>
>
> Add r8a7795 ES1.x IPMMU nodes and keep all disabled by default.
>
> This is a follow-up to a patch that adds IPMMU device nodes that
> are common to r8a7795 ES1.x and ES2.0
>
> Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

> --- a/arch/arm64/boot/dts/renesas/r8a7795-es1.dtsi
> +++ b/arch/arm64/boot/dts/renesas/r8a7795-es1.dtsi
> @@ -26,6 +26,22 @@
>         /delete-node/ mmu at fd960000;
>         /delete-node/ mmu at fd970000;
>
> +       ipmmu_mp1: mmu at ec680000 {
> +               compatible = "renesas,ipmmu-r8a7795";
> +               reg = <0 0xec680000 0 0x1000>; /* IPMMU-MP1 */

Do we need the comments?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
