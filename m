From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Wed, 23 Mar 2016 08:43:33 +0100
Subject: [PATCH v2 2/2] ARM: dts: sh73a0: Remove unnecessary
 clock-output-names properties
In-Reply-To: <1458695203-9950-3-git-send-email-horms+renesas@verge.net.au>
References: <1458695203-9950-1-git-send-email-horms+renesas@verge.net.au>
 <1458695203-9950-3-git-send-email-horms+renesas@verge.net.au>
Message-ID: <CAMuHMdU0S_xs0Q4ATHaUPwJx150iFnP5OxGmhYrg3ZDZ2YBkBg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Simon,

On Wed, Mar 23, 2016 at 2:06 AM, Simon Horman
<horms+renesas@verge.net.au> wrote:
> * Fixed rate and fixed factor clocks do not require an
>   clock-output-names property.
> * Since 07705583e920fef6 ("clk: shmobile: div6: Make clock-output-names
>   optional") Renesas div6 clocks do not require a clock-output-names
>   property.
>
> In the above cases there is only one clock output and its name is taken
> from that of the clock node.  Accordingly, remove the unnecessary
> clock-output-names properties and as necessary update the node names.
>
> The clock-output-names property is left in place for the zb_clk which is
> thus treated as a special case as the MSTP clock driver (clk-mstp.c)
> explicitly looks for a clock named zb_clk for the r8a73a4 and sh73a0 SoCs.

... a clock with node name zb_clk ...

> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

With the above change:
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
