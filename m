From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 19 Mar 2013 10:42:46 -0600
Subject: [PATCH V2 1/3] ARM: dts: tegra: add clock source for PMC
In-Reply-To: <1363594199-10974-2-git-send-email-josephl@nvidia.com>
References: <1363594199-10974-1-git-send-email-josephl@nvidia.com>
 <1363594199-10974-2-git-send-email-josephl@nvidia.com>
Message-ID: <51489586.9090605@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/18/2013 02:09 AM, Joseph Lo wrote:
> The clock source of PMC is PCLK. Adding it into DTS for Tegra20 and Tegra30.

> diff --git a/arch/arm/boot/dts/tegra20.dtsi b/arch/arm/boot/dts/tegra20.dtsi

>  	pmc {
>  		compatible = "nvidia,tegra20-pmc";
>  		reg = <0x7000e400 0x400>;
> +		clocks = <&tegra_car 110>;
>  	};

The DT binding documentation needs to list the set of clocks that must
be present.

Doesn't the PMC also receive a "clk32k_in" from the PMIC, or is that
routed into the CAR, and then into the PMC? Either way, the PMC module
receives that clock somehow. Since there are multiple clocks, that also
means that a clock-names property is required.
