From: shawn.guo@freescale.com (Shawn Guo)
Date: Tue, 1 Jul 2014 17:14:26 +0800
Subject: [PATCH 2/5] ARM: dts: imx6: edmqmx6: Add PCIe support
In-Reply-To: <d1e2e5096219c3d191df1e56271c9dd03c4f2475.1404132504.git.silvio.fricke@gmail.com>
References: <cover.1404132504.git.silvio.fricke@gmail.com>
 <d1e2e5096219c3d191df1e56271c9dd03c4f2475.1404132504.git.silvio.fricke@gmail.com>
Message-ID: <20140701091425.GI14471@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 30, 2014 at 03:28:06PM +0200, Silvio Fricke wrote:
> Add support for the PCI express bus available on MX6 Data Modul
> edm-qmx6 board.
> 
> Signed-off-by: Silvio Fricke <silvio.fricke@gmail.com>
> ---
>  arch/arm/boot/dts/imx6q-dmo-edmqmx6.dts | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/imx6q-dmo-edmqmx6.dts b/arch/arm/boot/dts/imx6q-dmo-edmqmx6.dts
> index e030263..b0dd50b 100644
> --- a/arch/arm/boot/dts/imx6q-dmo-edmqmx6.dts
> +++ b/arch/arm/boot/dts/imx6q-dmo-edmqmx6.dts
> @@ -323,6 +323,12 @@
>  			>;
>  		};
>  
> +		pinctrl_pcie: pciegrp {
> +			fsl,pins = <
> +				MX6QDL_PAD_KEY_COL1__GPIO4_IO08		0x80000000

I know it's been used a lot, but I would start requesting to put a real
pad config value instead of 0x80000000, so that the kernel does not
depend on the value coming out of hardware reset or bootloader.

Shawn

> +			>;
> +		};
> +
>  		pinctrl_pfuze: pfuze100grp1 {
>  			fsl,pins = <
>  				MX6QDL_PAD_EIM_D20__GPIO3_IO20		0x80000000
> @@ -385,6 +391,13 @@
>  	};
>  };
>  
> +&pcie {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_pcie>;
> +	reset-gpio = <&gpio4 8 0>;
> +	status = "okay";
> +};
> +
>  &sata {
>  	status = "okay";
>  };
> -- 
> 2.0.0
> 
