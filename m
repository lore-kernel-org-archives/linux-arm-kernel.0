From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Fri, 30 Mar 2018 10:01:14 +0200
Subject: [PATCH v3 2/8] DT: reset: renesas,rzn1-reboot: document RZ/N1
 reboot driver
In-Reply-To: <1522309629-10152-3-git-send-email-michel.pollet@bp.renesas.com>
References: <1522309629-10152-1-git-send-email-michel.pollet@bp.renesas.com>
 <1522309629-10152-3-git-send-email-michel.pollet@bp.renesas.com>
Message-ID: <CAMuHMdXo4wVD-b+_2WT+JUq6mpDpZoDvqMaLrs0yyjfe=Af4Dg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Michel,

On Thu, Mar 29, 2018 at 9:46 AM, Michel Pollet
<michel.pollet@bp.renesas.com> wrote:
> The Renesas RZ/N1 Family (Part #R9A06G0xx) requires a driver
> as part of the sysctrl MFD to handle rebooting the CA7 cores.
> This documents the driver bindings.
>
> Signed-off-by: Michel Pollet <michel.pollet@bp.renesas.com>

Thanks for your patch!

> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power/renesas,rzn1-reboot.txt
> @@ -0,0 +1,20 @@
> +DT bindings for the Renesas RZ/N1 Reboot Driver
> +
> +== Reboot Driver Node ==
> +
> +The reboot driver is always a subnode of the system controller node, see
> +renesas,rzn1-sysctrl.txt for details.
> +
> +Bindings:
> ++ Required:
> +       compatible = "renesas,rzn1-reboot";

You should list the supported SoC-specific compatible values here.

Quoting what I said on IRC:
1) DT bindings. These should list all compatible values possible/used.
2) DTS: These should list all applicable compatible values,
                from most-specific to least-specific (SoC-specific,
                family-specific (if exists), generic (if exists))
3 Driver: These should list only the least specific that is
                sufficient to get the job done. So usually we have the
                family-specific only, except if an SoC needs to be handled
                specially, or for historical reasons (DTB backeards
                compatibility)

> +
> +Example:
> +       sysctrl: sysctrl at 4000c000 {
> +               compatible = "renesas,rzn1-sysctrl", "syscon", "simple-mfd";

Missing SoC-specific compatible value.

> +               reg = <0x4000c000 0x1000>;
> +
> +               reboot {
> +                       compatible = "renesas,rzn1-reboot";

Missing SoC-specific compatible value.

> +               };
> +       };

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
