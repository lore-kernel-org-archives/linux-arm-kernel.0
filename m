From: b32955@freescale.com (Huang Shijie)
Date: Thu, 9 May 2013 18:38:45 +0800
Subject: [PATCH 1/5] ARM: dts: imx6q: add a new device node for ecspi1
In-Reply-To: <1368070143-1655-2-git-send-email-b32955@freescale.com>
References: <1368070143-1655-1-git-send-email-b32955@freescale.com>
 <1368070143-1655-2-git-send-email-b32955@freescale.com>
Message-ID: <518B7CB5.5040808@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

? 2013?05?09? 11:28, Huang Shijie ??:
> Signed-off-by: Huang Shijie <b32955@freescale.com>
> ---
>  arch/arm/boot/dts/imx6q.dtsi |   11 +++++++++++
>  1 files changed, 11 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/boot/dts/imx6q.dtsi b/arch/arm/boot/dts/imx6q.dtsi
> index ed11bcf..5601026 100644
> --- a/arch/arm/boot/dts/imx6q.dtsi
> +++ b/arch/arm/boot/dts/imx6q.dtsi
> @@ -59,6 +59,17 @@
>  	soc {
>  		aips-bus at 02000000 { /* AIPS1 */
>  			spba-bus at 02000000 {
> +				ecspi1: ecspi at 02008000 {
> +					#address-cells = <1>;
> +					#size-cells = <0>;
> +					compatible = "fsl,imx6q-ecspi", "fsl,imx51-ecspi";
> +					reg = <0x02008000 0x4000>;
> +					interrupts = <0 31 0x04>;
> +					clocks = <&clks 112>, <&clks 112>;
> +					clock-names = "ipg", "per";
> +					status = "disabled";
> +				};
> +
>  				ecspi5: ecspi at 02018000 {
>  					#address-cells = <1>;
>  					#size-cells = <0>;
Please ignore this single patch.

the eCSPI1 has been added in the imx6qdl.dtsi.

so this patch is redundant.

thanks
Huang Shijie
