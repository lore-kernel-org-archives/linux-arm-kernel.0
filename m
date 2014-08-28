From: dinh.linux@gmail.com (Dinh Nguyen)
Date: Thu, 28 Aug 2014 04:21:43 -0500
Subject: [PATCH v2 6/6] ARM: dts: hix5hd2: add wdg node
In-Reply-To: <1409204060-9223-7-git-send-email-zhangfei.gao@linaro.org>
References: <1409204060-9223-1-git-send-email-zhangfei.gao@linaro.org>
 <1409204060-9223-7-git-send-email-zhangfei.gao@linaro.org>
Message-ID: <53FEF4A7.2040001@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 8/28/14, 12:34 AM, Zhangfei Gao wrote:
> Signed-off-by: Jiancheng Xue <xuejiancheng@huawei.com>
> Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
> ---
>  arch/arm/boot/dts/hisi-x5hd2.dtsi |    9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/hisi-x5hd2.dtsi b/arch/arm/boot/dts/hisi-x5hd2.dtsi
> index 152f3ad..7b1cb53 100644
> --- a/arch/arm/boot/dts/hisi-x5hd2.dtsi
> +++ b/arch/arm/boot/dts/hisi-x5hd2.dtsi
> @@ -365,6 +365,15 @@
>  				#interrupt-cells = <2>;
>  				status = "disabled";
>  			};
> +
> +			wdg0: wdg at a2c000 {

A nit-pick here, but everybody else is using 'wdt' for a watchdog timer
node.

> +				compatible = "arm,sp805", "arm,primecell";

I didn't see an entry for "arm,sp805" in Documentations, should there be
one?

Dinh
> +				arm,primecell-periphid = <0x00141805>;
> +				reg = <0xa2c000 0x1000>;
> +				interrupts = <0 29 4>;
> +				clocks = <&clock HIX5HD2_WDG0_RST>;
> +				clock-names = "apb_pclk";
> +                       };
>  		};
>  
>  		local_timer at 00a00600 {
> 
