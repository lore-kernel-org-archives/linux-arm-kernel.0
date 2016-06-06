From: shawnguo@kernel.org (Shawn Guo)
Date: Mon, 6 Jun 2016 16:22:10 +0800
Subject: [PATCH 1/2] ARM: dts: imx6ul: Specify the SAI index
In-Reply-To: <1462324321-11060-1-git-send-email-festevam@gmail.com>
References: <1462324321-11060-1-git-send-email-festevam@gmail.com>
Message-ID: <20160606082210.GC25018@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 03, 2016 at 10:12:00PM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@nxp.com>
> 
> Introduce the "sai-index" property to indicate the index of the SAI port.
> 
> This is useful for enabling the SAI_MCLK output as we need to write
> to bits 19, 20 and 21 of register GPR1 for enabling SAI1, SAI2 and SAI3,
> respectively.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
> ---
>  arch/arm/boot/dts/imx6ul.dtsi | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/imx6ul.dtsi b/arch/arm/boot/dts/imx6ul.dtsi
> index 4356b65..b11d5a8 100644
> --- a/arch/arm/boot/dts/imx6ul.dtsi
> +++ b/arch/arm/boot/dts/imx6ul.dtsi
> @@ -281,6 +281,7 @@
>  					dmas = <&sdma 35 24 0>,
>  					       <&sdma 36 24 0>;
>  					dma-names = "rx", "tx";
> +					sai-index = <1>;

Is the property documented or supported by kernel?

Shawn

>  					status = "disabled";
>  				};
>  
> @@ -296,6 +297,7 @@
>  					dmas = <&sdma 37 24 0>,
>  					       <&sdma 38 24 0>;
>  					dma-names = "rx", "tx";
> +					sai-index = <2>;
>  					status = "disabled";
>  				};
>  
> @@ -311,6 +313,7 @@
>  					dmas = <&sdma 39 24 0>,
>  					       <&sdma 40 24 0>;
>  					dma-names = "rx", "tx";
> +					sai-index = <3>;
>  					status = "disabled";
>  				};
>  			};
> -- 
> 1.9.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
