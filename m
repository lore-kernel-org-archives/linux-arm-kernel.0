From: swarren@nvidia.com (Stephen Warren)
Date: Wed, 10 Aug 2011 13:39:58 -0700
Subject: [PATCH V4] ARM: tegra: paz00: add clocks required for usb
	operation
In-Reply-To: <201108101921.58149.marc.dietrich@ap.physik.uni-giessen.de>
References: <201108101921.58149.marc.dietrich@ap.physik.uni-giessen.de>
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF04A068758D@HQMAIL01.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Marc Dietrich wrote at Wednesday, August 10, 2011 11:22 AM:
> These clocks are required for usb operation. pll_p_out4 needs to be set
> to 24 MHz. The other clocks default to "off" in order to save some energy.
> 
> Signed-off-by: Marc Dietrich <marvin24@gmx.de>

Acked-by: Stephen Warren <swarren@nvidia.com>

Given the rest of the thread, this is fine for now. We can address any
deficiencies in the bus clock and clk_m parenting when it's addressed
globally for all boards later.

> diff --git a/arch/arm/mach-tegra/board-paz00.c b/arch/arm/mach-tegra/board-paz00.c
> index 45111f6..cde36dc 100644
> --- a/arch/arm/mach-tegra/board-paz00.c
> +++ b/arch/arm/mach-tegra/board-paz00.c
> @@ -145,6 +145,12 @@ static __initdata struct tegra_clk_init_table paz00_clk_init_table[] = {
>  	/* name		parent		rate		enabled */
>  	{ "uarta",	"pll_p",	216000000,	true },
>  	{ "uartd",	"pll_p",	216000000,	true },
> +
> +	{ "pll_p_out4",	"pll_p",	24000000,	true },
> +	{ "usbd",	"clk_m",	12000000,	false },
> +	{ "usb2",	"clk_m",	12000000,	false },
> +	{ "usb3",	"clk_m",	12000000,	false },
> +
>  	{ NULL,		NULL,		0,		0},
>  };
> 
> --
> 1.7.4.1

-- 
nvpublic
