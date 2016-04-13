From: yunhui.cui@nxp.com (Yunhui Cui)
Date: Wed, 13 Apr 2016 02:12:11 +0000
Subject: [PATCH] dts/ls1043a-rdb: add the DTS for DSPI support
In-Reply-To: <20160413015313.GC28903@tiger>
References: <1456897935-40507-1-git-send-email-B56489@freescale.com>
 <20160413015313.GC28903@tiger>
Message-ID: <DB5PR0401MB19128790EBA4E995AAC665EE94960@DB5PR0401MB1912.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shawn,

Many thanks !

Thanks
Yunhui 

-----Original Message-----
From: Shawn Guo [mailto:shawnguo at kernel.org] 
Sent: Wednesday, April 13, 2016 9:53 AM
To: Yunhui Cui
Cc: robh+dt at kernel.org; pawel.moll at arm.com; mark.rutland at arm.com; ijc+devicetree at hellion.org.uk; galak at codeaurora.org; Yao Yuan; leoli at freescale.com; linux-kernel at vger.kernel.org; linux-arm-kernel at lists.infradead.org; devicetree at vger.kernel.org
Subject: Re: [PATCH] dts/ls1043a-rdb: add the DTS for DSPI support

On Wed, Mar 02, 2016 at 01:52:15PM +0800, Yunhui Cui wrote:
> This patch adds dts nodes for DSPI on LS1043A-RDB.
> 
> Signed-off-by: Yunhui Cui <B56489@freescale.com>
> Signed-off-by: Yuan Yao <yao.yuan@nxp.com>

The patch subject prefix should be like 'arm64: dts: ls1043a-rdb: '.  I fixed it up and applied the patch.

Shawn

> ---
>  arch/arm64/boot/dts/freescale/fsl-ls1043a-rdb.dts | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1043a-rdb.dts 
> b/arch/arm64/boot/dts/freescale/fsl-ls1043a-rdb.dts
> index ce23557..f895fc0 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-ls1043a-rdb.dts
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls1043a-rdb.dts
> @@ -107,6 +107,19 @@
>  		};
>  };
>  
> +&dspi0 {
> +	bus-num = <0>;
> +	status = "okay";
> +
> +	flash at 0 {
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		compatible = "n25q128a13", "jedec,spi-nor";  /* 16MB */
> +		reg = <0>;
> +		spi-max-frequency = <1000000>; /* input clock */
> +	};
> +};
> +
>  &duart0 {
>  	status = "okay";
>  };
> --
> 2.1.0.27.g96db324
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
