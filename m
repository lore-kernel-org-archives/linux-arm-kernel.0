From: lee.jones@linaro.org (Lee Jones)
Date: Mon, 10 Nov 2014 10:49:47 +0000
Subject: [PATCH 02/13] ARM: STi: DT: STiH416: Add DT node for the
 stih415/6 usb2 phy
In-Reply-To: <1415361475-6218-3-git-send-email-peter.griffin@linaro.org>
References: <1415361475-6218-1-git-send-email-peter.griffin@linaro.org>
 <1415361475-6218-3-git-send-email-peter.griffin@linaro.org>
Message-ID: <20141110104947.GT21424@x1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 07 Nov 2014, Peter Griffin wrote:

> This usb picophy is found on stih415/6 SoC.

Then shouldn't it live in stih41x.dtsi?

> Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
> ---
>  arch/arm/boot/dts/stih416.dtsi | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/stih416.dtsi b/arch/arm/boot/dts/stih416.dtsi
> index 1137bdf..0f3019a 100644
> --- a/arch/arm/boot/dts/stih416.dtsi
> +++ b/arch/arm/boot/dts/stih416.dtsi
> @@ -316,5 +316,14 @@
>  
>  			status	        = "disabled";
>  		};
> +
> +		usb2_phy: usb2phy at 0 {
> +			compatible = "st,stih416-usb-phy";
> +			#phy-cells = <0>;
> +			st,syscfg = <&syscfg_rear>;
> +			clocks = <&clk_sysin>;
> +			clock-names = "osc_phy";
> +

Remove this '\n'.

> +		};
>  	};
>  };

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
