From: marvin24@gmx.de (Marc Dietrich)
Date: Tue, 8 Mar 2011 23:12:06 +0100
Subject: [PATCH 2/3] ARM: tegra: harmony: initialize the TPS65862 PMIC
In-Reply-To: <4ade6d195fff78271085eafb0a99de3be8beb426.1299588456.git.mike@compulab.co.il>
References: <cover.1299588456.git.mike@compulab.co.il>
	<4ade6d195fff78271085eafb0a99de3be8beb426.1299588456.git.mike@compulab.co.il>
Message-ID: <201103082312.06911.marvin24@gmx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mike,

Am Dienstag 08 M?rz 2011, um 13:58:58 schrieb Mike Rapoport:
> Signed-off-by: Mike Rapoport <mike@compulab.co.il>
> ---
>  arch/arm/mach-tegra/Makefile              |    1 +
>  arch/arm/mach-tegra/board-harmony-power.c |  161 +++++++++++++++++++++++++++++
>  arch/arm/mach-tegra/board-harmony.c       |    1 +
>  arch/arm/mach-tegra/board-harmony.h       |    1 +
>  4 files changed, 164 insertions(+), 0 deletions(-)
>  create mode 100644 arch/arm/mach-tegra/board-harmony-power.c

...
> 
> diff --git a/arch/arm/mach-tegra/board-harmony-power.c b/arch/arm/mach-tegra/board-harmony-power.c
> new file mode 100644
> index 0000000..ca43d7a
> --- /dev/null
> +++ b/arch/arm/mach-tegra/board-harmony-power.c
...
> +static struct i2c_board_info __initdata harmony_regulators[] = {
> +	{
> +		I2C_BOARD_INFO("tps6586x", 0x34),
> +		.irq		= INT_EXTERNAL_PMU,
> +		.platform_data	= &tps_platform,
> +	},
> +};
> +
> +int __init harmony_regulator_init(void)
> +{
> +	i2c_register_board_info(3, harmony_regulators, 1);

I don't know harmony well, but are you sure this is 3, not 4, as on all other boards?

Marc
