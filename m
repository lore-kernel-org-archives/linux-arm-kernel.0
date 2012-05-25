From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 25 May 2012 10:27:44 +0800
Subject: [PATCH] ARM: mx28: add gpmi-nand dt support
In-Reply-To: <1337856338-24723-1-git-send-email-b32955@freescale.com>
References: <1337856338-24723-1-git-send-email-b32955@freescale.com>
Message-ID: <20120525022741.GA3332@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 24, 2012 at 06:45:38PM +0800, Huang Shijie wrote:
> add gpmi-nand device tree support.
> Also enable the gpmi support for mx28-evk board.
> 
> Signed-off-by: Huang Shijie <b32955@freescale.com>
> ---
>  arch/arm/boot/dts/imx28-evk.dts |    4 ++++
>  arch/arm/boot/dts/imx28.dtsi    |   18 +++++++++---------
>  2 files changed, 13 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/imx28-evk.dts b/arch/arm/boot/dts/imx28-evk.dts
> index ee520a5..5fff6c9 100644
> --- a/arch/arm/boot/dts/imx28-evk.dts
> +++ b/arch/arm/boot/dts/imx28-evk.dts
> @@ -22,6 +22,10 @@
>  
>  	apb at 80000000 {
>  		apbh at 80000000 {
> +			gpmi-nand at 8000c000 {

I guess you need to set up pins here.

Regards,
Shawn

> +				status = "okay";
> +			};
> +
>  			ssp0: ssp at 80010000 {
>  				compatible = "fsl,imx28-mmc";
>  				pinctrl-names = "default";
