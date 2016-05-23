From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Mon, 23 May 2016 09:07:20 +0200
Subject: [PATCH v2 1/3] arm64: dts: r8a7796: Add Renesas R8A7796 SoC
 support
In-Reply-To: <1463966906-15129-2-git-send-email-horms+renesas@verge.net.au>
References: <1463966906-15129-1-git-send-email-horms+renesas@verge.net.au>
 <1463966906-15129-2-git-send-email-horms+renesas@verge.net.au>
Message-ID: <CAMuHMdXsu=O13rLysob1Xp+5vWcp7gq6byCffR-6hGc+W-837A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 23, 2016 at 3:28 AM, Simon Horman
<horms+renesas@verge.net.au> wrote:
> Basic support for the Gen 3 R-Car M3-W SoC.
>
> Based on work for the r8a7795 and r8a7796 SoCs by
> Takeshi Kihara, Dirk Behme and Geert Uytterhoeven.
>
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

> --- /dev/null
> +++ b/arch/arm64/boot/dts/renesas/r8a7796.dtsi
> @@ -0,0 +1,120 @@
> +       psci {
> +               compatible = "arm,psci-1.0";

Do we want to use 1.0 on r8a7795, too?

> +               method = "smc";
> +       };

> +       soc {
> +               compatible = "simple-bus";
> +               interrupt-parent = <&gic>;
> +               #address-cells = <2>;
> +               #size-cells = <2>;
> +               ranges;
> +
> +               gic: interrupt-controller at 0xf1010000 {

If you drop the "0x" (which is BTW also present in r8a7795.dtsi), you can add
my
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
