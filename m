From: shawnguo@kernel.org (Shawn Guo)
Date: Tue, 15 May 2018 15:12:01 +0800
Subject: [PATCH] ARM: dts: imx6qdl-phytec-pfla02: Use IRQ_TYPE specifier
In-Reply-To: <1526254115-3999-1-git-send-email-hernan@vanguardiasur.com.ar>
References: <1526254115-3999-1-git-send-email-hernan@vanguardiasur.com.ar>
Message-ID: <20180515071200.GO26863@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, May 13, 2018 at 08:28:35PM -0300, Hern?n Gonzalez wrote:
> Replace magic number with the proper IRQ_TYPE specifier to improve DT
> readability.
> 
> Signed-off-by: Hern?n Gonzalez <hernan@vanguardiasur.com.ar>
> ---
>  arch/arm/boot/dts/imx6qdl-phytec-pfla02.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/imx6qdl-phytec-pfla02.dtsi b/arch/arm/boot/dts/imx6qdl-phytec-pfla02.dtsi
> index c58f344..1b79ee7 100644
> --- a/arch/arm/boot/dts/imx6qdl-phytec-pfla02.dtsi
> +++ b/arch/arm/boot/dts/imx6qdl-phytec-pfla02.dtsi
> @@ -115,7 +115,7 @@
>  		compatible = "dlg,da9063";
>  		reg = <0x58>;
>  		interrupt-parent = <&gpio2>;
> -		interrupts = <9 0x8>; /* active-low GPIO2_9 */
> +		interrupts = <9 IRQ_TYPE_LOW_LEVEL>; /* active-low GPIO2_9 */

It should be IRQ_TYPE_LEVEL_LOW.  I fixed it up and applied the patch.

Shawn

>  
>  		regulators {
>  			vddcore_reg: bcore1 {
> -- 
> 2.7.4
> 
