From: josephl@nvidia.com (Joseph Lo)
Date: Tue, 8 Oct 2013 17:01:09 +0800
Subject: [PATCH 0/4] ARM: tegra: add CPU hot-plug and idle support for
 Tegra124
In-Reply-To: <1381220587-29697-1-git-send-email-josephl@nvidia.com>
References: <1381220587-29697-1-git-send-email-josephl@nvidia.com>
Message-ID: <1381222869.10568.6.camel@jlo-ubuntu-64.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2013-10-08 at 16:23 +0800, Joseph Lo wrote:
> The CPU hot-plug and idle function for Tegra124 was identical to Tegra114,
> so we share the driver with it.
> 
Because this series touches common CPU resume function across Tegra
chips, I forgot to mention.

Verified on Seaboard, Cardhu, Dalmore and Venice2 and with THUMB2_KERNEL
as well.

> Note:
> This patch series depends on the patch series below.
> * [PATCH 0/5] Tegra124 clock support
> * [PATCH V2 0/6] ARM: tegra: basic support for Tegra124 SoC
> * [PATCH] ARM: tegra: add clock properties for devices of Tegra124
> 
> Joseph Lo (4):
>   clk: tegra124: add wait_for_reset and disable_clock for
>     tegra_cpu_car_ops
>   ARM: tegra: CPU hotplug support for Tegra124
>   ARM: tegra: make tegra_resume can work with current and later chips
>   ARM: tegra: enable CPU idle for Tegra124
> 
>  arch/arm/mach-tegra/Makefile        |  4 ++++
>  arch/arm/mach-tegra/cpuidle.c       |  4 +++-
>  arch/arm/mach-tegra/hotplug.c       |  2 ++
>  arch/arm/mach-tegra/reset-handler.S |  9 +++------
>  drivers/clk/tegra/clk-tegra124.c    | 26 ++++++++++++++++++++++++++
>  5 files changed, 38 insertions(+), 7 deletions(-)
> 
