From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Thu, 22 Mar 2018 13:29:52 +0100
Subject: [PATCH v2 1/8] DT: mfd: renesas,rzn1-sysctrl: document RZ/N1
 sysctrl node
In-Reply-To: <1521719091-25157-2-git-send-email-michel.pollet@bp.renesas.com>
References: <1521719091-25157-1-git-send-email-michel.pollet@bp.renesas.com>
 <1521719091-25157-2-git-send-email-michel.pollet@bp.renesas.com>
Message-ID: <CAMuHMdUx7E3dk0S678HOotv3E33ZEjfoEQ=xaRpNLMCKMVnXLA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Michel,

Thanks for your patch!

On Thu, Mar 22, 2018 at 12:44 PM, Michel Pollet
<michel.pollet@bp.renesas.com> wrote:
> The Renesas RZ/N1 Family (Part #R9A06G0xx) has a multi-function
> system controller. This documents the node used to encapsulate
> it's sub drivers.

its

>
> Signed-off-by: Michel Pollet <michel.pollet@bp.renesas.com>

> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/renesas,rzn1-sysctrl.txt
> @@ -0,0 +1,22 @@
> +DT bindings for the Renesas RZ-N1 System Controller

RZ/N1

> +
> +== System Controller Node ==
> +
> +The system controller node currently only hosts a single sub-driver to handle

s/sub-driver/sub-node/

> +the rebooting of the CPU. Eventually it will host the clock driver, SMP
> +start handler, watchdog etc.
> +
> +See renesas,rzn1-reboot.txt for further details.
> +
> +Bindings:
> ++ Optional:
> +       compatible = "renesas,r9a06g032-sysctrl";
> ++ Required:
> +       compatible = "renesas,rzn1-sysctrl";

Please mark both the SoC-specific and the family-specific values required.
Missing "syscon", "simple-mfd".

> +
> +Example:
> +       sysctrl: sysctrl at 4000c000 {
> +               compatible = "renesas,r9a06g032-sysctrl",
> +                       "renesas,rzn1-sysctrl", "syscon", "simple-mfd";
> +               reg = <0x4000c000 0x1000>;
> +       };

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
