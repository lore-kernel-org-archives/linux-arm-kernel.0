From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Tue, 20 Mar 2018 19:47:59 +0100
Subject: [PATCH 5/7] arm64: allwinner: a64: add DE2 CCU related device
 tree nodes
In-Reply-To: <20180316175354.21437-6-icenowy@aosc.io>
References: <20180316175354.21437-1-icenowy@aosc.io>
 <20180316175354.21437-6-icenowy@aosc.io>
Message-ID: <20180320184759.nb2zwn5liqa2kpm4@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Mar 17, 2018 at 01:53:52AM +0800, Icenowy Zheng wrote:
> +		sram-controller at 1c00000 {
> +			compatible = "allwinner,sun50i-a64-sram-controller";
> +			reg = <0x01c00000 0x1000>;
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			ranges;
> +
> +			sram_c: sram at 18000 {
> +				compatible = "mmio-sram";
> +				reg = <0x00018000 0x28000>;
> +				#address-cells = <1>;
> +				#size-cells = <1>;
> +				ranges = <0 0x00018000 0x28000>;
> +
> +				de2_sram: sram-section at 0 {
> +					compatible = "allwinner,sun50i-a64-sram-c";
> +					reg = <0x0000 0x28000>;
> +				};
> +			};
> +		};
> +
>  		syscon: syscon at 1c00000 {
>  			compatible = "allwinner,sun50i-a64-system-controller",
>  				"syscon";

Isn't that the same device than the sram controller node you just added?

Maxime

-- 
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
