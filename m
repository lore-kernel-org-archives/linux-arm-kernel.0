From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Wed, 15 Feb 2017 14:19:58 -0700
Subject: [PATCH RFC 3/3] arm64: dts: register Hi6220's coresight debug
 module
In-Reply-To: <1486966298-16767-4-git-send-email-leo.yan@linaro.org>
References: <1486966298-16767-1-git-send-email-leo.yan@linaro.org>
 <1486966298-16767-4-git-send-email-leo.yan@linaro.org>
Message-ID: <20170215211958.GC29730@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 13, 2017 at 02:11:38PM +0800, Leo Yan wrote:
> Bind coresight debug driver for Hi6220.

Bindings for the coresight debug driver...

> 
> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> ---
>  .../boot/dts/hisilicon/hikey_6220_coresight.dtsi   | 73 ++++++++++++++++++++++
>  1 file changed, 73 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/hisilicon/hikey_6220_coresight.dtsi b/arch/arm64/boot/dts/hisilicon/hikey_6220_coresight.dtsi
> index 77c2aab..e14d75c 100644
> --- a/arch/arm64/boot/dts/hisilicon/hikey_6220_coresight.dtsi
> +++ b/arch/arm64/boot/dts/hisilicon/hikey_6220_coresight.dtsi
> @@ -15,6 +15,79 @@
>  		#size-cells = <2>;
>  		compatible = "arm,amba-bus";
>  		ranges;
> +
> +		debug at 0,f6590000 {

Simply use "debug at f6590000", the "0," isn't required.

> +			compatible = "arm,coresight-debug","arm,primecell";
> +			reg = <0 0xf6590000 0 0x1000>;
> +			default_enable;

What is the "default_enable" for ?

> +			clocks = <&sys_ctrl HI6220_CS_ATB>;
> +			clock-names = "apb_pclk";
> +			cpu = <&cpu0>;
> +		};
> +
> +		debug at 1,f6592000 {
> +			compatible = "arm,coresight-debug","arm,primecell";
> +			reg = <0 0xf6592000 0 0x1000>;
> +			default_enable;
> +			clocks = <&sys_ctrl HI6220_CS_ATB>;
> +			clock-names = "apb_pclk";
> +			cpu = <&cpu1>;
> +		};
> +
> +		debug at 2,f6594000 {
> +			compatible = "arm,coresight-debug","arm,primecell";
> +			reg = <0 0xf6594000 0 0x1000>;
> +			default_enable;
> +			clocks = <&sys_ctrl HI6220_CS_ATB>;
> +			clock-names = "apb_pclk";
> +			cpu = <&cpu2>;
> +		};
> +
> +		debug at 3,f6596000 {
> +			compatible = "arm,coresight-debug","arm,primecell";
> +			reg = <0 0xf6596000 0 0x1000>;
> +			default_enable;
> +			clocks = <&sys_ctrl HI6220_CS_ATB>;
> +			clock-names = "apb_pclk";
> +			cpu = <&cpu3>;
> +		};
> +
> +		debug at 4,f65d0000 {
> +			compatible = "arm,coresight-debug","arm,primecell";
> +			reg = <0 0xf65d0000 0 0x1000>;
> +			default_enable;
> +			clocks = <&sys_ctrl HI6220_CS_ATB>;
> +			clock-names = "apb_pclk";
> +			cpu = <&cpu4>;
> +		};
> +
> +		debug at 5,f65d2000 {
> +			compatible = "arm,coresight-debug","arm,primecell";
> +			reg = <0 0xf65d2000 0 0x1000>;
> +			default_enable;
> +			clocks = <&sys_ctrl HI6220_CS_ATB>;
> +			clock-names = "apb_pclk";
> +			cpu = <&cpu5>;
> +		};
> +
> +		debug at 6,f65d4000 {
> +			compatible = "arm,coresight-debug","arm,primecell";
> +			reg = <0 0xf65d4000 0 0x1000>;
> +			default_enable;
> +			clocks = <&sys_ctrl HI6220_CS_ATB>;
> +			clock-names = "apb_pclk";
> +			cpu = <&cpu6>;
> +		};
> +
> +		debug at 7,f65d6000 {
> +			compatible = "arm,coresight-debug","arm,primecell";
> +			reg = <0 0xf65d6000 0 0x1000>;
> +			default_enable;
> +			clocks = <&sys_ctrl HI6220_CS_ATB>;
> +			clock-names = "apb_pclk";
> +			cpu = <&cpu7>;
> +		};
> +
>  		etm at 0,f659c000 {
>  			compatible = "arm,coresight-etm4x","arm,primecell";
>  			reg = <0 0xf659c000 0 0x1000>;
> -- 
> 2.7.4
> 
