From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Sun, 13 Dec 2015 20:59:41 +0200
Subject: [PATCH/RFC 01/19] ARM: shmobile: r8a7793: add i2c clocks
In-Reply-To: <1449802376-11301-2-git-send-email-horms+renesas@verge.net.au>
References: <1449802376-11301-1-git-send-email-horms+renesas@verge.net.au>
 <1449802376-11301-2-git-send-email-horms+renesas@verge.net.au>
Message-ID: <3335683.MLCYPmdgq6@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Simon,

Thank you for the patch.

On Friday 11 December 2015 11:52:38 Simon Horman wrote:
> Instantiate i2c clocks in r8a7791 device tree.
> 
> Based on similar work for the r8a7791 by Laurent Pinchart.
> 
> Cc: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
>  arch/arm/boot/dts/r8a7793.dtsi | 14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/r8a7793.dtsi b/arch/arm/boot/dts/r8a7793.dtsi
> index df607a92b2ed..e7f6e9bd13d6 100644
> --- a/arch/arm/boot/dts/r8a7793.dtsi
> +++ b/arch/arm/boot/dts/r8a7793.dtsi
> @@ -756,7 +756,7 @@
> 
>  			>;
> 
>  			clock-output-names =
>  				"tpu0", "sdhi2", "sdhi1", "sdhi0", "mmcif0",
> -				"i2c7", "pciec", "i2c8", "ssusb", "cmt1",
> +				"iic0", "pciec", "iic1", "ssusb", "cmt1",
>  				"usbdmac0", "usbdmac1";
>  		};
>  		mstp4_clks: mstp4_clks at e6150140 {
> @@ -820,19 +820,25 @@
>  			reg = <0 0xe6150994 0 4>, <0 0xe61509a4 0 4>;
>  			clocks = <&cp_clk>, <&cp_clk>, <&cp_clk>, <&cp_clk>,
>  				 <&cp_clk>, <&cp_clk>, <&cp_clk>, <&cp_clk>,
> -				 <&cpg_clocks R8A7793_CLK_QSPI>;
> +				 <&cpg_clocks R8A7793_CLK_QSPI>, <&hp_clk>,
> +				 <&cp_clk>, <&hp_clk>, <&hp_clk>, <&hp_clk>,
> +				 <&hp_clk>, <&hp_clk>;
>  			#clock-cells = <1>;
>  			clock-indices = <
>  				R8A7793_CLK_GPIO7 R8A7793_CLK_GPIO6
>  				R8A7793_CLK_GPIO5 R8A7793_CLK_GPIO4
>  				R8A7793_CLK_GPIO3 R8A7793_CLK_GPIO2
>  				R8A7793_CLK_GPIO1 R8A7793_CLK_GPIO0
> -				R8A7793_CLK_QSPI_MOD
> +				R8A7793_CLK_QSPI_MOD R8A7793_CLK_I2C5
> +				R8A7793_CLK_IICDVFS R8A7793_CLK_I2C4
> +				R8A7793_CLK_I2C3 R8A7793_CLK_I2C2
> +				R8A7793_CLK_I2C1 R8A7793_CLK_I2C0
> 
>  			>;
> 
>  			clock-output-names =
>  				"gpio7", "gpio6", "gpio5", "gpio4",
>  				"gpio3", "gpio2", "gpio1", "gpio0",
> -				"qspi_mod";
> +				"qspi_mod", "i2c5", "iic3", "i2c4",
> +				"i2c3", "i2c2", "i2c1", "i2c0";
>  		};
>  		mstp11_clks: mstp11_clks at e615099c {
>  			compatible = "renesas,r8a7793-mstp-clocks", "renesas,cpg-mstp-
clocks";

-- 
Regards,

Laurent Pinchart
