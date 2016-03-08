From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Tue, 8 Mar 2016 09:54:50 +0100
Subject: [PATCH RESEND] Documentation: devicetree: Clean up gpio-keys
 example
In-Reply-To: <1457375055-5544-1-git-send-email-afaerber@suse.de>
References: <1457375055-5544-1-git-send-email-afaerber@suse.de>
Message-ID: <CAMuHMdVMVYaygvKd3qgTz2fF9SuLA_zEYRoZZrJO+2zmP=jxag@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 7, 2016 at 7:24 PM, Andreas F?rber <afaerber@suse.de> wrote:
> Drop #address-cells and #size-cells, which are not required by the
> gpio-keys binding documentation, as button sub-nodes are not devices.
>
> Reported-by: Julien Chauveau <chauveau.julien@gmail.com>
> Signed-off-by: Andreas F?rber <afaerber@suse.de>
> ---
>  Documentation/devicetree/bindings/input/gpio-keys.txt | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/input/gpio-keys.txt b/Documentation/devicetree/bindings/input/gpio-keys.txt
> index 21641236c095..1552a11f6786 100644
> --- a/Documentation/devicetree/bindings/input/gpio-keys.txt
> +++ b/Documentation/devicetree/bindings/input/gpio-keys.txt
> @@ -34,8 +34,6 @@ Example nodes:
>
>         gpio_keys {
>                         compatible = "gpio-keys";
> -                       #address-cells = <1>;
> -                       #size-cells = <0>;
>                         autorepeat;
>                         button at 21 {

FYI, with "[PATCH] scripts/dtc: Update to upstream version 53bf130b1cdd":
(http://www.spinics.net/lists/devicetree/msg117206.html) applied:

Warning (unit_address_vs_reg): Node /keyboard/button at 21 has a unit
name, but no reg property

>                                 label = "GPIO Key UP";

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
