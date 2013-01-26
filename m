From: rjw@sisk.pl (Rafael J. Wysocki)
Date: Sat, 26 Jan 2013 22:52:42 +0100
Subject: [PATCH v2 0/3] Kirkwoode cpufreq driver
In-Reply-To: <1359215039-2848-1-git-send-email-andrew@lunn.ch>
References: <1359215039-2848-1-git-send-email-andrew@lunn.ch>
Message-ID: <3759655.fLV8aUUe7v@vostro.rjw.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday, January 26, 2013 04:43:56 PM Andrew Lunn wrote:
> This patchset adds a cpufreq driver for Marvell Kirkwood SoCs.
> 
> The changes to kirkwood_defconfig enable it and set the default
> governor to ondemand.
> 
> Changes since v1:
> 
> tabify Kconfig.arm entry
> Sort order of include files
> Remove some unnecassary include files
> Reformat multiline comment to be coding style conform.
> 
> Andrew Lunn (3):
>   cpufreq: kirkwood: Add a cpufreq driver for Marvell Kirkwood SoCs
>   arm: kirkwood: Instantiate cpufreq driver
>   arm: kirkwood: Enable cpufreq and ondemand on kirkwood_defconfig

If you want me to take this, it'll need some ACKs from the clk people
and arm-soc maintainers at least.

An ACK from Viresh would be welcome too.

Thanks,
Rafael


>  arch/arm/Kconfig                                  |    1 +
>  arch/arm/configs/kirkwood_defconfig               |    3 +
>  arch/arm/mach-kirkwood/board-dt.c                 |    3 +-
>  arch/arm/mach-kirkwood/common.c                   |   23 ++
>  arch/arm/mach-kirkwood/common.h                   |    2 +
>  arch/arm/mach-kirkwood/include/mach/bridge-regs.h |    2 +
>  drivers/clk/mvebu/clk-gating-ctrl.c               |    1 +
>  drivers/cpufreq/Kconfig.arm                       |    6 +
>  drivers/cpufreq/Makefile                          |    1 +
>  drivers/cpufreq/kirkwood-cpufreq.c                |  271 +++++++++++++++++++++
>  10 files changed, 312 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/cpufreq/kirkwood-cpufreq.c
> 
> 
-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
