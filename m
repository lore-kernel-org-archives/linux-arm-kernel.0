From: shawnguo@kernel.org (Shawn Guo)
Date: Wed, 2 Dec 2015 13:48:14 +0800
Subject: [PATCH 2/2] ARM: dts: ls1021a: Add a TFT LCD panel.
In-Reply-To: <1448433967-6710-2-git-send-email-b56799@freescale.com>
References: <1448433967-6710-1-git-send-email-b56799@freescale.com>
 <1448433967-6710-2-git-send-email-b56799@freescale.com>
Message-ID: <20151202054811.GG692@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 25, 2015 at 02:46:07PM +0800, Meng Yi wrote:
> Signed-off-by: Alison Wang <b18965@freescale.com>
> Signed-off-by: Xiubo Li <lixiubo@cmss.chinamobile.com>
> Signed-off-by: Jianwei Wang <jianwei.wang.chn@gmail.com>
> ---
>  arch/arm/boot/dts/ls1021a-twr.dts | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/ls1021a-twr.dts b/arch/arm/boot/dts/ls1021a-twr.dts
> index fbb89d1..fad2e3b 100644
> --- a/arch/arm/boot/dts/ls1021a-twr.dts
> +++ b/arch/arm/boot/dts/ls1021a-twr.dts
> @@ -105,6 +105,17 @@
>  			bitclock-master;
>  		};
>  	};
> +
> +	panel: panel {
> +		compatible = "nec,nl4827hc19-05b";
> +	};
> +

This new line shouldn't be needed.

> +};
> +
> +&dcu {
> +	fsl,panel = <&panel>;
> +	status = "okay";
> +

Ditto

I fixed them up and applied the both patches.

Shawn

>  };
>  
>  &dspi1 {
> -- 
> 2.1.0.27.g96db324
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
