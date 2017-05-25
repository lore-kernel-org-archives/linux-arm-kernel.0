From: shawnguo@kernel.org (Shawn Guo)
Date: Thu, 25 May 2017 15:00:09 +0800
Subject: [PATCH] ARM: dts: vf610-zii-dev-rev-b: add hi8435 device
In-Reply-To: <20170522131010.3537-1-nikita.yoush@cogentembedded.com>
References: <20170522131010.3537-1-nikita.yoush@cogentembedded.com>
Message-ID: <20170525070007.GU26102@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 22, 2017 at 04:10:10PM +0300, Nikita Yushchenko wrote:
> ZII dev board rev B has a Holt Hi8435 connected to dspi2.
> Add it to device tree.
> 
> ZII dev board rev C does not have that, so use rev-b dts file,
> not common dtsi file.
> 
> Signed-off-by: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
> ---
>  arch/arm/boot/dts/vf610-zii-dev-rev-b.dts | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/vf610-zii-dev-rev-b.dts b/arch/arm/boot/dts/vf610-zii-dev-rev-b.dts
> index 37f95427616f..f433465c3a7c 100644
> --- a/arch/arm/boot/dts/vf610-zii-dev-rev-b.dts
> +++ b/arch/arm/boot/dts/vf610-zii-dev-rev-b.dts
> @@ -348,6 +348,25 @@
>  	};
>  };
>  
> +&edma1 {
> +	status = "okay";
> +};
> +
> +&dspi2 {

Please keep these labelled nodes sort alphabetically.

> +	bus-num = <1>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_dspi2>;
> +	status = "okay";

We usually have 'status' line at the bottom of property list.

> +	spi-num-chipselects = <2>;
> +
> +	hi8435 at 1 {

Node name should be something generic, while label can be specific
model name.  The following form might be better.

	hi8435: sensor at 1

Shawn

> +		compatible = "holt,hi8435";
> +		reg = <1>;
> +		spi-max-frequency = <20000000>;
> +		gpios = <&gpio5 3 0>;
> +	};
> +};
> +
>  &i2c0 {
>  	clock-frequency = <100000>;
>  	pinctrl-names = "default";
> -- 
> 2.11.0
> 
