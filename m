From: maxime.coquelin@st.com (Maxime Coquelin)
Date: Wed, 17 Jun 2015 14:13:09 +0200
Subject: [PATCH] ARM: DT: STiH410: Add bdisp dt nodes
In-Reply-To: <1434461440-3965-1-git-send-email-fabien.dessenne@st.com>
References: <1434461440-3965-1-git-send-email-fabien.dessenne@st.com>
Message-ID: <55816455.1030503@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Fabien,

On 06/16/2015 03:30 PM, Fabien Dessenne wrote:
> Add the bdisp (2D blitter for STMicroelectronics SoC) dt nodes for the
> first of the two bdisp devices, defining register address, interrupt and
> clock.
>
> Signed-off-by: Fabien Dessenne <fabien.dessenne@st.com>
> ---
>   arch/arm/boot/dts/stih410.dtsi | 12 ++++++++++++
>   1 file changed, 12 insertions(+)
>
> diff --git a/arch/arm/boot/dts/stih410.dtsi b/arch/arm/boot/dts/stih410.dtsi
> index 208b5e8..6f40bc9 100644
> --- a/arch/arm/boot/dts/stih410.dtsi
> +++ b/arch/arm/boot/dts/stih410.dtsi
> @@ -10,6 +10,10 @@
>   #include "stih407-family.dtsi"
>   #include "stih410-pinctrl.dtsi"
>   / {
> +	aliases {
> +		bdisp0 = &bdisp0;
> +	};
> +
>   	soc {
>   		usb2_picophy1: phy2 {
>   			compatible = "st,stih407-usb2-phy";
> @@ -218,5 +222,13 @@
>   				};
>   			};
>   		};
> +
> +		bdisp0:bdisp at 9f10000 {
> +			compatible = "st,stih407-bdisp";
> +			reg = <0x9f10000 0x1000>;
> +			interrupts = <GIC_SPI 38 IRQ_TYPE_NONE>;
> +			clock-names = "bdisp";
> +			clocks = <&clk_s_c0_flexgen CLK_IC_BDISP_0>;
> +		};

Isn't the bdisp also present on STiH407 SoC?
If so, could you please move this node to stih407-family file?

Thanks,
Maxime
