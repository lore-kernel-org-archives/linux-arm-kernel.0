From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Mon, 12 Sep 2016 10:35:59 +0200
Subject: [PATCH 5/8] clk: renesas: r8a7796: Add CMT clocks
In-Reply-To: <1473421394-9745-6-git-send-email-bd-phuc@jinso.co.jp>
References: <1473421394-9745-1-git-send-email-bd-phuc@jinso.co.jp>
 <1473421394-9745-6-git-send-email-bd-phuc@jinso.co.jp>
Message-ID: <CAMuHMdWLtcHHw+nmKKN3j4yqkncsh3YwDu-yGEwqg3Du4-kncg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 9, 2016 at 1:43 PM,  <bd-phuc@jinso.co.jp> wrote:
> From: Bui Duc Phuc <bd-phuc@jinso.co.jp>
>
> This patch adds CMT module clocks for r8a7796 SoC.
>
> Signed-off-by: Bui Duc Phuc <bd-phuc@jinso.co.jp>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

(will queue in clk-renesas-for-v4.9)

> --- a/drivers/clk/renesas/r8a7796-cpg-mssr.c
> +++ b/drivers/clk/renesas/r8a7796-cpg-mssr.c
> @@ -97,6 +97,10 @@ static const struct cpg_core_clk r8a7796_core_clks[] __initconst = {
>  };
>
>  static const struct mssr_mod_clk r8a7796_mod_clks[] __initconst = {
> +       DEF_MOD("cmt3",                  300,   R8A7796_CLK_R),
> +       DEF_MOD("cmt2",                  301,   R8A7796_CLK_R),
> +       DEF_MOD("cmt1",                  302,   R8A7796_CLK_R),
> +       DEF_MOD("cmt0",                  303,   R8A7796_CLK_R),

BTW, I've dropped the spaces before the TABs (also in the r8a7795 patch).

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
