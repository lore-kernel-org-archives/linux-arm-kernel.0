From: wens@csie.org (Chen-Yu Tsai)
Date: Tue, 16 Sep 2014 16:15:13 +0800
Subject: [PATCH v2 0/2] clk: sun8i: Add MBUS support
In-Reply-To: <1410855167-1121-1-git-send-email-wens@csie.org>
References: <1410855167-1121-1-git-send-email-wens@csie.org>
Message-ID: <CAGb2v67hb9nhvwzecugF7NDszz11Y1V-oyumW_VgxgKOqzdgzQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 16, 2014 at 4:12 PM, Chen-Yu Tsai <wens@csie.org> wrote:
> Hi,
>
> This is v2 of my sun8i MBUS clock series.
>
> This series depends on Maxime's "clk: sunxi: Improve MMC clocks support"
> series, specifically the patches that change the factor clocks and move
> out mod0 and mbus. Ideally this series should also be merged after my
> "clk: sun6i: Unify AHB1 clock and fix rate calculation" for the PLL6
> corrections, but I don't think it would cause any issues if it didn't.
>
> Patch 1 adds the sun8i specific MBUS clock driver.
>
> Patch 2 adds proper PLL6 and MBUS clock nodes to the DT, with a dummy
> PLL5 clock node as a parent to MBUS.
>
> Changes since v1:
>   - Added commit message to patch 1
>   - Moved sun8i-mbus clk to separate file

Sorry, missed a multi-line comment. Will send v3 shortly.

>
>
> Cheers
> ChenYu
>
>
> Chen-Yu Tsai (2):
>   clk: sunxi: Add sun8i MBUS clock support
>   ARM: dts: sun8i: Add PLL6 and MBUS clock nodes
>
>  Documentation/devicetree/bindings/clock/sunxi.txt |  1 +
>  arch/arm/boot/dts/sun8i-a23.dtsi                  | 29 ++++++++-
>  drivers/clk/sunxi/Makefile                        |  1 +
>  drivers/clk/sunxi/clk-sun8i-mbus.c                | 76 +++++++++++++++++++++++
>  4 files changed, 105 insertions(+), 2 deletions(-)
>  create mode 100644 drivers/clk/sunxi/clk-sun8i-mbus.c
>
> --
> 2.1.0
>
