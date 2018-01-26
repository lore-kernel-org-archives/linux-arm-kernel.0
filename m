From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Fri, 26 Jan 2018 10:52:19 +0100
Subject: [RFC 02/37] ARM: dts: r8a7743: Adjust SMP routine size
In-Reply-To: <1516903391-30467-3-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1516903391-30467-1-git-send-email-fabrizio.castro@bp.renesas.com>
 <1516903391-30467-3-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <CAMuHMdWdpSj+_jK8eUfeHA-Dn4uK+4fXLBuFuU6X65AC8Fc=zQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 25, 2018 at 7:02 PM, Fabrizio Castro
<fabrizio.castro@bp.renesas.com> wrote:
> This patch adjusts the definition of the SMP routine size according
> to the latest changes made by commit:
> "ARM: shmobile: Add watchdog support"
>
> Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> Signed-off-by: Ramesh Shanmugasundaram <ramesh.shanmugasundaram@bp.renesas.com>

I would make it a bit larger, though. "0x64" is the strict minimum =>
0x80? 0x100?

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

> --- a/arch/arm/boot/dts/r8a7743.dtsi
> +++ b/arch/arm/boot/dts/r8a7743.dtsi
> @@ -973,7 +973,7 @@
>
>                         smp-sram at 0 {
>                                 compatible = "renesas,smp-sram";
> -                               reg = <0 0x10>;
> +                               reg = <0 0x64>;
>                         };
>                 };

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
