From: s.trumtrar@pengutronix.de (Steffen Trumtrar)
Date: Wed, 9 Nov 2016 08:19:47 +0100
Subject: [PATCHv3] ARM: dts: socfpga: Enable QSPI on the Cyclone5 sockit
In-Reply-To: <20161108022830.29303-1-dinguyen@kernel.org>
References: <20161108022830.29303-1-dinguyen@kernel.org>
Message-ID: <20161109071947.pup6x6rfodycjtsv@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 07, 2016 at 08:28:30PM -0600, Dinh Nguyen wrote:
> From: Dinh Nguyen <dinguyen@opensource.altera.com>
> 
> Enable the QSPI node and add the flash chip.
> 
> Signed-off-by: Dinh Nguyen <dinguyen@opensource.altera.com>
> ---
> v3: Use n25q00 for the compatible entry for the flash part and
>     tested on SoCKit
> v2: Remove partition entries for the SoCKIT
> ---
>  arch/arm/boot/dts/socfpga_cyclone5_sockit.dts | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/socfpga_cyclone5_sockit.dts b/arch/arm/boot/dts/socfpga_cyclone5_sockit.dts
> index 02e22f5..d59f6f2 100644
> --- a/arch/arm/boot/dts/socfpga_cyclone5_sockit.dts
> +++ b/arch/arm/boot/dts/socfpga_cyclone5_sockit.dts
> @@ -175,6 +175,27 @@
>  	status = "okay";
>  };
>  
> +&qspi {
> +	status = "okay";
> +
> +	flash: flash at 0 {
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		compatible = "n25q00";
> +		reg = <0>;
> +		spi-max-frequency = <100000000>;
> +
> +		m25p,fast-read;
> +		cdns,page-size = <256>;
> +		cdns,block-size = <16>;
> +		cdns,read-delay = <4>;
> +		cdns,tshsl-ns = <50>;
> +		cdns,tsd2d-ns = <50>;
> +		cdns,tchsh-ns = <4>;
> +		cdns,tslch-ns = <4>;
> +	};
> +};
> +
>  &usb1 {
>  	status = "okay";
>  };

Looks good to me.

Thanks,
Steffen

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
