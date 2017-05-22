From: stefan@agner.ch (Stefan Agner)
Date: Mon, 22 May 2017 09:20:18 -0700
Subject: [PATCH] ARM: dts: vf610-zii-dev-rev-b: add hi8435 device
In-Reply-To: <20170522131010.3537-1-nikita.yoush@cogentembedded.com>
References: <20170522131010.3537-1-nikita.yoush@cogentembedded.com>
Message-ID: <a74ee28c1c62fee5a5e75dda70a02990@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2017-05-22 06:10, Nikita Yushchenko wrote:
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
> diff --git a/arch/arm/boot/dts/vf610-zii-dev-rev-b.dts
> b/arch/arm/boot/dts/vf610-zii-dev-rev-b.dts
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
> +	bus-num = <1>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_dspi2>;
> +	status = "okay";
> +	spi-num-chipselects = <2>;
> +
> +	hi8435 at 1 {
> +		compatible = "holt,hi8435";
> +		reg = <1>;
> +		spi-max-frequency = <20000000>;
> +		gpios = <&gpio5 3 0>;

Nit: GPIO_ACTIVE_HIGH instead of 0?

--
Stefan

> +	};
> +};
> +
>  &i2c0 {
>  	clock-frequency = <100000>;
>  	pinctrl-names = "default";
