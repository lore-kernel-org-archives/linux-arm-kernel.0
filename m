From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 24 Dec 2013 13:48:10 +0800
Subject: [PATCH] ARM: dts: imx6qdl: Pass "fsl,imx6q-mmdc" to MMDC1 port
In-Reply-To: <1387812797-22082-1-git-send-email-festevam@gmail.com>
References: <1387812797-22082-1-git-send-email-festevam@gmail.com>
Message-ID: <20131224054809.GE3872@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 23, 2013 at 01:33:17PM -0200, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
> 
> Currently only MMDC0 port passes the "compatible = "fsl,imx6q-mmdc".
> 
> Do the same for MMDC1.
> 
> Basically all that 'fsl,imx6q-mmdc' does is to clear the PSD bit of MMDCx_MAPSR
> register, so do the same for MMDC1.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> ---
>  arch/arm/boot/dts/imx6qdl.dtsi | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
> index 8a7ce97..18f29def 100644
> --- a/arch/arm/boot/dts/imx6qdl.dtsi
> +++ b/arch/arm/boot/dts/imx6qdl.dtsi
> @@ -833,6 +833,7 @@
>  			};
>  
>  			mmdc1: mmdc at 021b4000 { /* MMDC1 */
> +				compatible = "fsl,imx6q-mmdc";

Do you have a real usage of this change?  If not, I would defer it to
the time when we have a real use case.

Shawn

>  				reg = <0x021b4000 0x4000>;
>  			};
>  
> -- 
> 1.8.1.2
> 
