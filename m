From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Wed, 02 Jul 2014 10:09:43 +0200
Subject: [PATCH/RFC 2/6] ARM: shmobile: r8a7778: Add SCIF nodes
In-Reply-To: <1404275322-26514-3-git-send-email-horms+renesas@verge.net.au>
References: <1404275322-26514-1-git-send-email-horms+renesas@verge.net.au>
 <1404275322-26514-3-git-send-email-horms+renesas@verge.net.au>
Message-ID: <13504964.HMrnJUVGKG@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Simon,

Thank you for the patch.

On Wednesday 02 July 2014 06:28:38 Simon Horman wrote:
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

Just one small comment below. Apart from that,

Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
>  arch/arm/boot/dts/r8a7778.dtsi | 48 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 48 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/r8a7778.dtsi b/arch/arm/boot/dts/r8a7778.dtsi
> index 3af0a21..55357dc 100644
> --- a/arch/arm/boot/dts/r8a7778.dtsi
> +++ b/arch/arm/boot/dts/r8a7778.dtsi
> @@ -156,6 +156,54 @@
>  		status = "disabled";
>  	};
> 
> +	scif0: serial at ffe40000 {
> +		compatible = "renesas,scif-r8a7778", "renesas,scif";
> +		reg = <0xffe40000 0x100>;
> +		interrupt-parent = <&gic>;

The interrupt-parent property is now specified at the top level, so you can 
remove it from the scif nodes.

> +		interrupts = <0 70 IRQ_TYPE_LEVEL_HIGH>;
> +		status = "disabled";
> +	};
> +
> +	scif1: serial at ffe41000 {
> +		compatible = "renesas,scif-r8a7778", "renesas,scif";
> +		reg = <0xffe41000 0x100>;
> +		interrupt-parent = <&gic>;
> +		interrupts = <0 71 IRQ_TYPE_LEVEL_HIGH>;
> +		status = "disabled";
> +	};
> +
> +	scif2: serial at ffe42000 {
> +		compatible = "renesas,scif-r8a7778", "renesas,scif";
> +		reg = <0xffe42000 0x100>;
> +		interrupt-parent = <&gic>;
> +		interrupts = <0 72 IRQ_TYPE_LEVEL_HIGH>;
> +		status = "disabled";
> +	};
> +
> +	scif3: serial at ffe43000 {
> +		compatible = "renesas,scif-r8a7778", "renesas,scif";
> +		reg = <0xffe43000 0x100>;
> +		interrupt-parent = <&gic>;
> +		interrupts = <0 73 IRQ_TYPE_LEVEL_HIGH>;
> +		status = "disabled";
> +	};
> +
> +	scif4: serial at ffe44000 {
> +		compatible = "renesas,scif-r8a7778", "renesas,scif";
> +		reg = <0xffe44000 0x100>;
> +		interrupt-parent = <&gic>;
> +		interrupts = <0 74 IRQ_TYPE_LEVEL_HIGH>;
> +		status = "disabled";
> +	};
> +
> +	scif5: serial at ffe45000 {
> +		compatible = "renesas,scif-r8a7778", "renesas,scif";
> +		reg = <0xffe45000 0x100>;
> +		interrupt-parent = <&gic>;
> +		interrupts = <0 75 IRQ_TYPE_LEVEL_HIGH>;
> +		status = "disabled";
> +	};
> +
>  	mmcif: mmc at ffe4e000 {
>  		compatible = "renesas,sh-mmcif";
>  		reg = <0xffe4e000 0x100>;

-- 
Regards,

Laurent Pinchart
