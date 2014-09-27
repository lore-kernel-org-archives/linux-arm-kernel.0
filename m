From: mturquette@linaro.org (Mike Turquette)
Date: Sat, 27 Sep 2014 12:51:10 -0700
Subject: [GIT PULL] ARM: rockchip: add cpuclk handling - clock-tree part
In-Reply-To: <2910342.TyvTvsiepE@phil>
References: <2910342.TyvTvsiepE@phil>
Message-ID: <20140927195110.19023.20879@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Heiko St?bner (2014-09-27 09:13:33)
> Hi Mike,
> 
> as requested yesterday here is the cpuclk series as pull request, based on
> your clk-next branch.
> 
> I've put the clock-id addition into a separate branch, so that it could
> also get pulled into arm-soc ... if we get another kernel-rc.
> 
> So if still possible, please pull the following.

Pulled!

Regards,
Mike

> 
> 
> Thanks
> Heiko
> 
> 
> The following changes since commit b52f4914f3be3ff50e7308e3ce03a2ce71195ecc:
> 
>   asm-generic: COMMON_CLK defines __clk_{get,put} (2014-09-25 18:00:45 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip.git tags/v3.18-rockchip-cpuclk
> 
> for you to fetch changes up to 0e5bdb3f9fa5c2bd4452c258de78122ef15f62d6:
> 
>   clk: rockchip: switch to using the new cpuclk type for armclk (2014-09-27 17:57:46 +0200)
> 
> ----------------------------------------------------------------
> CPU clock handling for Rockchip SoCs
> 
> ----------------------------------------------------------------
> Doug Anderson (1):
>       clk: rockchip: change pll rate without a clk-notifier
> 
> Heiko Stuebner (7):
>       clk: rockchip: add binding id for ARMCLK
>       Merge branch 'v3.18-next/armclkid' into v3.18-next/cpuclk
>       clk: rockchip: fix rk3066 pll status register location
>       clk: rockchip: reparent aclk_cpu_pre to the gpll
>       clk: rockchip: make tightly bound armclk child-clocks read-only
>       clk: rockchip: add new clock-type for the cpuclk
>       clk: rockchip: switch to using the new cpuclk type for armclk
> 
> Jianqun (1):
>       clk: rockchip: fix rk3288 pll status register location
> 
>  drivers/clk/rockchip/Makefile                 |   1 +
>  drivers/clk/rockchip/clk-cpu.c                | 329 ++++++++++++++++++++++++++
>  drivers/clk/rockchip/clk-pll.c                |  63 +----
>  drivers/clk/rockchip/clk-rk3188.c             | 161 +++++++++++--
>  drivers/clk/rockchip/clk-rk3288.c             |  93 +++++++-
>  drivers/clk/rockchip/clk.c                    |  21 ++
>  drivers/clk/rockchip/clk.h                    |  37 +++
>  include/dt-bindings/clock/rk3188-cru-common.h |   1 +
>  include/dt-bindings/clock/rk3288-cru.h        |   1 +
>  9 files changed, 629 insertions(+), 78 deletions(-)
>  create mode 100644 drivers/clk/rockchip/clk-cpu.c
> 
