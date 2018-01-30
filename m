From: baruch@tkos.co.il (Baruch Siach)
Date: Tue, 30 Jan 2018 13:21:38 +0200
Subject: [PATCH] ARM64: dts: marvell: armada-cp110: Add registers clock
 for SPI nodes
In-Reply-To: <20180130111455.10101-1-gregory.clement@free-electrons.com>
References: <20180130111455.10101-1-gregory.clement@free-electrons.com>
Message-ID: <20180130112138.4xopqhgllnbq4xhb@sapphire.tkos.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Gregory,

On Tue, Jan 30, 2018 at 12:14:55PM +0100, Gregory CLEMENT wrote:
> This extra clock is needed to access the registers of the SPI controller
> used on Armada 7K/8K SoCs.

Don't we need this also for I2C and UART?

baruch

> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
> ---
>  arch/arm64/boot/dts/marvell/armada-cp110.dtsi | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/marvell/armada-cp110.dtsi b/arch/arm64/boot/dts/marvell/armada-cp110.dtsi
> index a8af4136dbe7..0ab921861a2f 100644
> --- a/arch/arm64/boot/dts/marvell/armada-cp110.dtsi
> +++ b/arch/arm64/boot/dts/marvell/armada-cp110.dtsi
> @@ -257,7 +257,9 @@
>  			reg = <0x700600 0x50>;
>  			#address-cells = <0x1>;
>  			#size-cells = <0x0>;
> -			clocks = <&CP110_LABEL(clk) 1 21>;
> +			clock-names = "core", "axi";
> +			clocks = <&CP110_LABEL(clk) 1 21>,
> +				 <&CP110_LABEL(clk) 1 17>;
>  			status = "disabled";
>  		};
>  
> @@ -266,7 +268,9 @@
>  			reg = <0x700680 0x50>;
>  			#address-cells = <1>;
>  			#size-cells = <0>;
> -			clocks = <&CP110_LABEL(clk) 1 21>;
> +			clock-names = "core", "axi";
> +			clocks = <&CP110_LABEL(clk) 1 21>,
> +				 <&CP110_LABEL(clk) 1 17>;
>  			status = "disabled";
>  		};

-- 
     http://baruch.siach.name/blog/                  ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch at tkos.co.il - tel: +972.2.679.5364, http://www.tkos.co.il -
