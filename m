From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Wed, 02 Jul 2014 11:06:07 +0200
Subject: [PATCH/RFC 5/6] ARM: shmobile: r8a7778: Add TMU nodes
In-Reply-To: <1404275322-26514-6-git-send-email-horms+renesas@verge.net.au>
References: <1404275322-26514-1-git-send-email-horms+renesas@verge.net.au>
 <1404275322-26514-6-git-send-email-horms+renesas@verge.net.au>
Message-ID: <5424166.WM0v7vs9tc@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Simon,

Thank you for the patch.

On Wednesday 02 July 2014 06:28:41 Simon Horman wrote:

I've often requested to write a commit message, even for simple patches ;-)

> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
>  arch/arm/boot/dts/r8a7778.dtsi | 36 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 36 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/r8a7778.dtsi b/arch/arm/boot/dts/r8a7778.dtsi
> index 55357dc..672224f 100644
> --- a/arch/arm/boot/dts/r8a7778.dtsi
> +++ b/arch/arm/boot/dts/r8a7778.dtsi
> @@ -156,6 +156,42 @@
>  		status = "disabled";
>  	};
> 
> +	tmu0: timer at ffd80000 {
> +		compatible = "renesas,tmu";
> +		reg = <0xffd80000 0x30>;
> +		interrupts = <0 32 IRQ_TYPE_LEVEL_HIGH>,
> +			     <0 33 IRQ_TYPE_LEVEL_HIGH>,
> +			     <0 34 IRQ_TYPE_LEVEL_HIGH>;
> +
> +		#renesas,channels = <3>;
> +
> +		status = "disabled";
> +	};
> +
> +	tmu1: timer at ffd81000 {
> +		compatible = "renesas,tmu";
> +		reg = <0xffd81000 0x30>;
> +		interrupts = <0 36 IRQ_TYPE_LEVEL_HIGH>,
> +			     <0 37 IRQ_TYPE_LEVEL_HIGH>,
> +			     <0 38 IRQ_TYPE_LEVEL_HIGH>;
> +
> +		#renesas,channels = <3>;
> +
> +		status = "disabled";
> +	};
> +
> +	tmu2: timer at ffd82000 {
> +		compatible = "renesas,tmu";
> +		reg = <0xffd82000 0x30>;
> +		interrupts = <0 40 IRQ_TYPE_LEVEL_HIGH>,
> +			     <0 41 IRQ_TYPE_LEVEL_HIGH>,
> +			     <0 42 IRQ_TYPE_LEVEL_HIGH>;
> +
> +		#renesas,channels = <3>;
> +
> +		status = "disabled";
> +	};
> +
>  	scif0: serial at ffe40000 {
>  		compatible = "renesas,scif-r8a7778", "renesas,scif";
>  		reg = <0xffe40000 0x100>;

-- 
Regards,

Laurent Pinchart
