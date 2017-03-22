From: liviu.dudau@arm.com (Liviu Dudau)
Date: Wed, 22 Mar 2017 11:56:18 +0000
Subject: [PATCH 13/15] arm64: dts: juno: fix PCI bus dtc warnings
In-Reply-To: <20170322020313.24338-13-robh@kernel.org>
References: <20170322020313.24338-1-robh@kernel.org>
 <20170322020313.24338-13-robh@kernel.org>
Message-ID: <20170322115618.GD6816@e110455-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob,

On Tue, Mar 21, 2017 at 09:03:11PM -0500, Rob Herring wrote:
> dtc recently added PCI bus checks. Fix these warnings.

Was not aware of the warnings and the commit message doesn't quote
them, but the change looks trivial. So:

Acked-by: Liviu Dudau <liviu.dudau@arm.com>

Thanks for fixing this!
Liviu

> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> Cc: Liviu Dudau <liviu.dudau@arm.com>
> Cc: Sudeep Holla <sudeep.holla@arm.com>
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> ---
> 
>  arch/arm64/boot/dts/arm/juno-base.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/arm/juno-base.dtsi b/arch/arm64/boot/dts/arm/juno-base.dtsi
> index df539e865b90..8ffaff2043d0 100644
> --- a/arch/arm64/boot/dts/arm/juno-base.dtsi
> +++ b/arch/arm64/boot/dts/arm/juno-base.dtsi
> @@ -428,7 +428,7 @@
>  		};
>  	};
>  
> -	pcie_ctlr: pcie-controller at 40000000 {
> +	pcie_ctlr: pcie at 40000000 {
>  		compatible = "arm,juno-r1-pcie", "plda,xpressrich3-axi", "pci-host-ecam-generic";
>  		device_type = "pci";
>  		reg = <0 0x40000000 0 0x10000000>;	/* ECAM config space */
> -- 
> 2.10.1
> 

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ?\_(?)_/?
