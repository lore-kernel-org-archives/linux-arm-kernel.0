From: tony@atomide.com (Tony Lindgren)
Date: Fri, 21 Nov 2014 16:00:05 -0800
Subject: [PATCH V2] ARM: dts: DRA7: Add node for RTC
In-Reply-To: <1416399788-27557-1-git-send-email-lokeshvutla@ti.com>
References: <1416199509-3977-1-git-send-email-lokeshvutla@ti.com>
 <1416399788-27557-1-git-send-email-lokeshvutla@ti.com>
Message-ID: <20141122000004.GG7046@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Lokesh Vutla <lokeshvutla@ti.com> [141119 04:26]:
> Add node for RTC.
> 
> Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
> [nm at ti.com: update with rtc crossbar number]
> Signed-off-by: Nishanth Menon <nm@ti.com>

Applying into omap-for-v3.19/dt-v2 thanks.

Tony

> ---
> Changes since v1:
> - Fixed rtc dt node label.
>  arch/arm/boot/dts/dra7.dtsi | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
> index 9cc9843..5d92562 100644
> --- a/arch/arm/boot/dts/dra7.dtsi
> +++ b/arch/arm/boot/dts/dra7.dtsi
> @@ -1075,6 +1075,15 @@
>  			status = "disabled";
>  		};
>  
> +		rtc at 48838000 {
> +			compatible = "ti,am3352-rtc";
> +			reg = <0x48838000 0x100>;
> +			interrupts = <GIC_SPI 217 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 217 IRQ_TYPE_LEVEL_HIGH>;
> +			ti,hwmods = "rtcss";
> +			clocks = <&sys_32k_ck>;
> +		};
> +
>  		omap_control_usb2phy1: control-phy at 4a002300 {
>  			compatible = "ti,control-phy-usb2";
>  			reg = <0x4a002300 0x4>;
> -- 
> 1.9.1
> 
