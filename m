From: josephl@nvidia.com (Joseph Lo)
Date: Tue, 8 Oct 2013 09:21:22 +0800
Subject: [PATCH 4/7] ARM: tegra: Add initial device tree for Tegra124
In-Reply-To: <5252ECFF.404@wwwdotorg.org>
References: <1381131085-26116-1-git-send-email-josephl@nvidia.com>
 <1381131085-26116-5-git-send-email-josephl@nvidia.com>
 <5252ECFF.404@wwwdotorg.org>
Message-ID: <1381195282.10568.2.camel@jlo-ubuntu-64.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2013-10-08 at 01:18 +0800, Stephen Warren wrote:
> On 10/07/2013 01:31 AM, Joseph Lo wrote:
> > Initial support for Tegra 124 SoC. This is expected to be included in
> > the board DTS files.
> The pmc node should also be fixed.
> 
> > +	pmc {
> > +		compatible = "nvidia,tegra124-pmc", "nvidia,tegra114-pmc";
> > +		reg = <0x7000e400 0x400>;
> > +	};
> 
> Is the Tegra124 PMC really identical to the Tegra114 PMC in hardware?
> That would be a departure from history, where the PMC has changed
> significantly and incompatibly for each chip. Can you please investigate
> the details of the PMC changes; I suspect this should simply be:
> 
> 		compatible = "nvidia,tegra124-pmc";
> 

Thanks for reminding, it's not identical. Considering the power gate and
power domain function is not the same with Tegra114.
