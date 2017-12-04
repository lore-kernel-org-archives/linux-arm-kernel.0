From: gary.bisson@boundarydevices.com (Gary Bisson)
Date: Mon, 4 Dec 2017 12:19:54 +0100
Subject: [PATCH 11/12] ARM: dts: imx6qdl-nitrogen6_max: Remove unneeded
 unit address
In-Reply-To: <1512156285-18451-11-git-send-email-festevam@gmail.com>
References: <1512156285-18451-1-git-send-email-festevam@gmail.com>
 <1512156285-18451-11-git-send-email-festevam@gmail.com>
Message-ID: <20171204111954.v7jexbtkjyaa6mhe@t450s.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Fabio,

On Fri, Dec 01, 2017 at 05:24:44PM -0200, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@nxp.com>
> 
> Remove the unneeded unit address for the i2cmux nodes in order to fix
> the following build warnings with W=1:
> 
> arch/arm/boot/dts/imx6q-nitrogen6_max.dtb: Warning (unit_address_vs_reg): Node /i2cmux at 2 has a unit name, but no reg property
> arch/arm/boot/dts/imx6q-nitrogen6_max.dtb: Warning (unit_address_vs_reg): Node /i2cmux at 3 has a unit name, but no reg property
> 
> Cc: Gary Bisson <gary.bisson@boundarydevices.com>
> Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
> ---
>  arch/arm/boot/dts/imx6qdl-nitrogen6_max.dtsi | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/imx6qdl-nitrogen6_max.dtsi b/arch/arm/boot/dts/imx6qdl-nitrogen6_max.dtsi
> index 3a77f0f..3cdffed 100644
> --- a/arch/arm/boot/dts/imx6qdl-nitrogen6_max.dtsi
> +++ b/arch/arm/boot/dts/imx6qdl-nitrogen6_max.dtsi
> @@ -172,7 +172,7 @@
>  		};
>  	};
>  
> -	i2cmux at 2 {
> +	i2cmux2 {
>  		compatible = "i2c-mux-gpio";
>  		pinctrl-names = "default";
>  		pinctrl-0 = <&pinctrl_i2c2mux>;
> @@ -196,7 +196,7 @@
>  		};
>  	};
>  
> -	i2cmux at 3 {
> +	i2cmux3 {
>  		compatible = "i2c-mux-gpio";
>  		pinctrl-names = "default";
>  		pinctrl-0 = <&pinctrl_i2c3mux>;
> -- 

What about naming it i2c2mux and i2c3mux so it is clearer those mux
happen respectively for i2c2 and i2c3?

Then I'd rename the sub-nodes i2cXmux at Y instead of i2cX at Y currently.

Let me know your thoughts.

Regards,
Gary
