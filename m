From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Fri, 28 Oct 2016 12:51:34 +0200
Subject: [PATCH v5 1/7] ARM: dts: r8a7743: initial SoC device tree
In-Reply-To: <13559419.B3v0G6vn24@wasted.cogentembedded.com>
References: <1580369.yToZzJza1l@wasted.cogentembedded.com>
 <13559419.B3v0G6vn24@wasted.cogentembedded.com>
Message-ID: <CAMuHMdXt0yoHsk_BLpn+e8eqC+sz_VNV1xeOPPM4on=8i_Gb-Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sergei,

On Thu, Oct 27, 2016 at 11:36 PM, Sergei Shtylyov
<sergei.shtylyov@cogentembedded.com> wrote:
> The  initial R8A7743 SoC device tree including CPU0, GIC, timer, SYSC, RST,
> CPG, and the required clock descriptions.
>
> Based on the original (and large) patch by Dmitry Shifrin
> <dmitry.shifrin@cogentembedded.com>.
>
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
>
> ---
> Changes in version 5:
> - added the RST device node, updated the patch description accordingly.

Thanks for the update!

> +++ renesas/arch/arm/boot/dts/r8a7743.dtsi
> @@ -0,0 +1,120 @@

> +               rst: reset-controller at e6160000 {
> +                       compatible = "renesas,r8a7743-rst";
> +                       reg = <0 0xe6160000 0 0x0200>;

I'd use "reg = <0 0xe6160000 0 0x0100>".
Only R-Car Gen3 has registers above offset 0x100.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
