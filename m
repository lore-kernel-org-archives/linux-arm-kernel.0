From: shawnguo@kernel.org (Shawn Guo)
Date: Wed, 2 Dec 2015 15:34:27 +0800
Subject: [PATCH v3] arm64: dts: add all hi6220 i2c nodes
In-Reply-To: <1449037749-14388-1-git-send-email-kong.kongxinwei@hisilicon.com>
References: <1449037749-14388-1-git-send-email-kong.kongxinwei@hisilicon.com>
Message-ID: <20151202073427.GM692@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 02, 2015 at 02:29:09PM +0800, Xinwei Kong wrote:
> This patch adds all I2C nodes for the Hi6220 SoC. This hi6220 Soc
> use this I2C IP of Synopsys Designware for HiKey board.
> 
> Signed-off-by: Xinwei Kong <kong.kongxinwei@hisilicon.com>
> ---
>  arch/arm64/boot/dts/hisilicon/hi6220.dtsi | 31 +++++++++++++++++++++++++++++++
>  1 file changed, 31 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/hisilicon/hi6220.dtsi b/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
> index 82d2488..6eae673 100644
> --- a/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
> +++ b/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
> @@ -208,5 +208,36 @@
>  			clock-names = "uartclk", "apb_pclk";
>  			status = "disabled";
>  		};
> +
> +		i2c0: i2c at f7100000 {
> +			compatible = "snps,designware-i2c";
> +			reg = <0x0 0xf7100000 0x0 0x1000>;
> +			interrupts = <0 44 4>;
> +			i2c-sda-hold-time-ns = <300>;
> +			pinctrl-names = "default";
> +			pinctrl-0 = <&i2c0_pmx_func &i2c0_cfg_func>;
> +			status = "disabled";

You got me wrong.  I was asking you to drop property 'clock-names' only,
not 'clocks' together.  I do not think it works if you drop property
'clocks', because I see that dw_i2c_plat_probe() will fail if
devm_clk_get() fails.  Did you test the patch before posting it out?

Shawn

> +		};
> +
> +		i2c1: i2c at f7101000 {
> +			compatible = "snps,designware-i2c";
> +			reg = <0x0 0xf7101000 0x0 0x1000>;
> +			interrupts = <0 45 4>;
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
