From: pgaikwad@nvidia.com (Prashant Gaikwad)
Date: Wed, 25 Jul 2012 12:11:16 +0530
Subject: [PATCH] ARM: tegra: turn on UART A clock at boot
In-Reply-To: <1343170200-28228-1-git-send-email-swarren@wwwdotorg.org>
References: <1343170200-28228-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <500F950C.4070407@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 25 July 2012 04:20 AM, Stephen Warren wrote:
> From: Stephen Warren<swarren@nvidia.com>
>
> Some boards use UART D for the main serial console, and some use UART A.
> UART D's clock is listed in board-dt-tegra20.c's clock table, whereas
> UART A's clock is not. This causes the clock code to think UART A's
> clock is unsed. The common clock framework turns off unused clocks at
> boot time. This makes the kernel appear to hang. Add UART A's clock into
> the clock table to prevent this. Eventually, this requirement should be
> handled by the UART driver, and/or properties in a board-specific device
> tree file.
>
> Signed-off-by: Stephen Warren<swarren@nvidia.com>

Thanks Stephen!!

Verified on Cardhu and Ventana with Common clock framework patches.

> ---
>   arch/arm/mach-tegra/board-dt-tegra20.c |    1 +
>   1 files changed, 1 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-tegra/board-dt-tegra20.c b/arch/arm/mach-tegra/board-dt-tegra20.c
> index 70a19a9..5daffd5 100644
> --- a/arch/arm/mach-tegra/board-dt-tegra20.c
> +++ b/arch/arm/mach-tegra/board-dt-tegra20.c
> @@ -71,6 +71,7 @@ struct of_dev_auxdata tegra20_auxdata_lookup[] __initdata = {
>
>   static __initdata struct tegra_clk_init_table tegra_dt_clk_init_table[] = {
>   	/* name		parent		rate		enabled */
> +	{ "uarta",	"pll_p",	216000000,	true },
>   	{ "uartd",	"pll_p",	216000000,	true },
>   	{ "usbd",	"clk_m",	12000000,	false },
>   	{ "usb2",	"clk_m",	12000000,	false },
