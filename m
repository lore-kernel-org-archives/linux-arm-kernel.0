From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Fri, 30 Mar 2018 10:10:57 +0200
Subject: [PATCH v3 6/8] DT: arm: Add Renesas RZ/N1 SoC base device tree
 file
In-Reply-To: <1522309629-10152-7-git-send-email-michel.pollet@bp.renesas.com>
References: <1522309629-10152-1-git-send-email-michel.pollet@bp.renesas.com>
 <1522309629-10152-7-git-send-email-michel.pollet@bp.renesas.com>
Message-ID: <CAMuHMdX5cSB5wDJWq4aWuihN5+z_4T+ZUN4AR-Sm0Q+N4RZE0A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Michel,

On Thu, Mar 29, 2018 at 9:47 AM, Michel Pollet
<michel.pollet@bp.renesas.com> wrote:
> This adds the Renesas RZ/N1 Family (Part #R9A06G0xx) SoC
> bare bone support.
>
> This currently only handles generic parts (gic, architected timer)
> and a UART.
> For simplicity sake, this also relies on the bootloader to set the
> pinctrl and clocks.
>
> Signed-off-by: Michel Pollet <michel.pollet@bp.renesas.com>

Thanks for your patch!

> --- /dev/null
> +++ b/arch/arm/boot/dts/r9a06g0xx.dtsi

As I said on IRC, I'm not so happy with this r9a06g0xx.dtsi file without
SoC-specific compatible values, as you have to override all of them in
r9a06g032.dtsi and r9a06g033.dtsi

Moreover, in this series you dropped r9a06g032.dtsi, so the devices no longer
have SoC-specific compatible values?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
