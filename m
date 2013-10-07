From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 07 Oct 2013 11:18:55 -0600
Subject: [PATCH 4/7] ARM: tegra: Add initial device tree for Tegra124
In-Reply-To: <1381131085-26116-5-git-send-email-josephl@nvidia.com>
References: <1381131085-26116-1-git-send-email-josephl@nvidia.com>
 <1381131085-26116-5-git-send-email-josephl@nvidia.com>
Message-ID: <5252ECFF.404@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/07/2013 01:31 AM, Joseph Lo wrote:
> Initial support for Tegra 124 SoC. This is expected to be included in
> the board DTS files.

> diff --git a/arch/arm/boot/dts/tegra124.dtsi b/arch/arm/boot/dts/tegra124.dtsi

> +	rtc {
> +		compatible = "nvidia,tegra124-rtc", "nvidia,tegra20-rtc";
> +		reg = <0x7000e000 0x100>;

We recently decided that all nodes that have a reg property must have a
matching unit address in the node name. Hence, the node should be named
"rtc at 7000e000" not just "rtc". We haven't decided how to clean this up
for existing DTs, but I'd like to enforce the new rule for all new DTs.

The pmc node should also be fixed.

> +	pmc {
> +		compatible = "nvidia,tegra124-pmc", "nvidia,tegra114-pmc";
> +		reg = <0x7000e400 0x400>;
> +	};

Is the Tegra124 PMC really identical to the Tegra114 PMC in hardware?
That would be a departure from history, where the PMC has changed
significantly and incompatibly for each chip. Can you please investigate
the details of the PMC changes; I suspect this should simply be:

		compatible = "nvidia,tegra124-pmc";
