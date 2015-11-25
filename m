From: kong.kongxinwei@hisilicon.com (Xinwei Kong)
Date: Wed, 25 Nov 2015 18:35:05 +0800
Subject: [PATCH 1/1] arm64: dts: add all hi6220 i2c nodes
In-Reply-To: <1448444942-5780-1-git-send-email-kong.kongxinwei@hisilicon.com>
References: <1448444942-5780-1-git-send-email-kong.kongxinwei@hisilicon.com>
Message-ID: <56558ED9.2010802@hisilicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

+to linux-i2c at vger.kernel.org

On 2015/11/25 17:49, Xinwei Kong wrote:
> This patch adds all I2C nodes for the Hi6220 SoC. This hi6220 Soc
> use this I2C IP of Synopsys Designware for HiKey board.
> 
> Signed-off-by: Xinwei Kong <kong.kongxinwei@hisilicon.com>
> Signed-off-by: Chen Feng <puck.chen@hisilicon.com>
> ---
>  arch/arm64/boot/dts/hisilicon/hi6220.dtsi | 37 +++++++++++++++++++++++++++++++
>  1 file changed, 37 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/hisilicon/hi6220.dtsi b/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
> index 82d2488..6b591a9 100644
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
> +			i2c-sda-hold-time-ns = <300>;
> +			pinctrl-names = "default";
> +			pinctrl-0 = <&i2c0_pmx_func &i2c0_cfg_func>;
> +			status = "ok";
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
> +			status = "ok";
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
> +			status = "ok";
> +		};
> +
>  	};
>  };
> 
