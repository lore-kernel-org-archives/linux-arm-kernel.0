From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Mon, 11 Jun 2018 11:00:28 +0900
Subject: [GIT PULL] Allwinner clock changes for 4.18
In-Reply-To: <20180521115947.wqrnv2hczate65lz@flea>
References: <20180521115947.wqrnv2hczate65lz@flea>
Message-ID: <CAK7LNASgetmPKKS8AhYXqSSEFCi+q0ASZ68M0SECJT5EbAU4XQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Maxime,


2018-05-21 20:59 GMT+09:00 Maxime Ripard <maxime.ripard@bootlin.com>:
> Hi Mike, Stephen,
>
> Please merge the following changes for the next merge window, thanks!
>
> Maxime
>
> The following changes since commit 60cc43fc888428bb2f18f08997432d426a243338:
>
>   Linux 4.17-rc1 (2018-04-15 18:24:20 -0700)
>
> are available in the Git repository at:
>
>   https://git.kernel.org/pub/scm/linux/kernel/git/sunxi/linux.git tags/sunxi-clk-for-4.18
>
> for you to fetch changes up to 17de4c857b1f74b90967f7e7fd5ff81be61dc044:
>
>   clk: sunxi-ng: r40: export a regmap to access the GMAC register (2018-05-17 14:02:07 +0800)
>
> ----------------------------------------------------------------
> Allwinner clock changes for 4.18
>
> Not a lot of changes for this release, but two quite important features
> were added: the H6 PRCM clock support, and the needed changes to the R40
> clock driver to allow for the EMAC to operate.
>
> ----------------------------------------------------------------
> Icenowy Zheng (3):
>       clk: sunxi-ng: add support for H6 PRCM CCU
>       clk: sunxi-ng: r40: rewrite init code to a platform driver
>       clk: sunxi-ng: r40: export a regmap to access the GMAC register
>



Why was my patch "clk: sunxi-ng: replace lib-y with obj-y"
not included in the pull request?


You said "I've picked it up"
https://patchwork.kernel.org/patch/10348031/




>  .../devicetree/bindings/clock/sunxi-ccu.txt        |   3 +-
>  drivers/clk/sunxi-ng/Kconfig                       |   5 +
>  drivers/clk/sunxi-ng/Makefile                      |   1 +
>  drivers/clk/sunxi-ng/ccu-sun50i-h6-r.c             | 207 +++++++++++++++++++++
>  drivers/clk/sunxi-ng/ccu-sun50i-h6-r.h             |  19 ++
>  drivers/clk/sunxi-ng/ccu-sun8i-r40.c               |  72 +++++--
>  include/dt-bindings/clock/sun50i-h6-r-ccu.h        |  24 +++
>  include/dt-bindings/reset/sun50i-h6-r-ccu.h        |  17 ++
>  8 files changed, 336 insertions(+), 12 deletions(-)
>  create mode 100644 drivers/clk/sunxi-ng/ccu-sun50i-h6-r.c
>  create mode 100644 drivers/clk/sunxi-ng/ccu-sun50i-h6-r.h
>  create mode 100644 include/dt-bindings/clock/sun50i-h6-r-ccu.h
>  create mode 100644 include/dt-bindings/reset/sun50i-h6-r-ccu.h
>
> --
> Maxime Ripard, Bootlin (formerly Free Electrons)
> Embedded Linux and Kernel engineering
> https://bootlin.com



-- 
Best Regards
Masahiro Yamada
