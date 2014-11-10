From: maxime.coquelin@st.com (Maxime Coquelin)
Date: Mon, 10 Nov 2014 10:26:00 +0100
Subject: [PATCH 10/13] ARM: STi: DT: STih410: Add dt nodes for the ehci
 / ohci usb controllers.
In-Reply-To: <1415361475-6218-11-git-send-email-peter.griffin@linaro.org>
References: <1415361475-6218-1-git-send-email-peter.griffin@linaro.org>
 <1415361475-6218-11-git-send-email-peter.griffin@linaro.org>
Message-ID: <546084A8.9070601@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Peter,


On 11/07/2014 12:57 PM, Peter Griffin wrote:
> The stih410 has some additional usb controllers. This patch adds the
> dt nodes which will enabled them to function correctly.
>
> Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
> ---
>   arch/arm/boot/dts/stih407.dtsi | 60 ++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 60 insertions(+)
>
> diff --git a/arch/arm/boot/dts/stih407.dtsi b/arch/arm/boot/dts/stih407.dtsi
> index 967ec39..5e01db2 100644
> --- a/arch/arm/boot/dts/stih407.dtsi
> +++ b/arch/arm/boot/dts/stih407.dtsi
Shouldn't you create a new stih410.dtsi file, to clearly highlight these 
USB2 controller are not present on STiH407?
If you create this file, you could also include the stih410-clocks.dtsi 
file in it.
> @@ -321,5 +321,65 @@
>   			reset-names = "global",
>   				      "port";
>   		};
> +
> +		ohci0: usb at 9a03c00 {
> +			compatible = "st,st-ohci-300x";
> +			status = "disabled";
> +			reg = <0x9a03c00 0x100>;
> +			interrupts = <GIC_SPI 180 IRQ_TYPE_NONE>;
> +			clocks = <&clk_s_c0_flexgen CLK_TX_ICN_DISP_0>;
> +			resets = <&powerdown STIH407_USB2_PORT0_POWERDOWN>,
> +				 <&softreset STIH407_USB2_PORT0_SOFTRESET>;
> +			reset-names = "power", "softreset";
> +
> +			phys = <&usb2_picophy0>;
> +			phy-names = "usb";
> +		};
> +
> +		ehci0: usb at 9a03e00 {
> +			compatible = "st,st-ehci-300x";
> +			status = "disabled";
> +			reg = <0x9a03e00 0x100>;
> +			interrupts = <GIC_SPI 151 IRQ_TYPE_NONE>;
> +			pinctrl-names = "default";
> +			pinctrl-0 = <&pinctrl_usb0>;
> +			clocks = <&clk_s_c0_flexgen CLK_TX_ICN_DISP_0>;
> +			resets = <&powerdown STIH407_USB2_PORT0_POWERDOWN>,
> +				 <&softreset STIH407_USB2_PORT0_SOFTRESET>;
> +			reset-names = "power", "softreset";
> +
> +			phys = <&usb2_picophy0>;
> +			phy-names = "usb";
> +		};
> +
> +		ohci1: usb at 9a83c00 {
> +			compatible = "st,st-ohci-300x";
> +			status = "disabled";
> +			reg = <0x9a83c00 0x100>;
> +			interrupts = <GIC_SPI 181 IRQ_TYPE_NONE>;
> +			clocks = <&clk_s_c0_flexgen CLK_TX_ICN_DISP_0>;
> +			resets = <&powerdown STIH407_USB2_PORT1_POWERDOWN>,
> +				 <&softreset STIH407_USB2_PORT1_SOFTRESET>;
> +			reset-names = "power", "softreset";
> +
> +			phys = <&usb2_picophy1>;
> +			phy-names = "usb";
> +		};
> +
> +		ehci1: usb at 9a83e00 {
> +			compatible = "st,st-ehci-300x";
> +			status = "disabled";
> +			reg = <0x9a83e00 0x100>;
> +			interrupts = <GIC_SPI 153 IRQ_TYPE_NONE>;
> +			pinctrl-names = "default";
> +			pinctrl-0 = <&pinctrl_usb1>;
> +			clocks = <&clk_s_c0_flexgen CLK_TX_ICN_DISP_0>;
> +			resets = <&powerdown STIH407_USB2_PORT1_POWERDOWN>,
> +				 <&softreset STIH407_USB2_PORT1_SOFTRESET>;
> +			reset-names = "power", "softreset";
> +
> +			phys = <&usb2_picophy1>;
> +			phy-names = "usb";
> +		};
>   	};
>   };
