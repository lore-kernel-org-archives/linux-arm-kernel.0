From: horms@verge.net.au (Simon Horman)
Date: Wed, 11 Jun 2014 09:01:18 +0900
Subject: [PATCH v2] ARM: shmobile: henninger: add I2C2 DT support
In-Reply-To: <201406110245.22692.sergei.shtylyov@cogentembedded.com>
References: <201406110245.22692.sergei.shtylyov@cogentembedded.com>
Message-ID: <20140611000118.GB19789@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 11, 2014 at 02:45:21AM +0400, Sergei Shtylyov wrote:
> Define the Henninger board dependent part of the I2C2 device node.
> 
> Based on the Koelsch I2C2 device tree patch by Wolfram Sang.
> 
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

Thanks, I will queue this up.

> ---
> This patch is against 'renesas-devel-v3.15-20140610' tag of Simon Horman's
> 'renesas.git' repo.
> 
> Changes in version 2:
> - removed I2C devices, to be added by separate patches.
> 
>  arch/arm/boot/dts/r8a7791-henninger.dts |   13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> Index: renesas/arch/arm/boot/dts/r8a7791-henninger.dts
> ===================================================================
> --- renesas.orig/arch/arm/boot/dts/r8a7791-henninger.dts
> +++ renesas/arch/arm/boot/dts/r8a7791-henninger.dts
> @@ -110,6 +110,11 @@
>  		renesas,function = "sdhi2";
>  	};
>  
> +	i2c2_pins: i2c2 {
> +		renesas,groups = "i2c2";
> +		renesas,function = "i2c2";
> +	};
> +
>  	qspi_pins: spi0 {
>  		renesas,groups = "qspi_ctrl", "qspi_data4";
>  		renesas,function = "qspi";
> @@ -170,6 +175,14 @@
>  	status = "okay";
>  };
>  
> +&i2c2 {
> +	pinctrl-0 = <&i2c2_pins>;
> +	pinctrl-names = "default";
> +
> +	status = "okay";
> +	clock-frequency = <400000>;
> +};
> +
>  &qspi {
>  	pinctrl-0 = <&qspi_pins>;
>  	pinctrl-names = "default";
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
