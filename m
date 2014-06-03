From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Tue, 03 Jun 2014 19:56:03 +0200
Subject: [PATCH v2 1/2] arm: shmobile: r8a7790: add USB3.0 clocks to
 device tree
In-Reply-To: <538D711B.1060402@renesas.com>
References: <538D711B.1060402@renesas.com>
Message-ID: <5502651.vXk1fvVtBJ@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shimoda-san,

Thank you for the patch.

On Tuesday 03 June 2014 15:54:19 Yoshihiro Shimoda wrote:
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

Apart for the parent clock that I can't verify due to lack of documentation,

Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
>  arch/arm/boot/dts/r8a7790.dtsi |    6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/r8a7790.dtsi b/arch/arm/boot/dts/r8a7790.dtsi
> index cd8b7cc..e06c486 100644
> --- a/arch/arm/boot/dts/r8a7790.dtsi
> +++ b/arch/arm/boot/dts/r8a7790.dtsi
> @@ -780,17 +780,17 @@
>  			reg = <0 0xe615013c 0 4>, <0 0xe6150048 0 4>;
>  			clocks = <&hp_clk>, <&cp_clk>, <&mmc1_clk>, <&sd3_clk>,
>  				 <&sd2_clk>, <&cpg_clocks R8A7790_CLK_SD1>, <&cpg_clocks
> R8A7790_CLK_SD0>, <&mmc0_clk>, -				 <&hp_clk>, <&hp_clk>, 
<&rclk_clk>;
> +				 <&hp_clk>, <&hp_clk>, <&mp_clk>, <&rclk_clk>;
>  			#clock-cells = <1>;
>  			renesas,clock-indices = <
>  				R8A7790_CLK_IIC2 R8A7790_CLK_TPU0 R8A7790_CLK_MMCIF1 
R8A7790_CLK_SDHI3
>  				R8A7790_CLK_SDHI2 R8A7790_CLK_SDHI1 R8A7790_CLK_SDHI0
> R8A7790_CLK_MMCIF0 -				R8A7790_CLK_IIC0 R8A7790_CLK_IIC1 
R8A7790_CLK_CMT1
> +				R8A7790_CLK_IIC0 R8A7790_CLK_IIC1 R8A7790_CLK_SSUSB 
R8A7790_CLK_CMT1
> 
>  			>;
> 
>  			clock-output-names =
>  				"iic2", "tpu0", "mmcif1", "sdhi3",
>  				"sdhi2", "sdhi1", "sdhi0", "mmcif0",
> -				"iic0", "iic1", "cmt1";
> +				"iic0", "iic1", "ssusb", "cmt1";
>  		};
>  		mstp5_clks: mstp5_clks at e6150144 {
>  			compatible = "renesas,r8a7790-mstp-clocks", "renesas,cpg-mstp-
clocks";

-- 
Regards,

Laurent Pinchart
