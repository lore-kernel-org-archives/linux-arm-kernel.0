From: mturquette@linaro.org (Mike Turquette)
Date: Mon, 24 Nov 2014 21:51:11 -0800
Subject: [GIT PULL] Allwinner clocks changes for 3.19
In-Reply-To: <20141123164047.GA7599@lukather>
References: <20141123164047.GA7599@lukather>
Message-ID: <20141125055111.12298.93433@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Maxime Ripard (2014-11-23 08:40:47)
> Hi Mike,
> 
> Here is a bunch of clocks changes to merge for 3.19.
> 
> It might be followed by another pull request as there is a few
> developments that might be ready by the opening of the merge window,
> but it should be most of it.
> 
> Thanks,
> Maxime
> 
> The following changes since commit f114040e3ea6e07372334ade75d1ee0775c355e1:
> 
>   Linux 3.18-rc1 (2014-10-19 18:08:38 -0700)
> 
> are available in the git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/mripard/linux.git tags/sunxi-clocks-for-3.19
> 
> for you to fetch changes up to c1ec51603053260b138fc98e2ed18a5a9bea4515:
> 
>   clk: sunxi: gmac-tx-clk mux is not a CLK_MUX_INDEX_BIT mux (2014-11-23 17:02:57 +0100)

Pulled!

Thanks,
Mike

> 
> ----------------------------------------------------------------
> Allwinner Clocks additions for 3.19
> 
> A few patches that should go through the clock tree, mostly fixes, cleanups,
> and new clocks additions to start to support the A80.
> 
> ----------------------------------------------------------------
> Chen-Yu Tsai (7):
>       clk: sunxi: make factors clock mux mask configurable
>       clk: sunxi: Add support for A80 basic bus clocks
>       clk: sunxi: Add support for bus clock gates on Allwinner A80 SoC
>       ARM: dts: sunxi: Use sun4i-a10-apb1-clk for sun6i/sun8i apb2 clocks.
>       clk: sunxi: Removed unused/incorrect sun6i-a31-apb2-clk driver
>       clk: sunxi: Specify number of child clocks for divs clocks
>       clk: sunxi: Implement A31 PLL6 as a divs clock for 2x output
> 
> Emilio L?pez (2):
>       clk: sunxi: unify APB1 clock
>       ARM: dts: sunxi: unify APB1 clock
> 
> Hans de Goede (1):
>       clk: sunxi: gmac-tx-clk mux is not a CLK_MUX_INDEX_BIT mux
> 
>  Documentation/devicetree/bindings/clock/sunxi.txt |  31 ++-
>  arch/arm/boot/dts/sun4i-a10.dtsi                  |  12 +-
>  arch/arm/boot/dts/sun5i-a10s.dtsi                 |  12 +-
>  arch/arm/boot/dts/sun5i-a13.dtsi                  |  12 +-
>  arch/arm/boot/dts/sun6i-a31.dtsi                  |  12 +-
>  arch/arm/boot/dts/sun7i-a20.dtsi                  |  12 +-
>  arch/arm/boot/dts/sun8i-a23.dtsi                  |  12 +-
>  drivers/clk/sunxi/Makefile                        |   1 +
>  drivers/clk/sunxi/clk-a20-gmac.c                  |   7 +-
>  drivers/clk/sunxi/clk-factors.c                   |   2 +-
>  drivers/clk/sunxi/clk-factors.h                   |   3 +-
>  drivers/clk/sunxi/clk-mod0.c                      |   1 +
>  drivers/clk/sunxi/clk-sun8i-mbus.c                |   1 +
>  drivers/clk/sunxi/clk-sun9i-core.c                | 271 ++++++++++++++++++++++
>  drivers/clk/sunxi/clk-sunxi.c                     |  85 ++++---
>  15 files changed, 380 insertions(+), 94 deletions(-)
>  create mode 100644 drivers/clk/sunxi/clk-sun9i-core.c
> 
> -- 
> Maxime Ripard, Free Electrons
> Embedded Linux, Kernel and Android engineering
> http://free-electrons.com
