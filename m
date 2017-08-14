From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Mon, 14 Aug 2017 15:46:58 +0200
Subject: [PATCH 01/10] ARM: dts: r8a7778: Use R-Car GPIO Gen1 fallback
 compat string
In-Reply-To: <1502181568-12299-2-git-send-email-horms+renesas@verge.net.au>
References: <1502181568-12299-1-git-send-email-horms+renesas@verge.net.au>
 <1502181568-12299-2-git-send-email-horms+renesas@verge.net.au>
Message-ID: <CAMuHMdUxjAmSg=PNXhSU-M6CVVVH-Q1F+75XRpmsH7Hhye6XEQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Simon,

On Tue, Aug 8, 2017 at 10:39 AM, Simon Horman
<horms+renesas@verge.net.au> wrote:
> Use newly added R-Car GPIO Gen1 fallback compat string
> in place of now deprecated non-generation specific
> R-Car GPIO fallback compat string in DT of r8a7778 SoC.
>
> This should have no run-time effect as the driver matches against
> the per-SoC compat string before considering the fallback compat string.

That is not correct: the driver does not match against "renesas,gpio-r8a7778".
Hence this breaks using a new DTS and an old kernel (which we may decide not
to care about for R-Car Gen1, though).
But at least the DTS change should be postponed until commit d10bbd156926e65d
("gpio: rcar: add gen[123] fallback compatibility strings") has hit mainline.

> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> ---
>  arch/arm/boot/dts/r8a7778.dtsi | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/arch/arm/boot/dts/r8a7778.dtsi b/arch/arm/boot/dts/r8a7778.dtsi
> index 8f3156c0e575..b3975e4c75dd 100644
> --- a/arch/arm/boot/dts/r8a7778.dtsi
> +++ b/arch/arm/boot/dts/r8a7778.dtsi
> @@ -88,7 +88,7 @@
>         };
>
>         gpio0: gpio at ffc40000 {
> -               compatible = "renesas,gpio-r8a7778", "renesas,gpio-rcar";
> +               compatible = "renesas,gpio-r8a7778", "renesas,rcar-gen2-gpio";

... "renesas,rcar-gen1-gpio";

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
