From: mturquette@linaro.org (Mike Turquette)
Date: Sun, 29 Dec 2013 13:42:26 -0800
Subject: [GIT PULL] Allwinner sunXi clock changes for 3.14
In-Reply-To: <52BF4146.7060403@elopez.com.ar>
References: <52BF4146.7060403@elopez.com.ar>
Message-ID: <20131229214226.12054.10056@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Emilio L?pez (2013-12-28 13:23:18)
> Hi Mike,
> 
> I made this pull with the clk parts of my series, as well as a patch 
> from Chen-Yu Tsai adding support for output clocks on A20. Please pull 
> or let me know if I should fix anything, as it's my first time sending 
> out pull requests.

Everything looks good and I've taken this into clk-next. The only
improvement I can suggest for future pull requests is to use signed
tags.

Regards,
Mike

> 
> Cheers,
> 
> Emilio
> 
> ----8<----
> 
> The following changes since commit 0903ea60173fab226a867ceb080b2e0269a6c975:
> 
>    clk: add accuracy support for fixed clock (2013-12-22 23:14:28 -0800)
> 
> are available in the git repository at:
> 
>    https://bitbucket.org/emiliolopez/linux.git tags/sunxi-clk-3.14-for-mike
> 
> for you to fetch changes up to 6f86341726cbec1921e925fd54a10c5b58e6f9f1:
> 
>    clk: sunxi: Allwinner A20 output clock support (2013-12-28 17:14:21 
> -0300)
> 
> ----------------------------------------------------------------
> Allwinner sunXi SoCs clock changes
> 
> This contains the clk driver parts of the "[PATCH v3 00/13] clk: sunxi:
> add PLL5 and PLL6 support" series. It adds support for PLL4/5/6 and
> mod0 clocks on most sunxi platforms. Additionally, it contains "[PATCH
> 1/4] clk: sunxi: Allwinner A20 output clock support" (v2) from Chen-Yu
> Tsai, which adds support for output clocks present on A20.
> 
> ----------------------------------------------------------------
> Chen-Yu Tsai (1):
>        clk: sunxi: Allwinner A20 output clock support
> 
> Emilio L?pez (7):
>        clk: sunxi: register factors clocks behind composite
>        clk: sunxi: clean the magic number of mux parents
>        clk: sunxi: add gating support to PLL1
>        clk: sunxi: make factors_clk_setup return the clock it registers
>        clk: sunxi: add PLL5 and PLL6 support
>        clk: sunxi: mod0 support
>        clk: sunxi: support better factor DT nodes
> 
>   Documentation/devicetree/bindings/clock/sunxi.txt |  10 +-
>   drivers/clk/sunxi/clk-factors.c                   |  63 +---
>   drivers/clk/sunxi/clk-factors.h                   |  16 +-
>   drivers/clk/sunxi/clk-sunxi.c                     | 435 
> +++++++++++++++++++++-
>   4 files changed, 445 insertions(+), 79 deletions(-)
