From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Wed, 14 Feb 2018 00:04:25 +0200
Subject: [PATCH v2 4/4] arm64: dts: renesas: r8a7796: Fix register
 mappings on VSPs
In-Reply-To: <1518550237-16753-5-git-send-email-kbingham@kernel.org>
References: <1518550237-16753-1-git-send-email-kbingham@kernel.org>
 <1518550237-16753-5-git-send-email-kbingham@kernel.org>
Message-ID: <2359831.uGrFDBvd62@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kieran,

Thank you for the patch.

On Tuesday, 13 February 2018 21:30:37 EET Kieran Bingham wrote:
> From: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
> 
> The VSPD includes a CLUT on RPF2. Ensure that the register space is
> mapped correctly to support this.
> 
> Signed-off-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
>  arch/arm64/boot/dts/renesas/r8a7796.dtsi | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/renesas/r8a7796.dtsi
> b/arch/arm64/boot/dts/renesas/r8a7796.dtsi index 60755117cba5..3fe5566e0630
> 100644
> --- a/arch/arm64/boot/dts/renesas/r8a7796.dtsi
> +++ b/arch/arm64/boot/dts/renesas/r8a7796.dtsi
> @@ -2285,7 +2285,7 @@
> 
>  		vspd0: vsp at fea20000 {
>  			compatible = "renesas,vsp2";
> -			reg = <0 0xfea20000 0 0x4000>;
> +			reg = <0 0xfea20000 0 0x8000>;
>  			interrupts = <GIC_SPI 466 IRQ_TYPE_LEVEL_HIGH>;
>  			clocks = <&cpg CPG_MOD 623>;
>  			power-domains = <&sysc R8A7796_PD_ALWAYS_ON>;
> @@ -2305,7 +2305,7 @@
> 
>  		vspd1: vsp at fea28000 {
>  			compatible = "renesas,vsp2";
> -			reg = <0 0xfea28000 0 0x4000>;
> +			reg = <0 0xfea28000 0 0x8000>;
>  			interrupts = <GIC_SPI 467 IRQ_TYPE_LEVEL_HIGH>;
>  			clocks = <&cpg CPG_MOD 622>;
>  			power-domains = <&sysc R8A7796_PD_ALWAYS_ON>;
> @@ -2325,7 +2325,7 @@
> 
>  		vspd2: vsp at fea30000 {
>  			compatible = "renesas,vsp2";
> -			reg = <0 0xfea30000 0 0x4000>;
> +			reg = <0 0xfea30000 0 0x8000>;
>  			interrupts = <GIC_SPI 468 IRQ_TYPE_LEVEL_HIGH>;
>  			clocks = <&cpg CPG_MOD 621>;
>  			power-domains = <&sysc R8A7796_PD_ALWAYS_ON>;

-- 
Regards,

Laurent Pinchart
