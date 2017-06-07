From: andy.tang@nxp.com (Andy Tang)
Date: Wed, 7 Jun 2017 02:38:36 +0000
Subject: [PATCH] arm64: dts: ls1088a: update sata node
In-Reply-To: <20170605151441.GL4094@dragon>
References: <1496648752-27627-1-git-send-email-andy.tang@nxp.com>
 <20170605151441.GL4094@dragon>
Message-ID: <HE1PR0402MB2828961E8052683E75B59D5CF3C80@HE1PR0402MB2828.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shawn,

Please see the explanation below.

-----Original Message-----
From: Shawn Guo [mailto:shawnguo at kernel.org] 
Sent: Monday, June 05, 2017 11:15 PM
To: Andy Tang <andy.tang@nxp.com>
Cc: mark.rutland at arm.com; catalin.marinas at arm.com; will.deacon at arm.com; robh+dt at kernel.org; linux-arm-kernel at lists.infradead.org
Subject: Re: [PATCH] arm64: dts: ls1088a: update sata node

On Mon, Jun 05, 2017 at 03:45:52PM +0800, Yuantian Tang wrote:
> 1. Remove ls1043a compatible string from node

Can you explain a bit why the compatible string needs to be dropped?

A:  We thought ls1088 and ls1043 are 100% compatible in regard to sata.
But actually, they are not because their ecc register address is different.

Please let me know if I need to add those to commit message.

Thanks,
Andy

> 2. Fix the sata ecc register address error
> 
> Signed-off-by: Tang Yuantian <andy.tang@nxp.com>
> ---
>  arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
> index df16284..c144d06 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
> @@ -360,9 +360,9 @@
>  		};
>  
>  		sata: sata at 3200000 {
> -			compatible = "fsl,ls1088a-ahci", "fsl,ls1043a-ahci";
> +			compatible = "fsl,ls1088a-ahci";
>  			reg = <0x0 0x3200000 0x0 0x10000>,
> -				<0x0 0x20140520 0x0 0x4>;
> +				<0x7 0x100520 0x0 0x4>;
>  			reg-names = "ahci", "sata-ecc";
>  			interrupts = <0 133 IRQ_TYPE_LEVEL_HIGH>;
>  			clocks = <&clockgen 4 3>;
> -- 
> 2.1.0.27.g96db324
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
