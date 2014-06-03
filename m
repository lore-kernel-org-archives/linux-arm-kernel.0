From: mturquette@linaro.org (Mike Turquette)
Date: Tue, 03 Jun 2014 10:41:20 -0700
Subject: [GIT PULL] Allwinner sunXi clock changes for 3.16
In-Reply-To: <538B7B6C.3020601@elopez.com.ar>
References: <538B7B6C.3020601@elopez.com.ar>
Message-ID: <20140603174120.10062.16229@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Emilio L?pez (2014-06-01 12:13:48)
> Hi Mike,
> 
> Here is the sunxi clocks pull for 3.16. As you probably saw during the 
> cycle, this mostly contains improved A31 support and a bit of 
> housekeeping. Please note that this pull does *not* contain the MMC 
> clock patches Hans sent, as you merged those yourself on clk-next

Hi Emilio,

-rc8 is pretty late for me to take this in under normal circumstances,
and since the merge window opened early this time I will defer taking
this pull request in until 3.16-rc1 is released. It'll be one of the
first things applied to the new clk-next.

Regards,
Mike

> 
> Cheers,
> 
> Emilio
> 
> --->8---
> 
> The following changes since commit c9eaa447e77efe77b7fa4c953bd62de8297fd6c5:
> 
>    Linux 3.15-rc1 (2014-04-13 14:18:35 -0700)
> 
> are available in the git repository at:
> 
>    https://bitbucket.org/emiliolopez/linux.git tags/sunxi-clk-for-3.16
> 
> for you to fetch changes up to 4da7e86418af722793610e57cee9d3e73d16ed58:
> 
>    clk: sunxi: document PRCM clock compatible strings (2014-05-15 
> 12:20:14 -0300)
> 
> ----------------------------------------------------------------
> Allwinner sunXi SoCs clock changes
> 
> This pull contains some new code to add support for A31 clocks by Maxime
> and Boris. It also reworks the driver a bit to avoid having a huge
> single file when we have a full folder for ourselves, and separating
> different functional units makes sense.
> 
> ----------------------------------------------------------------
> Boris BREZILLON (2):
>        clk: sunxi: add PRCM (Power/Reset/Clock Management) clks support
>        clk: sunxi: document PRCM clock compatible strings
> 
> Emilio L?pez (1):
>        clk: sunxi: document new A31 USB clock compatible
> 
> Maxime Ripard (7):
>        clk: sunxi: Implement A31 USB clock
>        clk: sunxi: Remove calls to clk_put
>        clk: sunxi: Move the 24M oscillator to a file of its own
>        clk: sunxi: Move the GMAC clock to a file of its own
>        clk: sunxi: Rework clock protection code
>        clk: sun6i: Protect CPU clock
>        clk: sun6i: Protect SDRAM gating bit
> 
>   Documentation/devicetree/bindings/clock/sunxi.txt |   4 +++
>   drivers/clk/sunxi/Makefile                        |   4 +++
>   drivers/clk/sunxi/clk-a10-hosc.c                  |  73 
> +++++++++++++++++++++++++++++++++++++++++
>   drivers/clk/sunxi/clk-a20-gmac.c                  | 119 
> ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>   drivers/clk/sunxi/clk-sun6i-apb0-gates.c          |  99 
> +++++++++++++++++++++++++++++++++++++++++++++++++++++++
>   drivers/clk/sunxi/clk-sun6i-apb0.c                |  77 
> +++++++++++++++++++++++++++++++++++++++++++
>   drivers/clk/sunxi/clk-sun6i-ar100.c               | 233 
> ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>   drivers/clk/sunxi/clk-sunxi.c                     | 239 
> +++++++++++++++++++++++++++++-------------------------------------------------------------------------------------------------------
>   8 files changed, 661 insertions(+), 187 deletions(-)
>   create mode 100644 drivers/clk/sunxi/clk-a10-hosc.c
>   create mode 100644 drivers/clk/sunxi/clk-a20-gmac.c
>   create mode 100644 drivers/clk/sunxi/clk-sun6i-apb0-gates.c
>   create mode 100644 drivers/clk/sunxi/clk-sun6i-apb0.c
>   create mode 100644 drivers/clk/sunxi/clk-sun6i-ar100.c
