From: marvin24@gmx.de (Marvin)
Date: Wed, 9 Mar 2011 12:14:26 +0100
Subject: [PATCH 2/3] ARM: tegra: harmony: initialize the TPS65862 PMIC
In-Reply-To: <4D771CE3.6020606@compulab.co.il>
References: <cover.1299588456.git.mike@compulab.co.il>
	<201103082312.06911.marvin24@gmx.de>
	<4D771CE3.6020606@compulab.co.il>
Message-ID: <201103091214.26718.marvin24@gmx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> On 03/09/11 00:12, Marc Dietrich wrote:
> > Am Dienstag 08 M?rz 2011, um 13:58:58 schrieb Mike Rapoport:
> >>
> >> diff --git a/arch/arm/mach-tegra/board-harmony-power.c b/arch/arm/mach-tegra/board-harmony-power.c
> >> new file mode 100644
> >> index 0000000..ca43d7a
> >> --- /dev/null
> >> +++ b/arch/arm/mach-tegra/board-harmony-power.c
> > ...
> >> +static struct i2c_board_info __initdata harmony_regulators[] = {
> >> +	{
> >> +		I2C_BOARD_INFO("tps6586x", 0x34),
> >> +		.irq		= INT_EXTERNAL_PMU,
> >> +		.platform_data	= &tps_platform,
> >> +	},
> >> +};
> >> +
> >> +int __init harmony_regulator_init(void)
> >> +{
> >> +	i2c_register_board_info(3, harmony_regulators, 1);
> > 
> > I don't know harmony well, but are you sure this is 3, not 4, as on all other boards?
> 
> In the mainline version of i2c-tegra the adapter (and therefore bus) number
> equals the platform device id, and in case of DVC adapter it's 3.

Thanks for clarification. I guess this saved me from some headaches.

Marc
