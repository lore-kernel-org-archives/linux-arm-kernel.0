From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Fri, 26 Jan 2018 11:25:52 +0100
Subject: [RFC 30/37] clk: renesas: r8a7794: Add rwdt clock
In-Reply-To: <1516903391-30467-31-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1516903391-30467-1-git-send-email-fabrizio.castro@bp.renesas.com>
 <1516903391-30467-31-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <CAMuHMdV0BWfDJvRsjqvmi5pYRcJwrNFf7Byd_mWU6w+fD24WbA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 25, 2018 at 7:03 PM, Fabrizio Castro
<fabrizio.castro@bp.renesas.com> wrote:
> Add "rwdt" clock to r8a7794_mod_clks. Also, since we may need to access
> the watchdog registers at any time, declare the clock as critical.
>
> Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> Signed-off-by: Ramesh Shanmugasundaram <ramesh.shanmugasundaram@bp.renesas.com>

With the critical clock handling removed (that can be done by the driver,
if really needed)

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

> --- a/drivers/clk/renesas/r8a7794-cpg-mssr.c
> +++ b/drivers/clk/renesas/r8a7794-cpg-mssr.c
> @@ -121,6 +121,7 @@ static const struct mssr_mod_clk r8a7794_mod_clks[] __initconst = {
>         DEF_MOD("cmt1",                  329,   R8A7794_CLK_R),
>         DEF_MOD("usbhs-dmac0",           330,   R8A7794_CLK_HP),
>         DEF_MOD("usbhs-dmac1",           331,   R8A7794_CLK_HP),
> +       DEF_MOD("rwdt",                  402,   R8A7794_CLK_R),
>         DEF_MOD("irqc",                  407,   R8A7794_CLK_CP),
>         DEF_MOD("intc-sys",              408,   R8A7794_CLK_ZS),
>         DEF_MOD("audio-dmac0",           502,   R8A7794_CLK_HP),
> @@ -190,6 +191,7 @@ static const struct mssr_mod_clk r8a7794_mod_clks[] __initconst = {
>  };
>
>  static const unsigned int r8a7794_crit_mod_clks[] __initconst = {
> +       MOD_CLK_ID(402),        /* RWDT */
>         MOD_CLK_ID(408),        /* INTC-SYS (GIC) */
>  };

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
