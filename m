From: afaerber@suse.de (=?UTF-8?Q?Andreas_F=c3=a4rber?=)
Date: Fri, 2 Jun 2017 18:30:12 +0200
Subject: [PATCH v11 4/6] ARM: dts: imx6q-evi: support altera-ps-spi
In-Reply-To: <20170525172911.11467-5-stillcompiling@gmail.com>
References: <20170525172911.11467-1-stillcompiling@gmail.com>
 <20170525172911.11467-5-stillcompiling@gmail.com>
Message-ID: <a4d0815c-593f-57a9-41fc-ab636ca9b9e5@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Am 25.05.2017 um 19:29 schrieb Joshua Clayton:
> Add support for Altera V FPGA connected to an spi port

Did you mean "Altera Cyclone V"?

> to the evi devicetree file
> 
> Signed-off-by: Joshua Clayton <stillcompiling@gmail.com>
> ---
>  arch/arm/boot/dts/imx6q-evi.dts | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/imx6q-evi.dts b/arch/arm/boot/dts/imx6q-evi.dts
> index 24fe093a66db..a0cbb2d84803 100644
> --- a/arch/arm/boot/dts/imx6q-evi.dts
> +++ b/arch/arm/boot/dts/imx6q-evi.dts
> @@ -82,6 +82,15 @@
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&pinctrl_ecspi1 &pinctrl_ecspi1cs>;
>  	status = "okay";
> +
> +	fpga_spi: cyclonespi at 0 {

"cyclonespi" does not strike me as the best node name.

I am guessing this is a sub-node of a SPI controller node, so no need to
repeat "spi", and Cyclone seems more or less implied by "altr,fpga-".

Note that the example in the bindings doc uses "evi-fpga-spi". Nodes
don't need to be (shouldn't be?) prefixed with the board. Note that
bindings examples tend to get copied a lot.

Any reason not to just use "fpga at 0" in both places for simplicity?

> +		compatible = "altr,fpga-passive-serial";
> +		spi-max-frequency = <20000000>;
> +		reg = <0>;
> +		pinctrl-0 = <&pinctrl_fpgaspi>;
> +		nconfig-gpios = <&gpio4 9 GPIO_ACTIVE_LOW>;
> +		nstat-gpios = <&gpio4 11 GPIO_ACTIVE_LOW>;
> +	};
>  };
>  
>  &ecspi3 {
[snip]

Regards,
Andreas

-- 
SUSE Linux GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
