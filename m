From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Thu, 13 Aug 2015 10:41:09 +0200
Subject: [PATCH 2/2] clk: Convert __clk_get_name(hw->clk) to
 clk_hw_get_name(hw)
In-Reply-To: <1439421161-17868-2-git-send-email-sboyd@codeaurora.org>
References: <1439421161-17868-1-git-send-email-sboyd@codeaurora.org>
 <1439421161-17868-2-git-send-email-sboyd@codeaurora.org>
Message-ID: <CAMuHMdXo4ChAfbi5h0okyw18LNM5iv-rfx_AO9e_u7QAB8Vx9A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 13, 2015 at 1:12 AM, Stephen Boyd <sboyd@codeaurora.org> wrote:
> Use the provider based method to get a clock's name so that we
> can get rid of the clk member in struct clk_hw one day. Mostly
> converted with the following coccinelle script.
>
> @@
> struct clk_hw *E;
> @@
>
> -__clk_get_name(E->clk)
> +clk_hw_get_name(E)
>
> Cc: Heiko Stuebner <heiko@sntech.de>
> Cc: Sylwester Nawrocki <s.nawrocki@samsung.com>
> Cc: Tomasz Figa <tomasz.figa@gmail.com>
> Cc: Peter De Schrijver <pdeschrijver@nvidia.com>
> Cc: Prashant Gaikwad <pgaikwad@nvidia.com>
> Cc: Stephen Warren <swarren@wwwdotorg.org>
> Cc: Thierry Reding <thierry.reding@gmail.com>
> Cc: Alexandre Courbot <gnurou@gmail.com>
> Cc: Tero Kristo <t-kristo@ti.com>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Cc: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> Cc: Andrew Bresticker <abrestic@chromium.org>
> Cc: Ezequiel Garcia <ezequiel.garcia@imgtec.com>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: Kevin Cernekee <cernekee@chromium.org>
> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> Cc: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: linux-rockchip at lists.infradead.org
> Cc: linux-samsung-soc at vger.kernel.org
> Cc: linux-tegra at vger.kernel.org
> Cc: linux-omap at vger.kernel.org
> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>

>  drivers/clk/shmobile/clk-div6.c      |  2 +-

For the shmobile part:

Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
