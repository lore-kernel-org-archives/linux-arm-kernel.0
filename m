From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Wed, 30 Apr 2014 02:58:21 +0200
Subject: [PATCH v5 04/11] ARM: shmobile: r7s72100: add scif nodes to dtsi
In-Reply-To: <1398765822-2314-5-git-send-email-wsa@the-dreams.de>
References: <1398765822-2314-1-git-send-email-wsa@the-dreams.de>
 <1398765822-2314-5-git-send-email-wsa@the-dreams.de>
Message-ID: <4363543.Ma69ibRefE@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Wolfram,

Thank you for the patches.

On Tuesday 29 April 2014 12:03:35 Wolfram Sang wrote:
> From: Wolfram Sang <wsa+renesas@sang-engineering.com>
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
>  arch/arm/boot/dts/r7s72100.dtsi | 96 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 96 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/r7s72100.dtsi
> b/arch/arm/boot/dts/r7s72100.dtsi index 5a6e2481b567..a4a67380b0a2 100644
> --- a/arch/arm/boot/dts/r7s72100.dtsi
> +++ b/arch/arm/boot/dts/r7s72100.dtsi
> @@ -200,6 +200,102 @@
>  		status = "disabled";
>  	};
> 
> +	scif0: serial at e8007000 {
> +		compatible = "renesas,scif-r7s72100", "renesas,scif";
> +		reg = <0xe8007000 64>;
> +		interrupts = <0 190 IRQ_TYPE_LEVEL_HIGH>,
> +			     <0 191 IRQ_TYPE_LEVEL_HIGH>,
> +			     <0 192 IRQ_TYPE_LEVEL_HIGH>,
> +			     <0 189 IRQ_TYPE_LEVEL_HIGH>;
> +		clocks = <&mstp4_clks R7S72100_CLK_SCIF0>;
> +		clock-names = "sci_ick";

I've just sent a patch set that removes the interface clock from the SCI 
driver in favour of the functional clock. I can't test the patch set this week 
as I'm traveling and don't have access to the hardware. I've asked Simon to 
test it with his SCI DT enabling patches for r8a7779. If not problem is found, 
I'd like that series to go in first to avoid dependencies on sci_ick in the 
device tree. Could you then rebase this patch on top of that, and rename 
sci_ick to fck ?

Apart from that, for the whole series,

Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> +		status = "disabled";
> +	};
> +
> +	scif1: serial at e8007800 {
> +		compatible = "renesas,scif-r7s72100", "renesas,scif";
> +		reg = <0xe8007800 64>;
> +		interrupts = <0 194 IRQ_TYPE_LEVEL_HIGH>,
> +			     <0 195 IRQ_TYPE_LEVEL_HIGH>,
> +			     <0 196 IRQ_TYPE_LEVEL_HIGH>,
> +			     <0 193 IRQ_TYPE_LEVEL_HIGH>;
> +		clocks = <&mstp4_clks R7S72100_CLK_SCIF1>;
> +		clock-names = "sci_ick";
> +		status = "disabled";
> +	};
> +
> +	scif2: serial at e8008000 {
> +		compatible = "renesas,scif-r7s72100", "renesas,scif";
> +		reg = <0xe8008000 64>;
> +		interrupts = <0 198 IRQ_TYPE_LEVEL_HIGH>,
> +			     <0 199 IRQ_TYPE_LEVEL_HIGH>,
> +			     <0 200 IRQ_TYPE_LEVEL_HIGH>,
> +			     <0 197 IRQ_TYPE_LEVEL_HIGH>;
> +		clocks = <&mstp4_clks R7S72100_CLK_SCIF2>;
> +		clock-names = "sci_ick";
> +		status = "disabled";
> +	};
> +
> +	scif3: serial at e8008800 {
> +		compatible = "renesas,scif-r7s72100", "renesas,scif";
> +		reg = <0xe8008800 64>;
> +		interrupts = <0 202 IRQ_TYPE_LEVEL_HIGH>,
> +			     <0 203 IRQ_TYPE_LEVEL_HIGH>,
> +			     <0 204 IRQ_TYPE_LEVEL_HIGH>,
> +			     <0 201 IRQ_TYPE_LEVEL_HIGH>;
> +		clocks = <&mstp4_clks R7S72100_CLK_SCIF3>;
> +		clock-names = "sci_ick";
> +		status = "disabled";
> +	};
> +
> +	scif4: serial at e8009000 {
> +		compatible = "renesas,scif-r7s72100", "renesas,scif";
> +		reg = <0xe8009000 64>;
> +		interrupts = <0 206 IRQ_TYPE_LEVEL_HIGH>,
> +			     <0 207 IRQ_TYPE_LEVEL_HIGH>,
> +			     <0 208 IRQ_TYPE_LEVEL_HIGH>,
> +			     <0 205 IRQ_TYPE_LEVEL_HIGH>;
> +		clocks = <&mstp4_clks R7S72100_CLK_SCIF4>;
> +		clock-names = "sci_ick";
> +		status = "disabled";
> +	};
> +
> +	scif5: serial at e8009800 {
> +		compatible = "renesas,scif-r7s72100", "renesas,scif";
> +		reg = <0xe8009800 64>;
> +		interrupts = <0 210 IRQ_TYPE_LEVEL_HIGH>,
> +			     <0 211 IRQ_TYPE_LEVEL_HIGH>,
> +			     <0 212 IRQ_TYPE_LEVEL_HIGH>,
> +			     <0 209 IRQ_TYPE_LEVEL_HIGH>;
> +		clocks = <&mstp4_clks R7S72100_CLK_SCIF5>;
> +		clock-names = "sci_ick";
> +		status = "disabled";
> +	};
> +
> +	scif6: serial at e800a000 {
> +		compatible = "renesas,scif-r7s72100", "renesas,scif";
> +		reg = <0xe800a000 64>;
> +		interrupts = <0 214 IRQ_TYPE_LEVEL_HIGH>,
> +			     <0 215 IRQ_TYPE_LEVEL_HIGH>,
> +			     <0 216 IRQ_TYPE_LEVEL_HIGH>,
> +			     <0 213 IRQ_TYPE_LEVEL_HIGH>;
> +		clocks = <&mstp4_clks R7S72100_CLK_SCIF6>;
> +		clock-names = "sci_ick";
> +		status = "disabled";
> +	};
> +
> +	scif7: serial at e800a800 {
> +		compatible = "renesas,scif-r7s72100", "renesas,scif";
> +		reg = <0xe800a800 64>;
> +		interrupts = <0 218 IRQ_TYPE_LEVEL_HIGH>,
> +			     <0 219 IRQ_TYPE_LEVEL_HIGH>,
> +			     <0 220 IRQ_TYPE_LEVEL_HIGH>,
> +			     <0 217 IRQ_TYPE_LEVEL_HIGH>;
> +		clocks = <&mstp4_clks R7S72100_CLK_SCIF7>;
> +		clock-names = "sci_ick";
> +		status = "disabled";
> +	};
> +
>  	spi0: spi at e800c800 {
>  		compatible = "renesas,rspi-r7s72100", "renesas,rspi-rz";
>  		reg = <0xe800c800 0x24>;

-- 
Regards,

Laurent Pinchart
