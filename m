From: horms@verge.net.au (Simon Horman)
Date: Thu, 22 Jan 2015 11:45:56 +0900
Subject: [PATCH 1/4] ARM: shmobile: sh73a0 dtsi: Add Bus State Controller
 node
In-Reply-To: <1420809236-4105-1-git-send-email-geert+renesas@glider.be>
References: <1420809236-4105-1-git-send-email-geert+renesas@glider.be>
Message-ID: <20150122024555.GE31170@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 09, 2015 at 02:13:53PM +0100, Geert Uytterhoeven wrote:
> Add a node for the Bus State Controller (BSC) on sh73a0, to which
> multiple external devices can be connected.
> 
> The BSC is driven by the ZB clock, and located in PM domain A4S.
> A reference to the latter will be added later.

For the record: Olof has asked for review comments for the BSC driver
and binding patches. Accordingly I have dropped them, and these patches
which depend on them, from next.

> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> v3:
>   - Move "ranges" before "reg",
> 
> v2:
>   - Postpone power-domains.
> ---
>  arch/arm/boot/dts/sh73a0.dtsi | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/sh73a0.dtsi b/arch/arm/boot/dts/sh73a0.dtsi
> index 891ed9b6383f58fc..46954ac26dd9fb41 100644
> --- a/arch/arm/boot/dts/sh73a0.dtsi
> +++ b/arch/arm/boot/dts/sh73a0.dtsi
> @@ -360,6 +360,16 @@
>  		status = "disabled";
>  	};
>  
> +	bsc: bus at fec10000 {
> +		compatible = "renesas,bsc-sh73a0", "renesas,bsc", "simple-bus";
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		ranges = <0 0 0x20000000>;
> +		reg = <0xfec10000 0x400>;
> +		interrupts = <0 39 IRQ_TYPE_LEVEL_HIGH>;
> +		clocks = <&zb_clk>;
> +	};
> +
>  	clocks {
>  		#address-cells = <1>;
>  		#size-cells = <1>;
> -- 
> 1.9.1
> 
