From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Mon, 2 Oct 2017 21:06:00 +0200
Subject: [PATCH 9/9] arm64: dts: register Hi3660's thermal sensor
In-Reply-To: <1506073332-92438-10-git-send-email-kevin.wangtao@hisilicon.com>
References: <1506073332-92438-1-git-send-email-kevin.wangtao@hisilicon.com>
 <1506073332-92438-10-git-send-email-kevin.wangtao@hisilicon.com>
Message-ID: <f83a0936-23cc-0f5e-b6a3-c3adf1a0d7a0@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 22/09/2017 11:42, Tao Wang wrote:
> From: Kevin Wangtao <kevin.wangtao@linaro.org>
> 
> add binding for tsensor on H3660, this tsensor is used for
> SoC thermal control, it supports alarm interrupt.
> 
> Signed-off-by: Kevin Wangtao <kevin.wangtao@linaro.org>

I'm not able to apply this patch. Does it rely on another patch?

> ---
>  arch/arm64/boot/dts/hisilicon/hi3660.dtsi | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
> index b7a90d6..ae90991 100644
> --- a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
> +++ b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
> @@ -978,5 +978,13 @@
>  			clocks = <&crg_ctrl HI3660_OSC32K>;
>  			clock-names = "apb_pclk";
>  		};
> +
> +		tsensor: tsensor at fff30000 {
> +			compatible = "hisilicon,hi3660-tsensor";
> +			reg = <0x0 0xfff30000 0x0 0x1000>;
> +			interrupts = <GIC_SPI 145 IRQ_TYPE_LEVEL_HIGH>;
> +			#thermal-sensor-cells = <1>;
> +		};
> +
>  	};
>  };
> 


-- 
 <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
