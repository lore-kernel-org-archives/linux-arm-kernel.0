From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 19 Jul 2017 08:23:01 +0200
Subject: [PATCH] clk: Convert to using %pOF instead of full_name
In-Reply-To: <20170718214339.7774-12-robh@kernel.org>
References: <20170718214339.7774-12-robh@kernel.org>
Message-ID: <20170719062301.bextqsjufe7gjozt@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 18, 2017 at 04:42:52PM -0500, Rob Herring wrote:
> Now that we have a custom printf format specifier, convert users of
> full_name to use %pOF instead. This is preparation to remove storing
> of the full path string for each node.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> Cc: Michael Turquette <mturquette@baylibre.com>
> Cc: Stephen Boyd <sboyd@codeaurora.org>
> Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>
> Cc: Alexandre Torgue <alexandre.torgue@st.com>
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: Matthias Brugger <matthias.bgg@gmail.com>
> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> Cc: Maxime Ripard <maxime.ripard@free-electrons.com>
> Cc: Chen-Yu Tsai <wens@csie.org>
> Cc: "Emilio L?pez" <emilio@elopez.com.ar>
> Cc: Peter De Schrijver <pdeschrijver@nvidia.com>
> Cc: Prashant Gaikwad <pgaikwad@nvidia.com>
> Cc: Thierry Reding <thierry.reding@gmail.com>
> Cc: Jonathan Hunter <jonathanh@nvidia.com>
> Cc: Tero Kristo <t-kristo@ti.com>
> Cc: linux-clk at vger.kernel.org
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: linux-mediatek at lists.infradead.org
> Cc: linux-renesas-soc at vger.kernel.org
> Cc: linux-tegra at vger.kernel.org
> Cc: linux-omap at vger.kernel.org
> ---
>  drivers/clk/berlin/bg2.c             |  3 +--
>  drivers/clk/berlin/bg2q.c            |  7 +++----
>  drivers/clk/clk-asm9260.c            |  4 ++--
>  drivers/clk/clk-conf.c               | 16 ++++++++--------
>  drivers/clk/clk-moxart.c             | 12 ++++++------
>  drivers/clk/clk-qoriq.c              |  7 +++----
>  drivers/clk/clk-stm32f4.c            |  4 ++--
>  drivers/clk/clk-xgene.c              | 15 ++++++---------
>  drivers/clk/clk.c                    |  4 ++--
>  drivers/clk/clkdev.c                 |  4 ++--
>  drivers/clk/mediatek/clk-cpumux.c    |  2 +-
>  drivers/clk/mediatek/clk-mtk.c       |  2 +-
>  drivers/clk/mediatek/reset.c         |  2 +-
>  drivers/clk/renesas/clk-mstp.c       |  2 +-
>  drivers/clk/renesas/clk-rcar-gen2.c  |  3 +--
>  drivers/clk/sunxi-ng/ccu-sun5i.c     |  3 +--
>  drivers/clk/sunxi-ng/ccu-sun6i-a31.c |  3 +--
>  drivers/clk/sunxi-ng/ccu-sun8i-a23.c |  3 +--
>  drivers/clk/sunxi-ng/ccu-sun8i-a33.c |  3 +--
>  drivers/clk/sunxi-ng/ccu-sun8i-h3.c  |  3 +--
>  drivers/clk/sunxi-ng/ccu-sun8i-r.c   |  3 +--
>  drivers/clk/sunxi-ng/ccu-sun8i-v3s.c |  3 +--
>  drivers/clk/sunxi/clk-sunxi.c        | 17 +++++++----------

For the sunxi and sunxi-ng clocks:
Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170719/50ff4fce/attachment.sig>
