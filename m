From: shawnguo@kernel.org (Shawn Guo)
Date: Tue, 19 May 2015 13:58:56 +0800
Subject: [PATCH] ARM: dts: imx6dl-wandboard: Do not hardcode memory size
In-Reply-To: <1431980424-11929-1-git-send-email-festevam@gmail.com>
References: <1431980424-11929-1-git-send-email-festevam@gmail.com>
Message-ID: <20150519055856.GQ1071@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 18, 2015 at 05:20:24PM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
> 
> imx6dl-wandboard.dtb works for wandboard dual-lite and solo boards.
> 
> Wandboard dual-lite has 1 GB of RAM and wandboard solo has 512 MB, so
> do not hardcode the memory size in the dts file and let the bootloader
> pass the correct memory size instead.

This is a configuration for dual-lite board.  If solo board wants to
reuse it, the bootloader should just fix up things for solo board.

Shawn

> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> ---
>  arch/arm/boot/dts/imx6dl-wandboard.dts | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/imx6dl-wandboard.dts b/arch/arm/boot/dts/imx6dl-wandboard.dts
> index bbb6167..dcde3f6 100644
> --- a/arch/arm/boot/dts/imx6dl-wandboard.dts
> +++ b/arch/arm/boot/dts/imx6dl-wandboard.dts
> @@ -15,8 +15,4 @@
>  / {
>  	model = "Wandboard i.MX6 Dual Lite Board";
>  	compatible = "wand,imx6dl-wandboard", "fsl,imx6dl";
> -
> -	memory {
> -		reg = <0x10000000 0x40000000>;
> -	};
>  };
> -- 
> 1.9.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
