From: jacopo@jmondi.org (jacopo mondi)
Date: Tue, 15 May 2018 10:23:10 +0200
Subject: [PATCH v2] ARM: dts: r8a7740: Add CEU1
In-Reply-To: <20180515080038.7438-1-horms+renesas@verge.net.au>
References: <20180515080038.7438-1-horms+renesas@verge.net.au>
Message-ID: <20180515082310.GQ5956@w540>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Simon,

On Tue, May 15, 2018 at 10:00:38AM +0200, Simon Horman wrote:
> Describe CEU1 peripheral for Renesas R-Mobile A1 R8A7740 Soc.
>
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

Reviewed-by: Jacopo Mondi <jacopo+renesas@jmondi.org>

Thank you!
   j

> ---
> v2
> * Correct register range start address
>
>   Based on renesas-devel-20180514-v4.17-rc5
> ---
>  arch/arm/boot/dts/r8a7740.dtsi | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/arch/arm/boot/dts/r8a7740.dtsi b/arch/arm/boot/dts/r8a7740.dtsi
> index 508d93440ee8..35e2fc957458 100644
> --- a/arch/arm/boot/dts/r8a7740.dtsi
> +++ b/arch/arm/boot/dts/r8a7740.dtsi
> @@ -77,6 +77,16 @@
>  		status = "disabled";
>  	};
>
> +	ceu1: ceu at fe914000 {
> +		reg = <0xfe914000 0x3000>;
> +		compatible = "renesas,r8a7740-ceu";
> +		interrupts = <GIC_SPI 159 IRQ_TYPE_LEVEL_HIGH>;
> +		clocks = <&mstp1_clks R8A7740_CLK_CEU21>;
> +		clock-names = "ceu21";
> +		power-domains = <&pd_a4r>;
> +		status = "disabled";
> +	};
> +
>  	cmt1: timer at e6138000 {
>  		compatible = "renesas,cmt-48-r8a7740", "renesas,cmt-48";
>  		reg = <0xe6138000 0x170>;
> --
> 2.11.0
>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180515/4878e59e/attachment.sig>
