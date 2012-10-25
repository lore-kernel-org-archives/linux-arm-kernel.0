From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 25 Oct 2012 15:16:34 +0800
Subject: [PATCH] ARM: dts: mxs: add the "clock-names" for gpmi-nand
In-Reply-To: <1349864829-19565-1-git-send-email-b32955@freescale.com>
References: <201210101237.13640.marex@denx.de>
 <1349864829-19565-1-git-send-email-b32955@freescale.com>
Message-ID: <20121025071629.GD2464@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof,

Can you please apply this fix for -rc?  Otherwise, please let me know
if you prefer to get a pull request from me.

Shawn

On Wed, Oct 10, 2012 at 06:27:09PM +0800, Huang Shijie wrote:
> The current DT nodes for mx23/mx28 miss the `clocks-names` item for gpmi-nand.
> So the gpmi-nand driver could not find the proper clock.
> 
> This patch fixes this issue.
> 
> Signed-off-by: Huang Shijie <b32955@freescale.com>
> ---
>  arch/arm/boot/dts/imx23.dtsi |    1 +
>  arch/arm/boot/dts/imx28.dtsi |    1 +
>  2 files changed, 2 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/imx23.dtsi b/arch/arm/boot/dts/imx23.dtsi
> index 9ca4ca7..6d31aa3 100644
> --- a/arch/arm/boot/dts/imx23.dtsi
> +++ b/arch/arm/boot/dts/imx23.dtsi
> @@ -69,6 +69,7 @@
>  				interrupts = <13>, <56>;
>  				interrupt-names = "gpmi-dma", "bch";
>  				clocks = <&clks 34>;
> +				clock-names = "gpmi_io";
>  				fsl,gpmi-dma-channel = <4>;
>  				status = "disabled";
>  			};
> diff --git a/arch/arm/boot/dts/imx28.dtsi b/arch/arm/boot/dts/imx28.dtsi
> index e16d631..55c57ea 100644
> --- a/arch/arm/boot/dts/imx28.dtsi
> +++ b/arch/arm/boot/dts/imx28.dtsi
> @@ -85,6 +85,7 @@
>  				interrupts = <88>, <41>;
>  				interrupt-names = "gpmi-dma", "bch";
>  				clocks = <&clks 50>;
> +				clock-names = "gpmi_io";
>  				fsl,gpmi-dma-channel = <4>;
>  				status = "disabled";
>  			};
> -- 
> 1.7.0.4
> 
> 
