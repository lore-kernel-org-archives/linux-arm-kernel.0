From: shawnguo@kernel.org (Shawn Guo)
Date: Wed, 3 May 2017 20:57:01 +0800
Subject: [PATCH 1/3] arm64: dts: ls1046a: support SD UHS-I and eMMC HS200
 on RDB
In-Reply-To: <1492746756-12024-2-git-send-email-yangbo.lu@nxp.com>
References: <1492746756-12024-1-git-send-email-yangbo.lu@nxp.com>
 <1492746756-12024-2-git-send-email-yangbo.lu@nxp.com>
Message-ID: <20170503125659.GA24392@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 21, 2017 at 11:52:34AM +0800, Yangbo Lu wrote:
> This patch is to enable SD UHS-I mode and eMMC HS200 mode on
> LS1046ARDB in dts. Also, the eSDHC peripheral clock must be used
> instead of platform clock to support these modes.
> 
> Signed-off-by: Yangbo Lu <yangbo.lu@nxp.com>
> ---
>  arch/arm64/boot/dts/freescale/fsl-ls1046a-rdb.dts | 8 ++++++++
>  arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi    | 4 ++--
>  2 files changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1046a-rdb.dts b/arch/arm64/boot/dts/freescale/fsl-ls1046a-rdb.dts
> index d1ccc00..08528c2 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-ls1046a-rdb.dts
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls1046a-rdb.dts
> @@ -64,6 +64,14 @@
>  	};
>  };
>  
> +&esdhc {
> +	mmc-hs200-1_8v;
> +	sd-uhs-sdr104;
> +	sd-uhs-sdr50;
> +	sd-uhs-sdr25;
> +	sd-uhs-sdr12;
> +};
> +

Please sort the node alphabetically.

>  &duart0 {
>  	status = "okay";
>  };
> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
> index f4b8b7e..f06f329 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
> @@ -209,10 +209,10 @@
>  		};
>  
>  		esdhc: esdhc at 1560000 {
> -			compatible = "fsl,esdhc";
> +			compatible = "fsl,ls1046a-esdhc", "fsl,esdhc";

I do not see "fsl,ls1046a-esdhc" is a documented compatible.

Shawn

>  			reg = <0x0 0x1560000 0x0 0x10000>;
>  			interrupts = <GIC_SPI 62 IRQ_TYPE_LEVEL_HIGH>;
> -			clock-frequency = <0>;
> +			clocks = <&clockgen 2 1>;
>  			voltage-ranges = <1800 1800 3300 3300>;
>  			sdhci,auto-cmd12;
>  			big-endian;
> -- 
> 2.1.0.27.g96db324
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
