From: mturquette@linaro.org (Mike Turquette)
Date: Mon, 29 Sep 2014 23:43:48 -0700
Subject: [GIT PULL] TI clock driver changes for 3.18 merge window
In-Reply-To: <54298515.3040201@ti.com>
References: <54298515.3040201@ti.com>
Message-ID: <20140930064348.19023.42102@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Tero Kristo (2014-09-29 09:13:09)
> Hi Mike,
> 
> The following changes since commit 7d1311b93e58ed55f3a31cc8f94c4b8fe988a2b9:
> 
>    Linux 3.17-rc1 (2014-08-16 10:40:26 -0600)
> 
> are available in the git repository at:
> 
>    git at github.com:t-kristo/linux-pm.git for-v3.18/ti-clk-driver
> 
> for you to fetch changes up to 04ed831f224d4553682f48e1b4a6b68f2622b68e:
> 
>    clk: ti: dra7-atl-clock: Mark the device as pm_runtime_irq_safe 
> (2014-09-29 11:51:14 +0300)

Pulled!

Thanks,
Mike

> 
> ----------------------------------------------------------------
> Mostly fixes, except for the of_clk_init() change for the clock driver. 
> Boot tested on pretty much every board I have access to, also merge 
> tested with latest master to see if there are any conflicts with anything.
> 
> ----------------------------------------------------------------
> Behan Webster (1):
>        clk: ti: LLVMLinux: Move __init outside of type definition
> 
> Peter Ujfalusi (1):
>        clk: ti: dra7-atl-clock: Mark the device as pm_runtime_irq_safe
> 
> Sebastian Andrzej Siewior (1):
>        clk: ti: consider the fact that of_clk_get() might return an error
> 
> Tero Kristo (2):
>        clk: ti: change clock init to use generic of_clk_init
>        clk: ti: dra7-atl-clock: fix a memory leak
> 
>   arch/arm/mach-omap2/io.c         |   12 +++++--
>   arch/arm/mach-omap2/prm_common.c |    2 --
>   drivers/clk/ti/clk-dra7-atl.c    |    2 ++
>   drivers/clk/ti/clk.c             |   68 
> ++++++++++++++++++++++++--------------
>   drivers/clk/ti/clockdomain.c     |    5 +++
>   drivers/clk/ti/divider.c         |    4 +--
>   include/linux/clk/ti.h           |    1 +
>   7 files changed, 63 insertions(+), 31 deletions(-)
