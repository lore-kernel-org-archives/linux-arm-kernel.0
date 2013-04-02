From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 02 Apr 2013 13:36:21 -0600
Subject: [PATCH V3 2/3] ARM: dts: tegra: add clock source for PMC
In-Reply-To: <1364901583-24867-3-git-send-email-josephl@nvidia.com>
References: <1364901583-24867-1-git-send-email-josephl@nvidia.com>
 <1364901583-24867-3-git-send-email-josephl@nvidia.com>
Message-ID: <515B3335.30405@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/02/2013 05:19 AM, Joseph Lo wrote:
> Adding the clock sources of PMC into DTS for Tegra20 and Tegra30.

Why only Tegra20 and Tegra30; don't you need to make the exact same
changes to tegra114-dalmore.dts and tegra114-pluto.dts? (I think the
answer is yes, you do).

> diff --git a/arch/arm/boot/dts/tegra20-colibri-512.dtsi b/arch/arm/boot/dts/tegra20-colibri-512.dtsi
> index cb73e62..4c107e6 100644
> --- a/arch/arm/boot/dts/tegra20-colibri-512.dtsi
> +++ b/arch/arm/boot/dts/tegra20-colibri-512.dtsi
> @@ -8,6 +8,19 @@
>  		reg = <0x00000000 0x20000000>;
>  	};
>  
> +	clocks {
...
> +	};
> +
>  	host1x {

The node order is wrong here. The order should be:

1) Any nodes that existed in any included file, in the same order as
they existed in the included file.

2) Any new nodes that have a reg property, sorted by reg property.

3) Any new nodes without a reg property, sorted alpha-numerically by
node name.

So in this file for example, the new nod should exist between
sdhci at c8000600 and sound.

This same comment applies to every file in this patch.
