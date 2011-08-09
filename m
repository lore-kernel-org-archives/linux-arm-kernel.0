From: swarren@nvidia.com (Stephen Warren)
Date: Tue, 9 Aug 2011 11:35:45 -0700
Subject: [PATCH 4/5 V2] ARM: tegra: paz00: add clocks required for usb
	operation
In-Reply-To: <201108092029.17546.marvin24@gmx.de>
References: <cover.1312735430.git.marvin24@gmx.de>
	<76f31183766f1edce1230a925ced1c986dbdf028.1312742856.git.marvin24@gmx.de>
	<201108092029.17546.marvin24@gmx.de>
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF04A0687335@HQMAIL01.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Marc Dietrich wrote at Tuesday, August 09, 2011 12:29 PM:
> These clocks are required for usb operation.
> ---
>  arch/arm/mach-tegra/board-paz00.c |    6 ++++++
>  1 files changed, 6 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-tegra/board-paz00.c b/arch/arm/mach-tegra/board-paz00.c
> index 45111f6..89a3dda 100644
> --- a/arch/arm/mach-tegra/board-paz00.c
> +++ b/arch/arm/mach-tegra/board-paz00.c
> @@ -145,6 +145,12 @@ static __initdata struct tegra_clk_init_table paz00_clk_init_table[] = {
>  	/* name		parent		rate		enabled */
>  	{ "uarta",	"pll_p",	216000000,	true },
>  	{ "uartd",	"pll_p",	216000000,	true },
> +
> +	{ "pll_p_out4",	"pll_p",	24000000,	true },

Do you need the pll_p_out4 entry? What's that driving? Check in
/sys/kernel/debug/clock/clock_tree (/sys/kernel/debug is debugfs).

-- 
nvpublic
