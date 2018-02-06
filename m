From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Tue, 6 Feb 2018 13:04:22 +0100
Subject: [PATCH 08/11] arm64: dts: renesas: r8a77980: add EtherAVB support
In-Reply-To: <99e9e3a5-a626-282a-3e8b-9c74945d55bc@cogentembedded.com>
References: <46fca582-220d-e5a7-62cd-2fc77a29846b@cogentembedded.com>
 <99e9e3a5-a626-282a-3e8b-9c74945d55bc@cogentembedded.com>
Message-ID: <CAMuHMdU1Xfc3u90TLQc0g6COuRa+hf5fukr+XAkSxgjSBV6vhg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sergei,

On Fri, Feb 2, 2018 at 7:42 PM, Sergei Shtylyov
<sergei.shtylyov@cogentembedded.com> wrote:
> Define the generic R8A77980 part of the EtherAVB device node.
>
> Based on the original (and large) patch by Vladimir Barinov.
>
> Signed-off-by: Vladimir Barinov <vladimir.barinov@cogentembedded.com>
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

Thanks for your patch!

> --- renesas.orig/arch/arm64/boot/dts/renesas/r8a77980.dtsi
> +++ renesas/arch/arm64/boot/dts/renesas/r8a77980.dtsi
> @@ -164,6 +164,50 @@
>                         status = "disabled";
>                 };
>
> +               avb: ethernet at e6800000 {
> +                       compatible = "renesas,etheravb-r8a77980",
> +                                    "renesas,etheravb-rcar-gen3";
> +                       reg = <0 0xe6800000 0 0x800>, <0 0xe6a00000 0 0x10000>;

According to the Hardware User Manual 0.80, V3H does not have the Stream
Buffer (second region).

> +                       phy-mode = "rgmii-id";

This is different from H3, M3-W, and D3. Care to elaborate for the layman
in me?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
