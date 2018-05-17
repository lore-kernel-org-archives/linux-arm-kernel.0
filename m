From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Thu, 17 May 2018 22:23:04 +0200
Subject: [PATCH] arm64: dts: renesas: r8a77980: add SMP support
In-Reply-To: <ec4c6905-23d1-8600-a1cc-4297fbd1ddaa@cogentembedded.com>
References: <14666252.G84Ipxe6EL@wasted.cogentembedded.com>
 <ec4c6905-23d1-8600-a1cc-4297fbd1ddaa@cogentembedded.com>
Message-ID: <CAMuHMdU9JXvN2GLFGLZGeNOpZ9AdJYokbpTqt-Wy97-Z0tXaCA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sergei,

On Thu, May 17, 2018 at 10:19 PM, Sergei Shtylyov
<sergei.shtylyov@cogentembedded.com> wrote:
> Add the device nodes for 3 more Cortex-A53 CPU cores; adjust the interrupt
> delivery masks for the ARM GIC and Architectured Timer.
>
> Based on the original (and large) patch by Vladimir Barinov.
>
> Signed-off-by: Vladimir Barinov <vladimir.barinov@cogentembedded.com>
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

Thanks for your patch!

> --- renesas.orig/arch/arm64/boot/dts/renesas/r8a77980.dtsi
> +++ renesas/arch/arm64/boot/dts/renesas/r8a77980.dtsi
> @@ -30,6 +30,36 @@
>                         enable-method = "psci";
>                 };
>
> +               a53_1: cpu at 1 {
> +                       device_type = "cpu";
> +                       compatible = "arm,cortex-a53","arm,armv8";

Please stop copying spaceless lists ;-)

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
