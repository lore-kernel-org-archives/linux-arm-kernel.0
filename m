From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 13 Aug 2013 13:52:17 -0600
Subject: [PATCHv3] ARM: socfpga: dts: Add support for SD/MMC
In-Reply-To: <1376322589-17606-1-git-send-email-dinguyen@altera.com>
References: <1376322589-17606-1-git-send-email-dinguyen@altera.com>
Message-ID: <520A8E71.4090508@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/12/2013 09:49 AM, dinguyen at altera.com wrote:
> From: Dinh Nguyen <dinguyen@altera.com>
> 
> Add bindings for SD/MMC for SOCFPGA.
> Add "syscon" to the "altr,sys-mgr" binding.

> diff --git a/Documentation/devicetree/bindings/mmc/socfpga-dw-mshc.txt b/Documentation/devicetree/bindings/mmc/socfpga-dw-mshc.txt

I think it's reasonable to define one binding as being based on another
plus some additions, so, the binding,
Acked-by: Stephen Warren <swarren@nvidia.com>

> +Example:
> +	dwmmc0 at ff704000 {
> +		compatible = "altr,socfpga-dw-mshc", "snps,dw-mshc";
> +		altr,dw-mshc-sdr-timing = <0 3>;
> +	};

It'd be nice to provide a complete example though, rather than only
including the properties that this binding adds to the base binding.

> diff --git a/arch/arm/boot/dts/socfpga.dtsi b/arch/arm/boot/dts/socfpga.dtsi

>  		sysmgr at ffd08000 {
> -				compatible = "altr,sys-mgr";
> +				compatible = "altr,sys-mgr", "syscon";

That seems like an unrelated change?
