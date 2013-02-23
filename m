From: josephl@nvidia.com (Joseph Lo)
Date: Sat, 23 Feb 2013 10:03:42 +0800
Subject: [PATCH 1/4] ARM: tegra: pmc: convert PMC driver to support DT only
In-Reply-To: <20130222130516.GW23234@tbergstrom-lnx.Nvidia.com>
References: <1361515491-16199-1-git-send-email-josephl@nvidia.com>
 <1361515491-16199-2-git-send-email-josephl@nvidia.com>
 <20130222130516.GW23234@tbergstrom-lnx.Nvidia.com>
Message-ID: <1361585022.1804.11.camel@jlo-ubuntu-64.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2013-02-22 at 21:05 +0800, Peter De Schrijver wrote:
> On Fri, Feb 22, 2013 at 07:44:48AM +0100, Joseph Lo wrote:
> > The Tegra kernel only support boot from DT now. Clean up the PMC driver
> > to support DT only, that includes:
> > 
> > * remove the ifdef of CONFIG_OF
> > * replace the static mapping of PMC addr to map from DT
> > 
> > -#ifdef CONFIG_OF
> >  static const struct of_device_id matches[] __initconst = {
> >  	{ .compatible = "nvidia,tegra20-pmc" },
> >  	{ }
> 
> At least an extra entry for tegra114-pmc is necessary here. tegra114.dtsi only
> has:
> 
> pmc {
> 	compatible = "nvidia,tegra114-pmc", "nvidia,tegra30-pmc";
> 	reg = <0x7000e400 0x400>;
> };
> 
I think it should be something like below, isn't it?

compatible = "nvidia,tegra114-pmc", "nvidia,tegra30-pmc",
		"nvidia,tegra20-pmc";

or should we add tegra114 and tegra30 in the DT match table?

Thanks,
Joseph
