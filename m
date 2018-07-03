From: robh@kernel.org (Rob Herring)
Date: Tue, 3 Jul 2018 15:33:39 -0600
Subject: [PATCH v2 19/23] arm64: dts: marvell: rename ap806 syscon node
In-Reply-To: <20180625151239.20976-20-miquel.raynal@bootlin.com>
References: <20180625151239.20976-1-miquel.raynal@bootlin.com>
 <20180625151239.20976-20-miquel.raynal@bootlin.com>
Message-ID: <20180703213339.GA29809@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 25, 2018 at 05:12:35PM +0200, Miquel Raynal wrote:
> In CP files, the syscons are called CP110_LABEL(syscon<x>) in case of
> future additions. Use the same logic here to prepare the addition of a
> second syscon to access both the thermal IP, the DFX server registers
> and later probably other registers within this same memory area.

You are renaming labels, not nodes.

The example is just an example. Drop that change as it is not necessary.

> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
>  .../devicetree/bindings/arm/marvell/ap806-system-controller.txt         | 2 +-
>  arch/arm64/boot/dts/marvell/armada-ap806.dtsi                           | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/arm/marvell/ap806-system-controller.txt b/Documentation/devicetree/bindings/arm/marvell/ap806-system-controller.txt
> index a265f1628f36..108e8da600e4 100644
> --- a/Documentation/devicetree/bindings/arm/marvell/ap806-system-controller.txt
> +++ b/Documentation/devicetree/bindings/arm/marvell/ap806-system-controller.txt
> @@ -79,7 +79,7 @@ Required properties:
>  - offset: offset address inside the syscon block
>  
>  Example:
> -ap_syscon: system-controller at 6f4000 {
> +ap_syscon0: system-controller at 6f4000 {
>  	compatible = "syscon", "simple-mfd";
>  	reg = <0x6f4000 0x1000>;
>  
> diff --git a/arch/arm64/boot/dts/marvell/armada-ap806.dtsi b/arch/arm64/boot/dts/marvell/armada-ap806.dtsi
> index 4f2a704615b0..550f03b8c96f 100644
> --- a/arch/arm64/boot/dts/marvell/armada-ap806.dtsi
> +++ b/arch/arm64/boot/dts/marvell/armada-ap806.dtsi
> @@ -230,7 +230,7 @@
>  				status = "disabled";
>  			};
>  
> -			ap_syscon: system-controller at 6f4000 {
> +			ap_syscon0: system-controller at 6f4000 {
>  				compatible = "syscon", "simple-mfd";
>  				reg = <0x6f4000 0x2000>;
>  
> -- 
> 2.14.1
> 
