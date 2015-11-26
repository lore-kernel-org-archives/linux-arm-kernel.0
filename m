From: robin.murphy@arm.com (Robin Murphy)
Date: Thu, 26 Nov 2015 17:51:28 +0000
Subject: Preprocessor arithmetic in dtsi files (base + offset)
In-Reply-To: <CAMuHMdX9JRRURMxmNFcKOkzeO1B5Nmnk+XnOpgcLsPbiG4CfSA@mail.gmail.com>
References: <56570620.3070106@free.fr>
 <20151126135957.GC8644@n2100.arm.linux.org.uk> <56571ACC.9080306@free.fr>
 <CAMuHMdX9JRRURMxmNFcKOkzeO1B5Nmnk+XnOpgcLsPbiG4CfSA@mail.gmail.com>
Message-ID: <565746A0.108@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 26/11/15 16:23, Geert Uytterhoeven wrote:
[...]
> I guess this would work, too?
>
> scu_container at 20000000 {
>          compatible = "simple-bus";
>
>          ranges = <0x0 0x20000000 0x10000>;
>          #address-cells = <1>;
>          #size-cells = <1>;
>
>          scu: scu at 0 {
>                  compatible = "arm,cortex-a9-scu";
>                  reg = <0x0000 0x100>;
>
>          gic: interrupt-controller at 1000 {
>                  compatible = "arm,cortex-a9-gic";
>                  reg = <0x1000 0x1000>, <0x0100 0x0100>;
>
>          twd-timer at 0600 {
>                  compatible = "arm,cortex-a9-twd-timer";
>                  reg = <0x0600 0x10>;
> };
>
> No more explicit arithmetic needed, just substitue "20000000".

Which, funnily enough, ends up looking an awful lot like the definition 
in the hardware documentation[1] too ;)

Robin.

[1]:http://infocenter.arm.com/help/topic/com.arm.doc.ddi0407i/CACCJFCJ.html

> Gr{oetje,eeting}s,
>
>                          Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org
>
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                  -- Linus Torvalds
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
