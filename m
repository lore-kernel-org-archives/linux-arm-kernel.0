From: mturquette@linaro.org (Mike Turquette)
Date: Wed, 01 Oct 2014 13:42:46 -0700
Subject: [GIT PULL] some more Rockchip clock changes for 3.18
In-Reply-To: <4728187.K4l757xGSs@phil>
References: <4728187.K4l757xGSs@phil>
Message-ID: <20141001204246.4379.47841@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Heiko St?bner (2014-10-01 06:11:14)
> Hi Mike,
> 
> here is a second pull request for clock changes.
> 
> For the reset handling there was a sort of change in plans. Instead of the
> whole thing going through the -mm tree, there is now an immutable branch at
> 
>         git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git tags/restart-handler-for-v3.18
> 
> providing the core restart changes for trees using it. So this pull includes
> this branch from Guenter as well as the rockchip restart support.
> 
> After confering with Tomasz, we agreed that for simplicity I'll also take
> the s3c24xx reset change with this, which doesn't produce any conflicts.
> 
> Apart from the restart handling, only a small patch enabling parent-rate
> setting for i2s clocks on rk3288 is added.
> 
> 
> The pull request is based on the previous one for the cpuclk handling, so
> should apply cleanly to your clk-next.
> 
> So please pull
> 
> 
> The following changes since commit 0e5bdb3f9fa5c2bd4452c258de78122ef15f62d6:
> 
>   clk: rockchip: switch to using the new cpuclk type for armclk (2014-09-27 17:57:46 +0200)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip.git tags/v3.18-rockchip-clk2

Pulled!

Regards,
Mike

> 
> for you to fetch changes up to e317c19470f6d690122519bf9ed1c9f21ea11906:
> 
>   clk: samsung: register restart handlers for s3c2412 and s3c2443 (2014-10-01 14:14:46 +0200)
> 
> ----------------------------------------------------------------
> Allow parent rate changes for i2s on rk3288
> and rockchip as well as s3c24xx restart handlers.
> 
> ----------------------------------------------------------------
> Guenter Roeck (8):
>       kernel: add support for kernel restart handler call chain
>       power/restart: call machine_restart instead of arm_pm_restart
>       arm64: support restart through restart handler call chain
>       arm: support restart through restart handler call chain
>       watchdog: moxart: register restart handler with kernel restart handler
>       watchdog: alim7101: register restart handler with kernel restart handler
>       watchdog: sunxi: register restart handler with kernel restart handler
>       arm/arm64: unexport restart handlers
> 
> Heiko Stuebner (1):
>       Merge tag 'tags/restart-handler-for-v3.18' into v3.18-next/cpuclk
> 
> Heiko St?bner (2):
>       clk: rockchip: add restart handler
>       clk: samsung: register restart handlers for s3c2412 and s3c2443
> 
> Jianqun (1):
>       clk: rockchip: rk3288: i2s_frac adds flag to set parent's rate
> 
>  arch/arm/kernel/process.c              | 12 +++--
>  arch/arm64/kernel/process.c            |  3 +-
>  drivers/clk/rockchip/clk-rk3188.c      |  2 +
>  drivers/clk/rockchip/clk-rk3288.c      | 10 +++--
>  drivers/clk/rockchip/clk.c             | 25 +++++++++++
>  drivers/clk/rockchip/clk.h             |  1 +
>  drivers/clk/samsung/clk-s3c2412.c      | 29 ++++++++++++
>  drivers/clk/samsung/clk-s3c2443.c      | 19 ++++++++
>  drivers/power/reset/restart-poweroff.c |  3 +-
>  drivers/watchdog/alim7101_wdt.c        | 42 +++++++++++++-----
>  drivers/watchdog/moxart_wdt.c          | 32 +++++++++-----
>  drivers/watchdog/sunxi_wdt.c           | 31 ++++++++-----
>  include/linux/reboot.h                 |  3 ++
>  kernel/reboot.c                        | 81 ++++++++++++++++++++++++++++++++++
>  14 files changed, 247 insertions(+), 46 deletions(-)
> 
