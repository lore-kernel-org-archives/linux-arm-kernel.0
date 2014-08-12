From: vinceh@nvidia.com (Vince Hsu)
Date: Tue, 12 Aug 2014 18:37:12 +0800
Subject: [PATCH v2 08/16] clk: tegra: Add Tegra124 DFLL clocksource
 platform driver
In-Reply-To: <1405957142-19416-9-git-send-email-ttynkkynen@nvidia.com>
References: <1405957142-19416-1-git-send-email-ttynkkynen@nvidia.com>
 <1405957142-19416-9-git-send-email-ttynkkynen@nvidia.com>
Message-ID: <53E9EE58.3060408@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 07/21/2014 11:38 PM, Tuomas Tynkkynen wrote:
> Add basic platform driver support for the fast CPU cluster DFLL
> clocksource found on Tegra124 SoCs. This small driver selects the
> appropriate Tegra124-specific characterization data and integration
> code. It relies on the DFLL common code to do most of the work.
>
> diff --git a/drivers/clk/tegra/Makefile b/drivers/clk/tegra/Makefile
> index 47320ca..2f87188 100644
> --- a/drivers/clk/tegra/Makefile
> +++ b/drivers/clk/tegra/Makefile
> @@ -16,3 +16,5 @@ obj-$(CONFIG_ARCH_TEGRA_2x_SOC)         += clk-tegra20.o
>   obj-$(CONFIG_ARCH_TEGRA_3x_SOC)         += clk-tegra30.o
>   obj-$(CONFIG_ARCH_TEGRA_114_SOC)	+= clk-tegra114.o
>   obj-$(CONFIG_ARCH_TEGRA_124_SOC)	+= clk-tegra124.o
> +obj-$(CONFIG_ARCH_TEGRA_124_SOC)	+= clk-tegra124-dfll-fcpu.o
> +obj-y					+= cvb.o
> diff --git a/drivers/clk/tegra/clk-tegra124-dfll-fcpu.c b/drivers/clk/tegra/clk-tegra124-dfll-fcpu.c
> new file mode 100644
> index 0000000..f068360
> --- /dev/null
> +++ b/drivers/clk/tegra/clk-tegra124-dfll-fcpu.c
...
> +	if (IS_ERR(cvb)) {
> +		pr_err("couldn't build OPP table: %ld\n", PTR_ERR(cvb));
> +		return PTR_ERR(cvb);
> +	}
> +
> +	soc.assert_dvco_reset = tegra124_clock_assert_dfll_dvco_reset,
> +	soc.deassert_dvco_reset = tegra124_clock_deassert_dfll_dvco_reset,
nit: Use semicolon instead at the end of the two lines above.


Thanks,
Vince
