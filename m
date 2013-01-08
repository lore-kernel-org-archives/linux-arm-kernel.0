From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 08 Jan 2013 15:49:27 -0700
Subject: [v2 6/9] ARM: dt: tegra114: Add new SoC base, Tegra 114 SoC
In-Reply-To: <1357649263-1098-7-git-send-email-hdoyu@nvidia.com>
References: <1357649263-1098-1-git-send-email-hdoyu@nvidia.com>
 <1357649263-1098-7-git-send-email-hdoyu@nvidia.com>
Message-ID: <50ECA277.5050907@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/08/2013 05:47 AM, Hiroshi Doyu wrote:
> Initial support for Tegra 114 SoC. This is expected to be included in
> the board DTS files, Tegra 114 SoC based evaluation board family.

> diff --git a/arch/arm/boot/dts/tegra114.dtsi b/arch/arm/boot/dts/tegra114.dtsi

> +	gic: interrupt-controller {
> +		compatible = "arm,cortex-a15-gic", "arm,cortex-a9-gic";
> +		reg = <0x50041000 0x1000
> +		       0x50042000 0x1000>;
> +		interrupt-controller;
> +		#interrupt-cells = <3>;
> +	};

Last time around, Marc Zyngier asked:

> If this is indeed an A15 GIC, how about adding the GICH and GICV
> regions, as well as the VGIC maintenance interrupt?
