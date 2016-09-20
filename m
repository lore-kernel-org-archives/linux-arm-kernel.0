From: jonathanh@nvidia.com (Jon Hunter)
Date: Tue, 20 Sep 2016 18:15:02 +0100
Subject: [PATCH 1/4] ARM: tegra: nyan: Use proper IRQ type definitions
In-Reply-To: <20160828173246.32621-1-contact@paulk.fr>
References: <20160828173246.32621-1-contact@paulk.fr>
Message-ID: <ef69b6d2-ce6b-ff76-5c04-ab2176eb6ecc@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 28/08/16 18:32, Paul Kocialkowski wrote:
> This switches a few interrupt definitions that were using
> GPIO_ACTIVE_HIGH as IRQ type, which is invalid.

May be you are right, but this does not describe why this is invalid.
Can you elaborate?

> Signed-off-by: Paul Kocialkowski <contact@paulk.fr>
> ---
>  arch/arm/boot/dts/tegra124-nyan.dtsi | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/tegra124-nyan.dtsi b/arch/arm/boot/dts/tegra124-nyan.dtsi
> index 271505e..30a77ec 100644
> --- a/arch/arm/boot/dts/tegra124-nyan.dtsi
> +++ b/arch/arm/boot/dts/tegra124-nyan.dtsi
> @@ -59,7 +59,7 @@
>  			compatible = "maxim,max98090";
>  			reg = <0x10>;
>  			interrupt-parent = <&gpio>;
> -			interrupts = <TEGRA_GPIO(H, 4) GPIO_ACTIVE_HIGH>;
> +			interrupts = <TEGRA_GPIO(H, 4) IRQ_TYPE_EDGE_FALLING>;

If this in invalid then the DT binding doc for the max98090 should be
updated as well.

>  		};
>  
>  		temperature-sensor at 4c {
> @@ -325,7 +325,7 @@
>  					reg = <0x9>;
>  					interrupt-parent = <&gpio>;
>  					interrupts = <TEGRA_GPIO(J, 0)
> -							GPIO_ACTIVE_HIGH>;
> +							IRQ_TYPE_EDGE_BOTH>;
>  					ti,ac-detect-gpios = <&gpio
>  							TEGRA_GPIO(J, 0)
>  							GPIO_ACTIVE_HIGH>;
> 

Cheers
Jon

-- 
nvpublic
