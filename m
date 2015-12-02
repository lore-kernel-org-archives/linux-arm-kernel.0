From: shawnguo@kernel.org (Shawn Guo)
Date: Wed, 2 Dec 2015 10:05:24 +0800
Subject: [PATCH v2] arm64: dts: add all hi6220 i2c nodes
In-Reply-To: <1448524623-10320-1-git-send-email-kong.kongxinwei@hisilicon.com>
References: <1448524623-10320-1-git-send-email-kong.kongxinwei@hisilicon.com>
Message-ID: <20151202020524.GC692@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 26, 2015 at 03:57:03PM +0800, Xinwei Kong wrote:
> This patch adds all I2C nodes for the Hi6220 SoC. This hi6220 Soc
> use this I2C IP of Synopsys Designware for HiKey board.
> 
> Signed-off-by: Xinwei Kong <kong.kongxinwei@hisilicon.com>
> ---
>  arch/arm64/boot/dts/hisilicon/hi6220.dtsi | 37 +++++++++++++++++++++++++++++++
>  1 file changed, 37 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/hisilicon/hi6220.dtsi b/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
> index 82d2488..85d4a8b 100644
> --- a/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
> +++ b/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
> @@ -208,5 +208,42 @@
>  			clock-names = "uartclk", "apb_pclk";
>  			status = "disabled";
>  		};
> +
> +		i2c0: i2c at f7100000 {
> +			compatible = "snps,designware-i2c";
> +			reg = <0x0 0xf7100000 0x0 0x1000>;
> +			interrupts = <0 44 4>;
> +			clocks = <&sys_ctrl HI6220_I2C0_CLK>;
> +			clock-names = "clk_i2c0";

Neither bindings doc i2c-designware.txt defines this property, nor
kernel i2c-designware driver uses this property.  So I think this
clock-names property can just be dropped.

Otherwise, the patch looks good to me.

Shawn

> +			i2c-sda-hold-time-ns = <300>;
> +			pinctrl-names = "default";
> +			pinctrl-0 = <&i2c0_pmx_func &i2c0_cfg_func>;
> +			status = "disabled";
> +		};
> +
> +		i2c1: i2c at f7101000 {
> +			compatible = "snps,designware-i2c";
> +			reg = <0x0 0xf7101000 0x0 0x1000>;
> +			interrupts = <0 45 4>;
> +			clocks = <&sys_ctrl HI6220_I2C1_CLK>;
> +			clock-names = "clk_i2c1";
> +			i2c-sda-hold-time-ns = <300>;
> +			pinctrl-names = "default";
> +			pinctrl-0 = <&i2c1_pmx_func &i2c1_cfg_func>;
> +			status = "disabled";
> +		};
> +
> +		i2c2: i2c at f7102000 {
> +			compatible = "snps,designware-i2c";
> +			reg = <0x0 0xf7102000 0x0 0x1000>;
> +			interrupts = <0 46 4>;
> +			clocks = <&sys_ctrl HI6220_I2C2_CLK>;
> +			clock-names = "clk_i2c2";
> +			i2c-sda-hold-time-ns = <300>;
> +			pinctrl-names = "default";
> +			pinctrl-0 = <&i2c2_pmx_func &i2c2_cfg_func>;
> +			status = "disabled";
> +		};
> +
>  	};
>  };
> -- 
> 1.9.1
> 
> 
> 
