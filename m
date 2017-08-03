From: shawnguo@kernel.org (Shawn Guo)
Date: Thu, 3 Aug 2017 10:20:09 +0800
Subject: [PATCH] ARM: dts: i.MX25: add ranges to tscadc
In-Reply-To: <1501704371-28151-1-git-send-email-martin@kaiser.cx>
References: <1501704371-28151-1-git-send-email-martin@kaiser.cx>
Message-ID: <20170803022007.GI31819@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 02, 2017 at 10:06:11PM +0200, Martin Kaiser wrote:
> Add a ranges; line to the tscadc node. This creates a 1:1 mapping between
> the addresses used by tscadc and those in its child nodes (adc, tsc).
> 
> Without such a mapping, the reg = ... lines in the tsc and adc nodes do
> not create a resource. Probing the fsl-imx25-tcq and fsl-imx25-tsadc
> drivers will then fail since there's no IORESOURCE_MEM.
> 
> Signed-off-by: Martin Kaiser <martin@kaiser.cx>

Do we need the following Fixes tag?

Fixes: 92f651f39b42 ("ARM: dts: imx25: Add TSC and ADC support")

@Markus, we didn't the changes when we were submitting?

Shawn


> ---
>  arch/arm/boot/dts/imx25.dtsi | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/boot/dts/imx25.dtsi b/arch/arm/boot/dts/imx25.dtsi
> index 0d2f3a1..1e37bd3 100644
> --- a/arch/arm/boot/dts/imx25.dtsi
> +++ b/arch/arm/boot/dts/imx25.dtsi
> @@ -297,6 +297,7 @@
>  				#address-cells = <1>;
>  				#size-cells = <1>;
>  				status = "disabled";
> +				ranges;
>  
>  				adc: adc at 50030800 {
>  					compatible = "fsl,imx25-gcq";
> -- 
> 2.1.4
> 
