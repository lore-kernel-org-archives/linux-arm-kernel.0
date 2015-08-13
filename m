From: abrestic@chromium.org (Andrew Bresticker)
Date: Thu, 13 Aug 2015 09:40:07 -0700
Subject: [PATCH 2/2] clk: Convert __clk_get_name(hw->clk) to
 clk_hw_get_name(hw)
In-Reply-To: <1439421161-17868-2-git-send-email-sboyd@codeaurora.org>
References: <1439421161-17868-1-git-send-email-sboyd@codeaurora.org>
 <1439421161-17868-2-git-send-email-sboyd@codeaurora.org>
Message-ID: <CAL1qeaE-UJD3CBx=6feF=Hu4=gu5AtQiWwQAZmbg+6qYLhOy2Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 12, 2015 at 4:12 PM, Stephen Boyd <sboyd@codeaurora.org> wrote:
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

>  drivers/clk/pistachio/clk-pll.c      |  4 ++--

For Pistachio,

Acked-by: Andrew Bresticker <abrestic@chromium.org>
