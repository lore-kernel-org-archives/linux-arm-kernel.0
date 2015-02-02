From: mturquette@linaro.org (Mike Turquette)
Date: Mon, 02 Feb 2015 15:15:14 -0800
Subject: pull request for Tegra clock updates for 3.20
In-Reply-To: <20150202151418.GA15776@tbergstrom-lnx.Nvidia.com>
References: <20150202151418.GA15776@tbergstrom-lnx.Nvidia.com>
Message-ID: <20150202231514.421.5790@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Peter De Schrijver (2015-02-02 07:14:18)
> Hi Mike,
> 
> A few bug fixes and support for Tegra132 clocks.

Hi Peter,

Pulled into clk-next, but...

-rc7 is pretty late for sending a PR. Please try to send it out earlier
if possible next time, but I understand that this happens from time to
time.

Also this PR was based on -rc7, which is clearly ahead of clk-next. In
fact clk-next is often based on -rc1. While only a minor inconvenience
for me to merge clk-next into -rc7 before pulling your code, its a bit
nicer to send the PR against a common baseline like -rc1.

This will show up in linux-next after a couple of days since it is a bit
too much churn and I'm trying to make sure the problems in the clk tree
from the last several days are truly sorted before introducing new code.

Regards,
Mike

> 
> Thanks,
> 
> Peter.
> 
> The following changes since commit e36f014edff70fc02b3d3d79cead1d58f289332e:
> 
>   Linux 3.19-rc7 (2015-02-01 20:07:21 -0800)
> 
> are available in the git repository at:
> 
>   git://nv-tegra.nvidia.com/user/pdeschrijver/linux.git tags/tegra-clk-3.20
> 
> for you to fetch changes up to b270491eb9a033a1ab6c66e778c9dd3e3a4f7639:
> 
>   clk: tegra: Define PLLD_DSI and remove dsia(b)_mux (2015-02-02 16:22:34 +0200)
> 
> ----------------------------------------------------------------
> Tegra clock fixes for 3.20
> 
> ----------------------------------------------------------------
> Andrew Bresticker (1):
>       clk: tegra: SDMMC controllers are on APB
> 
> Mark Zhang (1):
>       clk: tegra: Define PLLD_DSI and remove dsia(b)_mux
> 
> Paul Walmsley (2):
>       clk: tegra: split Tegra124 clock header file
>       clk: tegra: Add support for the Tegra132 CAR IP block
> 
> Peter De Schrijver (2):
>       clk: tegra: make tegra_clocks_apply_init_table() arch_initcall
>       clk: tegra: Update binding doc for Tegra132
> 
> Sean Paul (1):
>       clk: tegra124: Add init data for dsi lp clocks
> 
> Tomeu Vizoso (1):
>       clk: tegra: Fix order of arguments in WARN
> 
>  .../bindings/clock/nvidia,tegra124-car.txt         |  10 +-
>  arch/arm/mach-tegra/tegra.c                        |   2 -
>  drivers/clk/tegra/Makefile                         |   1 +
>  drivers/clk/tegra/clk-id.h                         |   2 -
>  drivers/clk/tegra/clk-pll.c                        |  18 +-
>  drivers/clk/tegra/clk-tegra-periph.c               |  18 +-
>  drivers/clk/tegra/clk-tegra114.c                   |  10 +-
>  drivers/clk/tegra/clk-tegra124.c                   | 168 ++++++++--
>  drivers/clk/tegra/clk.c                            |   7 +-
>  include/dt-bindings/clock/tegra124-car-common.h    | 345 +++++++++++++++++++++
>  include/dt-bindings/clock/tegra124-car.h           | 345 +--------------------
>  include/linux/clk/tegra.h                          |   2 -
>  12 files changed, 532 insertions(+), 396 deletions(-)
>  create mode 100644 include/dt-bindings/clock/tegra124-car-common.h
