From: andre.przywara@arm.com (Andre Przywara)
Date: Fri, 9 Jun 2017 14:38:39 +0100
Subject: [linux-sunxi] [PATCH] arm64: allwinner: sun50i-a64: Remove
 duplicate ethernet@1c30000
In-Reply-To: <1497012052-14027-1-git-send-email-jteki@openedev.com>
References: <1497012052-14027-1-git-send-email-jteki@openedev.com>
Message-ID: <6d21516d-7412-5f16-f6f8-b7d46106b4f5@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 09/06/17 13:40, Jagan Teki wrote:
> From: Jagan Teki <jagan@amarulasolutions.com>
> 
> Remove duplicate ethernet at 1c30000 from allwinner/sun50i-a64.dtsi

I think this is an artefact of the sun8i-dwmac merging, where both David
and Maxime merged the DT patches in their trees (compare e53f67e9 and
103aefa0). I think both of them are in the process of sorting this out
(as this effects more than this hunk, I believe).

Cheers,
Andre.

> 
> Build error:
> arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dtb:
> ERROR (duplicate_node_names): Duplicate node name /soc/ethernet at 1c30000
> ERROR: Input tree has errors, aborting (use -f to force output)
> 
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> ---
>  arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 20 --------------------
>  1 file changed, 20 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> index 1b36aab..9d00622 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> @@ -469,26 +469,6 @@
>  			};
>  		};
>  
> -		emac: ethernet at 1c30000 {
> -			compatible = "allwinner,sun50i-a64-emac";
> -			syscon = <&syscon>;
> -			reg = <0x01c30000 0x100>;
> -			interrupts = <GIC_SPI 82 IRQ_TYPE_LEVEL_HIGH>;
> -			interrupt-names = "macirq";
> -			resets = <&ccu RST_BUS_EMAC>;
> -			reset-names = "stmmaceth";
> -			clocks = <&ccu CLK_BUS_EMAC>;
> -			clock-names = "stmmaceth";
> -			status = "disabled";
> -			#address-cells = <1>;
> -			#size-cells = <0>;
> -
> -			mdio: mdio {
> -				#address-cells = <1>;
> -				#size-cells = <0>;
> -			};
> -		};
> -
>  		gic: interrupt-controller at 1c81000 {
>  			compatible = "arm,gic-400";
>  			reg = <0x01c81000 0x1000>,
> 
