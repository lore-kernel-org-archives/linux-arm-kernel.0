From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Tue, 03 Jun 2014 19:59:17 +0200
Subject: [PATCH v2 1/2] arm: shmobile: r8a7791: add USB3.0 clocks to
 device tree
In-Reply-To: <538D71C1.3010900@renesas.com>
References: <538D71C1.3010900@renesas.com>
Message-ID: <3639732.t6IJBqd63T@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shimoda-san,

Thank you for the patch.

On Tuesday 03 June 2014 15:57:05 Yoshihiro Shimoda wrote:
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

Apart for the parent clock that I can't verify due to lack of documentation,

Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
>  arch/arm/boot/dts/r8a7791.dtsi |    6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/r8a7791.dtsi b/arch/arm/boot/dts/r8a7791.dtsi
> index ede8b7f..c2b5b38 100644
> --- a/arch/arm/boot/dts/r8a7791.dtsi
> +++ b/arch/arm/boot/dts/r8a7791.dtsi
> @@ -784,15 +784,15 @@
>  			compatible = "renesas,r8a7791-mstp-clocks", "renesas,cpg-mstp-
clocks";
>  			reg = <0 0xe615013c 0 4>, <0 0xe6150048 0 4>;
>  			clocks = <&cp_clk>, <&sd2_clk>, <&sd1_clk>, <&cpg_clocks
> R8A7791_CLK_SD0>, -				 <&mmc0_clk>, <&hp_clk>, <&hp_clk>, 
<&rclk_clk>;
> +				 <&mmc0_clk>, <&hp_clk>, <&hp_clk>, <&mp_clk>, <&rclk_clk>;
>  			#clock-cells = <1>;
>  			renesas,clock-indices = <
>  				R8A7791_CLK_TPU0 R8A7791_CLK_SDHI2 R8A7791_CLK_SDHI1 
R8A7791_CLK_SDHI0
> -				R8A7791_CLK_MMCIF0 R8A7791_CLK_IIC0 R8A7791_CLK_IIC1 
R8A7791_CLK_CMT1
> +				R8A7791_CLK_MMCIF0 R8A7791_CLK_IIC0 R8A7791_CLK_IIC1 
R8A7791_CLK_SSUSB
> R8A7791_CLK_CMT1
>  			>;
> 
>  			clock-output-names =
>  				"tpu0", "sdhi2", "sdhi1", "sdhi0",
> -				"mmcif0", "i2c7", "i2c8", "cmt1";
> +				"mmcif0", "i2c7", "i2c8", "ssusb", "cmt1";
>  		};
>  		mstp5_clks: mstp5_clks at e6150144 {
>  			compatible = "renesas,r8a7791-mstp-clocks", "renesas,cpg-mstp-
clocks";

-- 
Regards,

Laurent Pinchart
