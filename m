From: shawn.guo@freescale.com (Shawn Guo)
Date: Tue, 16 Aug 2011 11:30:56 +0800
Subject: [RFC PATCH v2 03/13] arm/tegra: board-dt: Add AUXDATA for
	tegra-gpio and tegra-pinmux
In-Reply-To: <1313440100-17131-4-git-send-email-swarren@nvidia.com>
References: <1313440100-17131-1-git-send-email-swarren@nvidia.com>
	<1313440100-17131-4-git-send-email-swarren@nvidia.com>
Message-ID: <20110816033056.GE8044@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 15, 2011 at 02:28:10PM -0600, Stephen Warren wrote:
> Add AUXDATA so that Tegra GPIO and pinmux devices that are instantiated
> from device-tree are named consistently with the static platform devices
> in mach-tegra/devices.c. Note that the device-tree file tegra20.dtsi
> already includes a node for the Tegra GPIO controller, whereas the node
> for the Tegra pinmux controller will be added in a subsequent commit.
> 
> Signed-off-by: Stephen Warren <swarren@nvidia.com>
> ---
>  arch/arm/mach-tegra/board-dt.c |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-tegra/board-dt.c b/arch/arm/mach-tegra/board-dt.c
> index 9f47e04..1995b79 100644
> --- a/arch/arm/mach-tegra/board-dt.c
> +++ b/arch/arm/mach-tegra/board-dt.c
> @@ -50,6 +50,8 @@ void seaboard_pinmux_init(void);
>  
>  
>  struct of_dev_auxdata tegra20_auxdata_lookup[] __initdata = {
> +	OF_DEV_AUXDATA("nvidia,tegra20-gpio", TEGRA_GPIO_BASE, "tegra-gpio", NULL),
> +	OF_DEV_AUXDATA("nvidia,tegra20-pinmux", TEGRA_APB_MISC_BASE, "tegra-pinmux", NULL),
>  	OF_DEV_AUXDATA("nvidia,tegra20-sdhci", TEGRA_SDMMC1_BASE, "sdhci-tegra.0", NULL),
>  	OF_DEV_AUXDATA("nvidia,tegra20-sdhci", TEGRA_SDMMC2_BASE, "sdhci-tegra.1", NULL),
>  	OF_DEV_AUXDATA("nvidia,tegra20-sdhci", TEGRA_SDMMC3_BASE, "sdhci-tegra.2", NULL),
> 
The whole auxdata table was primarily added to keep clk API working
with the device name looking up.  Your gpio and pinmux can still work
without this patch, right?  If that's case, I do not think we need to
have this patch just for consistent device name between dt and non-dt.
They are not and they do not have to be.

-- 
Regards,
Shawn
