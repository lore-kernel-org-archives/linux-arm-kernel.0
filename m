From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 2 Feb 2012 22:43:46 +0800
Subject: [PATCH V2 1/4] pinctrl: add a driver for NVIDIA Tegra
In-Reply-To: <CACRpkda+KCutSFgPwH2Xvd14h0OCrArFGXAidp3n_ZgG28KB5g@mail.gmail.com>
References: <1328130290-17607-1-git-send-email-swarren@nvidia.com>
 <CACRpkda+KCutSFgPwH2Xvd14h0OCrArFGXAidp3n_ZgG28KB5g@mail.gmail.com>
Message-ID: <20120202144344.GI9773@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 02, 2012 at 02:26:54PM +0100, Linus Walleij wrote:
> On Wed, Feb 1, 2012 at 10:04 PM, Stephen Warren <swarren@nvidia.com> wrote:
> 
> > This adds a driver for the Tegra pinmux, and required parameterization
> > data for Tegra20 and Tegra30.
> 
> OK so I've applied this monster patch and the three others,
> 
> the diffstat looks like so:
> 
> git diff --stat v3.3-rc2..HEAD
>  arch/arm/mach-tegra/Kconfig                       |    4 +
>  arch/arm/mach-tegra/Makefile                      |    3 -
>  arch/arm/mach-tegra/board-harmony-pinmux.c        |  362 ++-
>  arch/arm/mach-tegra/board-paz00-pinmux.c          |  362 ++-
>  arch/arm/mach-tegra/board-pinmux.c                |   62 +-
>  arch/arm/mach-tegra/board-pinmux.h                |   39 +-
>  arch/arm/mach-tegra/board-seaboard-pinmux.c       |  442 ++-
>  arch/arm/mach-tegra/board-trimslice-pinmux.c      |  366 ++-
>  arch/arm/mach-tegra/include/mach/pinconf-tegra.h  |   63 +
>  arch/arm/mach-tegra/include/mach/pinmux-tegra20.h |  184 -
>  arch/arm/mach-tegra/include/mach/pinmux-tegra30.h |  320 --
>  arch/arm/mach-tegra/include/mach/pinmux.h         |  302 --
>  arch/arm/mach-tegra/pinmux-tegra20-tables.c       |  244 --
>  arch/arm/mach-tegra/pinmux-tegra30-tables.c       |  376 ---
>  arch/arm/mach-tegra/pinmux.c                      |  987 ------
>  drivers/pinctrl/Kconfig                           |   15 +
>  drivers/pinctrl/Makefile                          |    3 +
>  drivers/pinctrl/pinctrl-tegra.c                   |  559 +++
>  drivers/pinctrl/pinctrl-tegra.h                   |  163 +
>  drivers/pinctrl/pinctrl-tegra20.c                 | 2860 ++++++++++++++++
>  drivers/pinctrl/pinctrl-tegra30.c                 | 3726 +++++++++++++++++++++
>  21 files changed, 8482 insertions(+), 2960 deletions(-)
> 
> It's still pretty big, adding some 6000 lines in sum total, but you've made
> your case for having all information about the hardware in the driver
> quite clear so I've not got much more to say. Short story: the driver knows
> all about what the hardware can do, and the platform data or device
> tree will decide how these capabilities are employed on a certain
> system.
> 
> What is nice is to have this out of the ARM tree and under pinctrl
> subsystem control.
> 
Heh, omap and imx have a much big SoC family than tegra.  Imaging what
if omap and imx do the same thing here, probably will move Linus'
attention from arch/arm/ to drivers/pinctrl :)

Fortunately, it seems omap and imx will try to get those huge data out
of the driver/kernel.

-- 
Regards,
Shawn
