From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Mon, 26 Feb 2018 09:14:36 +0100
Subject: [PATCH v2 01/19] clk: renesas: cpg-mssr: Add support for R-Car
 M3-N
In-Reply-To: <1519139541-18783-2-git-send-email-jacopo+renesas@jmondi.org>
References: <1519139541-18783-1-git-send-email-jacopo+renesas@jmondi.org>
 <1519139541-18783-2-git-send-email-jacopo+renesas@jmondi.org>
Message-ID: <CAMuHMdWcLd6BnwW2fwOPhpsRZ=qfuYE6YoehFj8WXkUmGZMW_A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jacopo,

On Tue, Feb 20, 2018 at 4:12 PM, Jacopo Mondi <jacopo+renesas@jmondi.org> wrote:
> Initial support for R-Car M3-N (r8a77965), including core and module
> clocks.
>
> Based on Table 8.2d of "R-Car Series, 3rd Generation User's Manual:
> Hardware (Rev. 0.80, Oct 31, 2017)".
>
> Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>

> --- a/Documentation/devicetree/bindings/clock/renesas,cpg-mssr.txt
> +++ b/Documentation/devicetree/bindings/clock/renesas,cpg-mssr.txt
> @@ -22,6 +22,7 @@ Required Properties:
>        - "renesas,r8a7794-cpg-mssr" for the r8a7794 SoC (R-Car E2)
>        - "renesas,r8a7795-cpg-mssr" for the r8a7795 SoC (R-Car H3)
>        - "renesas,r8a7796-cpg-mssr" for the r8a7796 SoC (R-Car M3-W)
> +      - "renesas,r8a77965-cpg-mssr" for the r8a77965 SoC (R-Car M3-N)
>        - "renesas,r8a77970-cpg-mssr" for the r8a77970 SoC (R-Car V3M)
>        - "renesas,r8a77995-cpg-mssr" for the r8a77995 SoC (R-Car D3)

You forgot to update the list of external parent clock names.
No need to fix and resend, I've squashed in the following:

--- a/Documentation/devicetree/bindings/clock/renesas,cpg-mssr.txt
+++ b/Documentation/devicetree/bindings/clock/renesas,cpg-mssr.txt
@@ -34,8 +34,8 @@ Required Properties:
     clock-names
   - clock-names: List of external parent clock names. Valid names are:
       - "extal" (r8a7743, r8a7745, r8a7790, r8a7791, r8a7792, r8a7793, r8a7794,
-                r8a7795, r8a7796, r8a77970, r8a77980, r8a77995)
-      - "extalr" (r8a7795, r8a7796, r8a77970, r8a77980)
+                r8a7795, r8a7796, r8a77965, r8a77970, r8a77980, r8a77995)
+      - "extalr" (r8a7795, r8a7796, r8a77965, r8a77970, r8a77980)
       - "usb_extal" (r8a7743, r8a7745, r8a7790, r8a7791, r8a7793, r8a7794)

   - #clock-cells: Must be 2

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
