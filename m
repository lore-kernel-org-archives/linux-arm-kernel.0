From: aisheng.dong@nxp.com (A.s. Dong)
Date: Fri, 16 Mar 2018 10:53:50 +0000
Subject: [PATCH RESEND V3 0/9] clk: add imx7ulp clk support
In-Reply-To: <1518528494-25723-1-git-send-email-aisheng.dong@nxp.com>
References: <1518528494-25723-1-git-send-email-aisheng.dong@nxp.com>
Message-ID: <AM3PR04MB306A4A43EDD03EC199BFD6D80D70@AM3PR04MB306.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shawn & Stephen,

Would you help review this series? It's pending for a long time.

Regards
Dong Aisheng

> -----Original Message-----
> From: Dong Aisheng [mailto:aisheng.dong at nxp.com]
> Sent: Tuesday, February 13, 2018 9:28 PM
> To: linux-clk at vger.kernel.org
> Cc: linux-kernel at vger.kernel.org; linux-arm-kernel at lists.infradead.org;
> sboyd at codeaurora.org; mturquette at baylibre.com; shawnguo at kernel.org;
> Anson Huang <anson.huang@nxp.com>; Jacky Bai <ping.bai@nxp.com>; A.s.
> Dong <aisheng.dong@nxp.com>
> Subject: [PATCH RESEND V3 0/9] clk: add imx7ulp clk support
> 
> This is a resend patch series.
> See the original one from here:
> [PATCH V3 00/10] clk: add imx7ulp clk support
> https://emea01.safelinks.protection.outlook.com/?url=https%3A%2F%2Flk
> ml.org%2Flkml%2F2018%2F1%2F19%2F351&data=02%7C01%7Caisheng.dong
> %40nxp.com%7C2158b9d83b9442c6fa8208d572e5b5f5%7C686ea1d3bc2b4c6f
> a92cd99c5c301635%7C0%7C0%7C636541253280073434&sdata=VQ7%2Fx08X5
> 9AQ8SoYna%2Bw4HnErty3vR5Zwh2dp7FzJqU%3D&reserved=0
> No function changes but remove the last one which is used for the test.
> Rebased against clk-next branch.
> 
> This patch series intends to add imx7ulp clk support.
> 
> i.MX7ULP Clock functions are under joint control of the System Clock
> Generation (SCG) modules, Peripheral Clock Control (PCC) modules, and
> Core Mode Controller (CMC)1 blocks
> 
> The clocking scheme provides clear separation between M4 domain and A7
> domain. Except for a few clock sources shared between two domains, such
> as the System Oscillator clock, the Slow IRC (SIRC), and and the Fast IRC clock
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
>  .../devicetree/bindings/clock/imx7ulp-clock.txt    |  62 ++++++
>  drivers/clk/clk-divider.c                          | 152 ++++++++++++++
>  drivers/clk/clk-fractional-divider.c               |  10 +
>  drivers/clk/imx/Makefile                           |   6 +-
>  drivers/clk/imx/clk-busy.c                         |   2 +-
>  drivers/clk/imx/clk-composite.c                    |  90 ++++++++
>  drivers/clk/imx/clk-fixup-mux.c                    |   2 +-
>  drivers/clk/imx/clk-imx7ulp.c                      | 232 +++++++++++++++++++++
>  drivers/clk/imx/clk-pfdv2.c                        | 207 ++++++++++++++++++
>  drivers/clk/imx/clk-pllv4.c                        | 188 +++++++++++++++++
>  drivers/clk/imx/clk.c                              |  22 ++
>  drivers/clk/imx/clk.h                              |  92 +++++++-
>  include/dt-bindings/clock/imx7ulp-clock.h          | 108 ++++++++++
>  include/linux/clk-provider.h                       |  17 ++
>  14 files changed, 1180 insertions(+), 10 deletions(-)  create mode 100644
> Documentation/devicetree/bindings/clock/imx7ulp-clock.txt
>  create mode 100644 drivers/clk/imx/clk-composite.c  create mode 100644
> drivers/clk/imx/clk-imx7ulp.c  create mode 100644 drivers/clk/imx/clk-
> pfdv2.c  create mode 100644 drivers/clk/imx/clk-pllv4.c  create mode 100644
> include/dt-bindings/clock/imx7ulp-clock.h
> 
> --
> 2.7.4
