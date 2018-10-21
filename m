From: aisheng.dong@nxp.com (A.s. Dong)
Date: Sun, 21 Oct 2018 13:15:07 +0000
Subject: [PATCH RESEND V4 0/9] clk: add imx7ulp clk support
In-Reply-To: <1540127173-21346-1-git-send-email-aisheng.dong@nxp.com>
References: <1540127173-21346-1-git-send-email-aisheng.dong@nxp.com>
Message-ID: <AM0PR04MB4211576EF2FE906A6B0C3F1680FB0@AM0PR04MB4211.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stephen,

In case you might miss to queue this series into your review list, so I resend this series again.
This series actually has been pending for a couple of months without comments.
Hopefully you could help find some time to handle it when you're free.

Thanks

Regards
Dong Aisheng

> -----Original Message-----
> From: A.s. Dong
> Sent: Sunday, October 21, 2018 9:11 PM
> To: linux-clk at vger.kernel.org
> Cc: linux-kernel at vger.kernel.org; linux-arm-kernel at lists.infradead.org;
> sboyd at kernel.org; mturquette at baylibre.com; shawnguo at kernel.org; Anson
> Huang <anson.huang@nxp.com>; Jacky Bai <ping.bai@nxp.com>; dl-linux-imx
> <linux-imx@nxp.com>; A.s. Dong <aisheng.dong@nxp.com>
> Subject: [PATCH RESEND V4 0/9] clk: add imx7ulp clk support
> 
> This is a rebased version of below patch series against latest clk tree.
> [PATCH RESEND V3 0/9] clk: add imx7ulp clk support
> https://lkml.org/lkml/2018/3/16/310
> 
> It only updates the license to SPDX format as well as a minor fix of pllv4.
> 
> This patch series intends to add imx7ulp clk support.
> 
> i.MX7ULP Clock functions are under joint control of the System Clock
> Generation (SCG) modules, Peripheral Clock Control (PCC) modules, and Core
> Mode Controller (CMC)1 blocks
> 
> The clocking scheme provides clear separation between M4 domain and A7
> domain. Except for a few clock sources shared between two domains, such as
> the System Oscillator clock, the Slow IRC (SIRC), and and the Fast IRC clock
> (FIRCLK), clock sources and clock management are separated and contained
> within each domain.
> 
> M4 clock management consists of SCG0, PCC0, PCC1, and CMC0 modules.
> A7 clock management consists of SCG1, PCC2, PCC3, and CMC1 modules.
> 
> Note: this series only adds A7 clock domain support as M4 clock domain will
> be handled by M4 seperately.
> 
> Change Log:
> v3->v4:
>  * update after changing scg and pcc into separete nodes according to
>    Rob's suggestion
> v2->v3:
>  * Patch 1 changed on: 1) split normal and gate ops 2) fix the possible racy
>    Others no changes.
> 
> v1->v2:
>  * add enable/disable for the type of CLK_DIVIDER_ZERO_GATE dividers
>  * use clk_hw apis to register clocks
>  * use of_clk_add_hw_provider
>  * split the clocks register process into two parts: early part for possible
>    timers clocks registered by CLK_OF_DECLARE_DRIVER and the later part for
>    the left normal peripheral clocks registered by a platform driver.
> 
> Dong Aisheng (9):
>   clk: clk-divider: add CLK_DIVIDER_ZERO_GATE clk support
>   clk: fractional-divider: add CLK_FRAC_DIVIDER_ZERO_BASED flag support
>   clk: imx: add pllv4 support
>   clk: imx: add pfdv2 support
>   clk: imx: add composite clk support
>   dt-bindings: clock: add imx7ulp clock binding doc
>   clk: imx: make mux parent strings const
>   clk: imx: implement new clk_hw based APIs
>   clk: imx: add imx7ulp clk driver
> 
>  .../devicetree/bindings/clock/imx7ulp-clock.txt    |  87 +++++++++
>  drivers/clk/clk-divider.c                          | 152
> +++++++++++++++
>  drivers/clk/clk-fractional-divider.c               |  10 +
>  drivers/clk/imx/Makefile                           |   6 +-
>  drivers/clk/imx/clk-busy.c                         |   2 +-
>  drivers/clk/imx/clk-composite.c                    |  85 +++++++++
>  drivers/clk/imx/clk-fixup-mux.c                    |   2 +-
>  drivers/clk/imx/clk-imx7ulp.c                      | 209
> +++++++++++++++++++++
>  drivers/clk/imx/clk-pfdv2.c                        | 201
> ++++++++++++++++++++
>  drivers/clk/imx/clk-pllv4.c                        | 182
> ++++++++++++++++++
>  drivers/clk/imx/clk.c                              |  22 +++
>  drivers/clk/imx/clk.h                              |  92 ++++++++-
>  include/dt-bindings/clock/imx7ulp-clock.h          | 109 +++++++++++
>  include/linux/clk-provider.h                       |  17 ++
>  14 files changed, 1166 insertions(+), 10 deletions(-)  create mode 100644
> Documentation/devicetree/bindings/clock/imx7ulp-clock.txt
>  create mode 100644 drivers/clk/imx/clk-composite.c  create mode 100644
> drivers/clk/imx/clk-imx7ulp.c  create mode 100644
> drivers/clk/imx/clk-pfdv2.c  create mode 100644 drivers/clk/imx/clk-pllv4.c
> create mode 100644 include/dt-bindings/clock/imx7ulp-clock.h
> 
> --
> 2.7.4
