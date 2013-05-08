From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 08 May 2013 10:56:34 -0600
Subject: [PATCH 3/4] ARM: dts: tegra: Correct PCIe entry
In-Reply-To: <1368010660-31465-3-git-send-email-jagarwal@nvidia.com>
References: <1368010660-31465-1-git-send-email-jagarwal@nvidia.com>
 <1368010660-31465-3-git-send-email-jagarwal@nvidia.com>
Message-ID: <518A83C2.3070709@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/08/2013 04:57 AM, Jay Agarwal wrote:
> - Add interrupt-names property
> - Correct downstream I/O size
> - Correct cml clock name for Tegra30
> - Patch is based on remotes/gitorious_thierryreding_linux/tegra/next
> - and should be applied on top of this.

Another change that needs to be made to this file (probably as a
separate change that Thierry can squash into one of his earlier changes)
is to move the pcie-controller node; it is currently not in the correct
place in the .dtsi file; it's not sorted by reg addresss.

> diff --git a/arch/arm/boot/dts/tegra30.dtsi b/arch/arm/boot/dts/tegra30.dtsi

>  		clocks = <&tegra_car 70>, <&tegra_car 72>, <&tegra_car 74>,
>  			 <&tegra_car 118>, <&tegra_car 215>;
> -		clock-names = "pex", "afi", "pcie_xclk", "pll_e", "cml";
> +		clock-names = "pex", "afi", "pcie_xclk", "pll_e", "cml0";

You could drop that change if the driver named the clock "cml" rather
than "cml0", which as I explained in my previous email seems like a good
idea anyway.

Applying the same reasoning, I wonder if for Tegra 20 too, the PCIe
driver shouldn't expect clock names of just "xclk" and "pll" rather than
"pcie_xclk" and "pll_e".
