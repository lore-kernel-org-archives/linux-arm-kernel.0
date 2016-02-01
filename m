From: shawnguo@kernel.org (Shawn Guo)
Date: Mon, 1 Feb 2016 22:04:20 +0800
Subject: [PATCH net-next 40/40] ARM: dts: imx6qdl-nitrogen6_max: add phy
 interrupt to eliminate polling
In-Reply-To: <1454016364-30985-41-git-send-email-troy.kisky@boundarydevices.com>
References: <1454016364-30985-1-git-send-email-troy.kisky@boundarydevices.com>
 <1454016364-30985-41-git-send-email-troy.kisky@boundarydevices.com>
Message-ID: <20160201140420.GL10671@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 28, 2016 at 02:26:04PM -0700, Troy Kisky wrote:
> Signed-off-by: Troy Kisky <troy.kisky@boundarydevices.com>
> ---
>  arch/arm/boot/dts/imx6qdl-nitrogen6_max.dtsi | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/imx6qdl-nitrogen6_max.dtsi b/arch/arm/boot/dts/imx6qdl-nitrogen6_max.dtsi
> index a35d54f..771f650 100644
> --- a/arch/arm/boot/dts/imx6qdl-nitrogen6_max.dtsi
> +++ b/arch/arm/boot/dts/imx6qdl-nitrogen6_max.dtsi
> @@ -386,6 +386,15 @@
>  	interrupts-extended = <&gpio1 6 IRQ_TYPE_LEVEL_HIGH>,
>  			      <&intc 0 119 IRQ_TYPE_LEVEL_HIGH>;
>  	status = "okay";
> +	phy-handle = <&ethphy>;

Please keep 'status' at the bottom of the property list.

Shawn

> +	mdio {
> +		#address-cells = <0>;
> +		#size-cells = <1>;
> +		ethphy: ethernet-phy at 6 {
> +			reg = <6>;
> +			interrupts-extended = <&gpio1 28 IRQ_TYPE_LEVEL_LOW>;
> +		};
> +	};
>  };
>  
>  &hdmi {
> -- 
> 2.5.0
> 
> 
