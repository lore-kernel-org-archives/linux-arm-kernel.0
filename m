From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sun, 25 May 2014 21:39:55 +0200
Subject: [PATCH 22/22] ARM: sun8i: dt: Add Ippo-q8h v5 support
In-Reply-To: <1400831485-28576-23-git-send-email-wens@csie.org>
References: <1400831485-28576-1-git-send-email-wens@csie.org>
 <1400831485-28576-23-git-send-email-wens@csie.org>
Message-ID: <20140525193955.GB10768@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 23, 2014 at 03:51:25PM +0800, Chen-Yu Tsai wrote:
> The Ippo-q8h is a tablet circiut board commonly found in cheap Android
> tablets with A23 SoCs. There are at least 2 versions of the board, with
> different peripherals, such as WiFi chips.
> 
> This patch add supports for v5 of such boards, which has a ESP8089 WiFi
> chip (not supported) connected to mmc1.
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> ---
>  arch/arm/boot/dts/Makefile                  |  2 ++
>  arch/arm/boot/dts/sun8i-a23-ippo-q8h-v5.dts | 51 +++++++++++++++++++++++++++++
>  2 files changed, 53 insertions(+)
>  create mode 100644 arch/arm/boot/dts/sun8i-a23-ippo-q8h-v5.dts
> 
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index 6967393..f809a53 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -354,6 +354,8 @@ dtb-$(CONFIG_MACH_SUN7I) += \
>  	sun7i-a20-cubietruck.dtb \
>  	sun7i-a20-i12-tvbox.dtb \
>  	sun7i-a20-olinuxino-micro.dtb
> +dtb-$(CONFIG_MACH_SUN8I) += \
> +	sun8i-a23-ippo-q8h-v5.dtb
>  dtb-$(CONFIG_ARCH_TEGRA) += tegra20-harmony.dtb \
>  	tegra20-iris-512.dtb \
>  	tegra20-medcom-wide.dtb \
> diff --git a/arch/arm/boot/dts/sun8i-a23-ippo-q8h-v5.dts b/arch/arm/boot/dts/sun8i-a23-ippo-q8h-v5.dts
> new file mode 100644
> index 0000000..7d0bd97
> --- /dev/null
> +++ b/arch/arm/boot/dts/sun8i-a23-ippo-q8h-v5.dts
> @@ -0,0 +1,51 @@
> +/*
> + * Copyright 2014 Chen-Yu Tsai
> + *
> + * Chen-Yu Tsai <wens@csie.org>
> + *
> + * The code contained herein is licensed under the GNU General Public
> + * License. You may obtain a copy of the GNU General Public License
> + * Version 2 or later at the following locations:
> + *
> + * http://www.opensource.org/licenses/gpl-license.html
> + * http://www.gnu.org/copyleft/gpl.html
> + */
> +
> +/dts-v1/;
> +/include/ "sun8i-a23.dtsi"
> +
> +/ {
> +	model = "Ippo Q8H Dual Core Tablet (v5)";
> +	compatible = "ippo,q8h-v5", "allwinner,sun8i-a23";
> +
> +	chosen {
> +		bootargs = "earlyprintk console=ttyS0,115200";
> +	};

You should probably add the memory node here too.

> +
> +	soc at 01c00000 {
> +		uart0: serial at 01c28000 {
> +			pinctrl-names = "default";
> +			pinctrl-0 = <&uart0_pins_a>;
> +			status = "okay";
> +		};
> +
> +		i2c0: i2c at 01c2ac00 {
> +			pinctrl-names = "default";
> +			pinctrl-0 = <&i2c0_pins_a>;
> +			status = "okay";
> +		};
> +
> +		i2c1: i2c at 01c2b000 {
> +			pinctrl-names = "default";
> +			pinctrl-0 = <&i2c1_pins_a>;
> +			status = "okay";
> +		};

What are the two i2c busses wired to?

> +		r_uart: serial at 01f02800 {
> +			pinctrl-names = "default";
> +			pinctrl-0 = <&r_uart_pins_a>;
> +			status = "okay";
> +		};
> +	};
> +};
> +
> -- 
> 2.0.0.rc2
> 

Thanks,
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140525/e907aa93/attachment-0001.sig>
