From: huangtao@rock-chips.com (Huang, Tao)
Date: Wed, 5 Oct 2016 10:27:15 +0800
Subject: [PATCH] ARM: dts: rockchip: Reserve unusable memory region on
 rk3066
In-Reply-To: <20161001140939.GA31220@vaio-ubuntu>
References: <20161001140939.GA31220@vaio-ubuntu>
Message-ID: <6239b970-09d3-f7ee-e6f5-c019eaedb725@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Pawe?:
On 2016?10?01? 22:09, =?UTF-8?q?Pawe=C5=82=20Jarosz?= wrote:
> For some reason accessing memory region above 0xfe000000 freezes
> system on rk3066. There is similiar bug on later rockchip soc (rk3288)
RK3066 only support 2GB memory from 0x60000000 to 0xE0000000, can not access
above 0xfe000000. I think you mean 0x9F000000?
> solved same way.
>
> Signed-off-by: Pawe? Jarosz <paweljarosz3691@gmail.com>
> ---
>  arch/arm/boot/dts/rk3066a.dtsi | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>
> diff --git a/arch/arm/boot/dts/rk3066a.dtsi b/arch/arm/boot/dts/rk3066a.dtsi
> index 0d0dae3..44c8956 100644
> --- a/arch/arm/boot/dts/rk3066a.dtsi
> +++ b/arch/arm/boot/dts/rk3066a.dtsi
> @@ -93,6 +93,19 @@
>  		};
>  	};
>  
> +	reserved-memory {
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		ranges;
> +		/*
> +		 * The rk3066 cannot use the memory area above 0x9F000000
> +		 * for some unknown reason.
> +		 */

I don't remember RK3066 has such limit. I will double check with our IC
design team.
Do you know which master can not access this memory area
[0x9F000000~0xA0000000)?

> +		unusable at 9F000000 {
> +			reg = <0x9F000000 0x1000000>;
> +		};
> +	};
> +
>  	i2s0: i2s at 10118000 {
>  		compatible = "rockchip,rk3066-i2s";
>  		reg = <0x10118000 0x2000>;
