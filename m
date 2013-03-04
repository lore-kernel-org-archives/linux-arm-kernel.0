From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 4 Mar 2013 11:17:18 +0800
Subject: [PATCH 1/3] ARM: dts: imx28-evk: Enable touchscreen support
In-Reply-To: <1360337803-19858-1-git-send-email-festevam@gmail.com>
References: <1360337803-19858-1-git-send-email-festevam@gmail.com>
Message-ID: <20130304031716.GC30431@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 08, 2013 at 01:36:41PM -0200, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
> 
> Provide 'lradc-touchscreen-wires' property to the LRADC driver, so that 
> touchscreen can be functional.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> ---
>  arch/arm/boot/dts/imx28-evk.dts |    1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/boot/dts/imx28-evk.dts b/arch/arm/boot/dts/imx28-evk.dts
> index 2da316e..5960578 100644
> --- a/arch/arm/boot/dts/imx28-evk.dts
> +++ b/arch/arm/boot/dts/imx28-evk.dts
> @@ -155,6 +155,7 @@
>  			};
>  
>  			lradc at 80050000 {
> +				fsl,lradc-touchscreen-wires = <4>;

I do not understand why.  But it seems to me that applying the patch on
top of v3.9-rc1 results in a silent audio playback on my imx28-evk
board.  Can you confirm that on your side?

Shawn

>  				status = "okay";
>  			};
>  
> -- 
> 1.7.9.5
> 
