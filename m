From: mturquette@linaro.org (Mike Turquette)
Date: Tue, 09 Sep 2014 13:22:05 -0700
Subject: [PATCH 00/11] clk: rockchip: add a cpu clock-type
In-Reply-To: <1409958374-30937-1-git-send-email-heiko@sntech.de>
References: <1409958374-30937-1-git-send-email-heiko@sntech.de>
Message-ID: <20140909202205.19023.4883@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Heiko Stuebner (2014-09-05 16:06:03)
> This series implements cpu frequency-scaling for Rockchip SoCs.
> The whole handling of the armclk frequency changes and therefore
> the implementention is very similar to the recent series for
> Samsung SoCs from Thomas Abraham.

Clock patches look OK to me, with exception of the review comments
pointed out by Doug.

Regards,
Mike

> 
> Tested on a
> - rk3066 Marsboard
> - rk3188 Radxa Rock
> - rk3288 Evaluation board
> 
> If applicable, a good split would be patch 6 in a pullable branch
> of the clock tree so that arm-soc can pull it in, patches 8-11
> through arm-soc and the rest through the clock tree.
> 
> 
> Heiko Stuebner (10):
>   clk: rockchip: fix rk3066 pll status register location
>   clk: rockchip: reparent aclk_cpu_pre to the gpll
>   clk: rockchip: make tightly bound armclk child-clocks read-only
>   clk: rockchip: add new clock-type for the cpuclk
>   clk: rockchip: add binding id for ARMCLK
>   clk: rockchip: switch to using the new cpuclk type for armclk
>   ARM: dts: rockchip: add operating points and armclk references
>   ARM: dts: rockchip: add cpu supplies to boards
>   ARM: rockchip: enable cpufreq-related options
>   ARM: rockchip: add a cpufreq-cpu0 device
> 
> Jianqun (1):
>   clk: rockchip: fix rk3288 pll status register location
> 
>  arch/arm/boot/dts/rk3066a-bqcurie2.dts        |   4 +
>  arch/arm/boot/dts/rk3066a.dtsi                |  12 +-
>  arch/arm/boot/dts/rk3188-radxarock.dts        |   6 +-
>  arch/arm/boot/dts/rk3188.dtsi                 |  15 +-
>  arch/arm/boot/dts/rk3288.dtsi                 |  17 +-
>  arch/arm/mach-rockchip/Kconfig                |   2 +
>  arch/arm/mach-rockchip/rockchip.c             |   7 +
>  drivers/clk/rockchip/Makefile                 |   1 +
>  drivers/clk/rockchip/clk-cpu.c                | 313 ++++++++++++++++++++++++++
>  drivers/clk/rockchip/clk-rk3188.c             | 159 +++++++++++--
>  drivers/clk/rockchip/clk-rk3288.c             |  86 ++++++-
>  drivers/clk/rockchip/clk.c                    |  18 ++
>  drivers/clk/rockchip/clk.h                    |  36 +++
>  include/dt-bindings/clock/rk3188-cru-common.h |   1 +
>  include/dt-bindings/clock/rk3288-cru.h        |   1 +
>  15 files changed, 647 insertions(+), 31 deletions(-)
>  create mode 100644 drivers/clk/rockchip/clk-cpu.c
> 
> -- 
> 2.0.1
> 
