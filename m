From: vladimir_zapolskiy@mentor.com (Vladimir Zapolskiy)
Date: Thu, 31 May 2018 11:33:43 +0300
Subject: [PATCH v4 5/5] ARM: dts: imx6qdl: add missing compatible and
 clock properties for EPIT
In-Reply-To: <20180530120327.27681-6-peron.clem@gmail.com>
References: <20180530120327.27681-1-peron.clem@gmail.com>
 <20180530120327.27681-6-peron.clem@gmail.com>
Message-ID: <a4042956-24e1-6132-4606-b5b8f4e30023@mentor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/30/2018 03:03 PM, Cl?ment P?ron wrote:
> From: Colin Didier <colin.didier@devialet.com>
> 
> Add missing compatible and clock properties for EPIT node.
> 
> Signed-off-by: Colin Didier <colin.didier@devialet.com>
> Signed-off-by: Cl?ment Peron <clement.peron@devialet.com>
> Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
> ---
>  arch/arm/boot/dts/imx6qdl.dtsi | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
> index c003e62bf290..0feec516847a 100644
> --- a/arch/arm/boot/dts/imx6qdl.dtsi
> +++ b/arch/arm/boot/dts/imx6qdl.dtsi
> @@ -844,13 +844,23 @@
>  			};
>  
>  			epit1: epit at 20d0000 { /* EPIT1 */

epit1: timer at 20d0000 { ...

And /* EPIT1 */ comment can be removed, it is quite clear from the same
line context.

Formally it is a subject to another patch, but I think this can be
accepted as a part of this one.

> +				compatible = "fsl,imx6q-epit", "fsl,imx31-epit";
>  				reg = <0x020d0000 0x4000>;
>  				interrupts = <0 56 IRQ_TYPE_LEVEL_HIGH>;
> +				clocks = <&clks IMX6QDL_CLK_IPG_PER>,
> +					 <&clks IMX6QDL_CLK_EPIT1>;
> +				clock-names = "ipg", "per";
> +				status = "disabled";
>  			};
>  
>  			epit2: epit at 20d4000 { /* EPIT2 */

Same as above.

> +				compatible = "fsl,imx6q-epit", "fsl,imx31-epit";
>  				reg = <0x020d4000 0x4000>;
>  				interrupts = <0 57 IRQ_TYPE_LEVEL_HIGH>;
> +				clocks = <&clks IMX6QDL_CLK_IPG_PER>,
> +					 <&clks IMX6QDL_CLK_EPIT2>;
> +				clock-names = "ipg", "per";
> +				status = "disabled";
>  			};
>  
>  			src: src at 20d8000 {
> 

--
With best wishes,
Vladimir
