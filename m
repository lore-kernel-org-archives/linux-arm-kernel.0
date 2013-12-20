From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 20 Dec 2013 10:32:50 +0800
Subject: [PATCH] ARM: dts: imx6qdl: Use 'vddarm' as the regulator name
In-Reply-To: <1387494532-25752-1-git-send-email-festevam@gmail.com>
References: <1387494532-25752-1-git-send-email-festevam@gmail.com>
Message-ID: <20131220023246.GK7172@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 19, 2013 at 09:08:52PM -0200, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
> 
> Instead of calling the regulator for the ARM core as 'cpu', let's rename it
> as 'vddarm', so that we keep a better consistency with the other internal
> regulators:
> 
> vdd1p1: 800 <--> 1375 mV at 1100 mV                                             
> vdd3p0: 2800 <--> 3150 mV at 3000 mV                                            
> vdd2p5: 2000 <--> 2750 mV at 2400 mV                                            
> vddarm: 725 <--> 1450 mV at 1150 mV                                             
> vddpu: 725 <--> 1450 mV at 1150 mV                                              
> vddsoc: 725 <--> 1450 mV at 1200 mV
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>

I changed the patch subject prefix to be "ARM: dts: imx6:" and made the
same change on imx6sl.dtsi.  Applied, thanks.

Shawn

> ---
>  arch/arm/boot/dts/imx6qdl.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
> index 858ecd7..4f5647e 100644
> --- a/arch/arm/boot/dts/imx6qdl.dtsi
> +++ b/arch/arm/boot/dts/imx6qdl.dtsi
> @@ -513,7 +513,7 @@
>  
>  				reg_arm: regulator-vddcore at 140 {
>  					compatible = "fsl,anatop-regulator";
> -					regulator-name = "cpu";
> +					regulator-name = "vddarm";
>  					regulator-min-microvolt = <725000>;
>  					regulator-max-microvolt = <1450000>;
>  					regulator-always-on;
> -- 
> 1.8.1.2
> 
