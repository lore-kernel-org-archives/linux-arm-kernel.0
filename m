From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Wed, 30 Apr 2014 02:42:20 +0200
Subject: [PATCH 1/4] ARM: shmobile: r8a7779: Add scif nodes to dtsi
In-Reply-To: <1398757406-30920-2-git-send-email-horms+renesas@verge.net.au>
References: <1398757406-30920-1-git-send-email-horms+renesas@verge.net.au>
 <1398757406-30920-2-git-send-email-horms+renesas@verge.net.au>
Message-ID: <2171203.7Ft1Jpoq1o@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Simon,

Thank you for the patch.

On Tuesday 29 April 2014 16:43:23 Simon Horman wrote:
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> ---
>  arch/arm/boot/dts/r8a7779.dtsi | 60 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 60 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/r8a7779.dtsi b/arch/arm/boot/dts/r8a7779.dtsi
> index e924f96..3e9cca4 100644
> --- a/arch/arm/boot/dts/r8a7779.dtsi
> +++ b/arch/arm/boot/dts/r8a7779.dtsi
> @@ -203,6 +203,66 @@
>  		status = "disabled";
>  	};
> 
> +	scif0: serial at ffe40000 {
> +		compatible = "renesas,scif", "renesas,scif-r8a7779";

The most specific compatible string should come first, so this should read

		compatible = "renesas,scif-r8a7779", "renesas,scif";

> +		reg = <0xffe40000 265>;

265 ? Don't you mean 256 ? 0x100 might be a better option.

> +		interrupt-parent = <&gic>;
> +		interrupts = <0 88 IRQ_TYPE_LEVEL_HIGH>;
> +		clocks = <&cpg_clocks R8A7779_CLK_P>;
> +		clock-names = "sci_ick";

Could you try the SCI RFC patch set I've just sent that drop the interface 
clock in favour of the functional clock ?

> +		status = "disabled";
> +	};
> +
> +	scif1: serial at ffe41000 {
> +		compatible = "renesas,scif", "renesas,scif-r8a7779";
> +		reg = <0xffe41000 265>;
> +		interrupt-parent = <&gic>;
> +		interrupts = <0 89 IRQ_TYPE_LEVEL_HIGH>;
> +		clocks = <&cpg_clocks R8A7779_CLK_P>;
> +		clock-names = "sci_ick";
> +		status = "disabled";
> +	};
> +
> +	scif2: serial at ffe42000 {
> +		compatible = "renesas,scif", "renesas,scif-r8a7779";
> +		reg = <0xffe42000 265>;
> +		interrupt-parent = <&gic>;
> +		interrupts = <0 90 IRQ_TYPE_LEVEL_HIGH>;
> +		clocks = <&cpg_clocks R8A7779_CLK_P>;
> +		clock-names = "sci_ick";
> +		status = "disabled";
> +	};
> +
> +	scif3: serial at ffe43000 {
> +		compatible = "renesas,scif", "renesas,scif-r8a7779";
> +		reg = <0xffe43000 265>;
> +		interrupt-parent = <&gic>;
> +		interrupts = <0 91 IRQ_TYPE_LEVEL_HIGH>;
> +		clocks = <&cpg_clocks R8A7779_CLK_P>;
> +		clock-names = "sci_ick";
> +		status = "disabled";
> +	};
> +
> +	scif4: serial at ffe44000 {
> +		compatible = "renesas,scif", "renesas,scif-r8a7779";
> +		reg = <0xffe44000 265>;
> +		interrupt-parent = <&gic>;
> +		interrupts = <0 92 IRQ_TYPE_LEVEL_HIGH>;
> +		clocks = <&cpg_clocks R8A7779_CLK_P>;
> +		clock-names = "sci_ick";
> +		status = "disabled";
> +	};
> +
> +	scif5: serial at ffe45000 {
> +		compatible = "renesas,scif", "renesas,scif-r8a7779";
> +		reg = <0xffe45000 265>;
> +		interrupt-parent = <&gic>;
> +		interrupts = <0 93 IRQ_TYPE_LEVEL_HIGH>;
> +		clocks = <&cpg_clocks R8A7779_CLK_P>;
> +		clock-names = "sci_ick";
> +		status = "disabled";
> +	};
> +
>  	pfc: pfc at fffc0000 {
>  		compatible = "renesas,pfc-r8a7779";
>  		reg = <0xfffc0000 0x23c>;

-- 
Regards,

Laurent Pinchart
