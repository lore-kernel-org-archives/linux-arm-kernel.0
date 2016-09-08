From: patrice.chotard@st.com (Patrice Chotard)
Date: Thu, 8 Sep 2016 16:06:45 +0200
Subject: [PATCH 1/4] ARM: dts: STiH410: Handle interconnect clock required
 by EHCI/OHCI (USB)
In-Reply-To: <20160908091136.17301-2-lee.jones@linaro.org>
References: <20160908091136.17301-1-lee.jones@linaro.org>
 <20160908091136.17301-2-lee.jones@linaro.org>
Message-ID: <775896f5-b732-c447-9880-ed648588be02@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lee

On 09/08/2016 11:11 AM, Lee Jones wrote:
> The STiH4{07,10} platform contains some interconnect clocks which are used
> by various IPs.  If this clock isn't handled correctly by ST's EHCI/OHCI
> drivers, their hub won't be found, the following error be shown and the
> result will be non-working USB:
>
>   [   97.221963] hub 2-1:1.0: hub_ext_port_status failed (err = -110)
>
> Cc: stable at vger.kernel.org
> Tested-by: Peter Griffin <peter.griffin@linaro.org>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  arch/arm/boot/dts/stih410.dtsi | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
>
> diff --git a/arch/arm/boot/dts/stih410.dtsi b/arch/arm/boot/dts/stih410.dtsi
> index 9ee5e20..f1aa34c 100644
> --- a/arch/arm/boot/dts/stih410.dtsi
> +++ b/arch/arm/boot/dts/stih410.dtsi
> @@ -41,7 +41,8 @@
>  			compatible = "st,st-ohci-300x";
>  			reg = <0x9a03c00 0x100>;
>  			interrupts = <GIC_SPI 180 IRQ_TYPE_NONE>;
> -			clocks = <&clk_s_c0_flexgen CLK_TX_ICN_DISP_0>;
> +			clocks = <&clk_s_c0_flexgen CLK_TX_ICN_DISP_0>,
> +				 <&clk_s_c0_flexgen CLK_RX_ICN_DISP_0>;
>  			resets = <&powerdown STIH407_USB2_PORT0_POWERDOWN>,
>  				 <&softreset STIH407_USB2_PORT0_SOFTRESET>;
>  			reset-names = "power", "softreset";
> @@ -57,7 +58,8 @@
>  			interrupts = <GIC_SPI 151 IRQ_TYPE_NONE>;
>  			pinctrl-names = "default";
>  			pinctrl-0 = <&pinctrl_usb0>;
> -			clocks = <&clk_s_c0_flexgen CLK_TX_ICN_DISP_0>;
> +			clocks = <&clk_s_c0_flexgen CLK_TX_ICN_DISP_0>,
> +				 <&clk_s_c0_flexgen CLK_RX_ICN_DISP_0>;
>  			resets = <&powerdown STIH407_USB2_PORT0_POWERDOWN>,
>  				 <&softreset STIH407_USB2_PORT0_SOFTRESET>;
>  			reset-names = "power", "softreset";
> @@ -71,7 +73,8 @@
>  			compatible = "st,st-ohci-300x";
>  			reg = <0x9a83c00 0x100>;
>  			interrupts = <GIC_SPI 181 IRQ_TYPE_NONE>;
> -			clocks = <&clk_s_c0_flexgen CLK_TX_ICN_DISP_0>;
> +			clocks = <&clk_s_c0_flexgen CLK_TX_ICN_DISP_0>,
> +				 <&clk_s_c0_flexgen CLK_RX_ICN_DISP_0>;
>  			resets = <&powerdown STIH407_USB2_PORT1_POWERDOWN>,
>  				 <&softreset STIH407_USB2_PORT1_SOFTRESET>;
>  			reset-names = "power", "softreset";
> @@ -87,7 +90,8 @@
>  			interrupts = <GIC_SPI 153 IRQ_TYPE_NONE>;
>  			pinctrl-names = "default";
>  			pinctrl-0 = <&pinctrl_usb1>;
> -			clocks = <&clk_s_c0_flexgen CLK_TX_ICN_DISP_0>;
> +			clocks = <&clk_s_c0_flexgen CLK_TX_ICN_DISP_0>,
> +				 <&clk_s_c0_flexgen CLK_RX_ICN_DISP_0>;
>  			resets = <&powerdown STIH407_USB2_PORT1_POWERDOWN>,
>  				 <&softreset STIH407_USB2_PORT1_SOFTRESET>;
>  			reset-names = "power", "softreset";

Applied

thanks
