From: shawnguo@kernel.org (Shawn Guo)
Date: Tue, 1 Nov 2016 22:13:39 +0800
Subject: [PATCH 1/5] ARM: dts: imx: add Boundary Devices Nitrogen6_SOM2
 support
In-Reply-To: <20161025211955.5345-2-gary.bisson@boundarydevices.com>
References: <20161025211955.5345-1-gary.bisson@boundarydevices.com>
 <20161025211955.5345-2-gary.bisson@boundarydevices.com>
Message-ID: <20161101141338.GC9807@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 25, 2016 at 11:19:51PM +0200, Gary Bisson wrote:
> SoM based on i.MX6 Quad with 1GB of DDR3.
> 
> https://boundarydevices.com/product/nit6x-som-v2/
> 
> Signed-off-by: Gary Bisson <gary.bisson@boundarydevices.com>
> ---
>  arch/arm/boot/dts/Makefile                    |   1 +
>  arch/arm/boot/dts/imx6q-nitrogen6_som2.dts    |  53 ++
>  arch/arm/boot/dts/imx6qdl-nitrogen6_som2.dtsi | 770 ++++++++++++++++++++++++++
>  3 files changed, 824 insertions(+)
>  create mode 100644 arch/arm/boot/dts/imx6q-nitrogen6_som2.dts
>  create mode 100644 arch/arm/boot/dts/imx6qdl-nitrogen6_som2.dtsi

<snip>

> +/ {
> +	chosen {
> +		stdout-path = &uart2;
> +	};
> +
> +	memory {
> +		reg = <0x10000000 0x40000000>;
> +	};
> +
> +	backlight_lcd: backlight_lcd {

Please use hyphen instead of underscore in node name.  Please check
through the patch series.

Shawn

> +		compatible = "pwm-backlight";
> +		pwms = <&pwm1 0 5000000>;
> +		brightness-levels = <0 4 8 16 32 64 128 255>;
> +		default-brightness-level = <7>;
> +		power-supply = <&reg_3p3v>;
> +		status = "okay";
> +	};
