From: dinguyen@altera.com (Dinh Nguyen)
Date: Wed, 5 Mar 2014 10:23:48 -0600
Subject: [PATCH] dts: add support for MMC on socfpga boards
In-Reply-To: <20140305162350.GA3674@pollux.denx.de>
References: <20140305162350.GA3674@pollux.denx.de>
Message-ID: <1394036628.23289.0.camel@linux-builds1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2014-03-05 at 17:23 +0100, ZY - pavel wrote:
> Add DTS binding for MMC on socfpga boards. Tested on Sockit.
>     
> Signed-off-by: Pavel Machek <pavel@denx.de>
> 
> diff --git a/arch/arm/boot/dts/socfpga.dtsi b/arch/arm/boot/dts/socfpga.dtsi
> index 537f1a5..cad7526 100644
> --- a/arch/arm/boot/dts/socfpga.dtsi
> +++ b/arch/arm/boot/dts/socfpga.dtsi
> @@ -521,6 +521,23 @@
>  			reg-io-width = <4>;
>  		};
>  
> +		mmc: dwmmc0 at ff704000 {
> +			compatible = "snps,dw-mshc";
> +			reg = <0xff704000 0x1000>;
> +			interrupts = <0 139 4>;
> +			clock-frequency = <12500000>; /*12.5 MHz*/
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			num-slots = <1>;
> +			supports-highspeed;
> +			broken-cd;
> +			fifo-depth = <0x400>;
> +			slot at 0 {
> +				reg = <0>;
> +				bus-width = <4>;
> +			};
> +		};
> +
>  		rstmgr at ffd05000 {
>  			compatible = "altr,rst-mgr";
>  			reg = <0xffd05000 0x1000>;
> 

This is already queued in Chris Ball's MMC tree.

Thanks,
Dinh
