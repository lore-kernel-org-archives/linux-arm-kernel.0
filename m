From: mturquette@linaro.org (Mike Turquette)
Date: Thu, 06 Feb 2014 02:08:48 -0800
Subject: [GIT PULL] clk: socfpga: Clock updates for v3.15
In-Reply-To: <1391620344-16882-1-git-send-email-dinguyen@altera.com>
References: <1391620344-16882-1-git-send-email-dinguyen@altera.com>
Message-ID: <20140206100848.22158.15282@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting dinguyen at altera.com (2014-02-05 09:12:24)
> Hi Mike,
> 
> Please consider pull these patch for v3.15.

Taken into clk-next.

Thanks!
Mike

> 
> Thanks,
> Dinh
> 
> The following changes since commit 38dbfb59d1175ef458d006556061adeaa8751b72:
> 
>   Linus 3.14-rc1 (2014-02-02 16:42:13 -0800)
> 
> are available in the git repository at:
> 
>   git://git.rocketboards.org/linux-socfpga-next.git tags/socfpga-clk-for-3.15
> 
> for you to fetch changes up to 5d81b6fc5ee1d904f9e3faab3a80cee36d267136:
> 
>   clk: socfpga: Add a clk-phase property to the "altr,socfpga-gate-clk" (2014-02-05 11:05:09 -0600)
> 
> ----------------------------------------------------------------
> SOCFPGA clk updates for v3.15
> 
> ----------------------------------------------------------------
> Dinh Nguyen (4):
>       clk: socfpga: Map the clk manager base address in the clock driver
>       clk: socfpga: Look for the GPIO_DB_CLK by its offset
>       clk: socfpga: Remove socfpga_init_clocks
>       clk: socfpga: Add a clk-phase property to the "altr,socfpga-gate-clk"
> 
> Steffen Trumtrar (3):
>       clk: socfpga: remove unused field
>       clk: socfpga: fix define typo
>       clk: socfpga: split clk code
> 
>  .../devicetree/bindings/clock/altr_socfpga.txt     |    5 +
>  arch/arm/boot/dts/socfpga.dtsi                     |    1 +
>  arch/arm/mach-socfpga/socfpga.c                    |    5 -
>  drivers/clk/socfpga/Makefile                       |    3 +
>  drivers/clk/socfpga/clk-gate.c                     |  263 ++++++++++++++++
>  drivers/clk/socfpga/clk-periph.c                   |   94 ++++++
>  drivers/clk/socfpga/clk-pll.c                      |  111 +++++++
>  drivers/clk/socfpga/clk.c                          |  326 +-------------------
>  drivers/clk/socfpga/clk.h                          |   57 ++++
>  9 files changed, 546 insertions(+), 319 deletions(-)
>  create mode 100644 drivers/clk/socfpga/clk-gate.c
>  create mode 100644 drivers/clk/socfpga/clk-periph.c
>  create mode 100644 drivers/clk/socfpga/clk-pll.c
>  create mode 100644 drivers/clk/socfpga/clk.h
