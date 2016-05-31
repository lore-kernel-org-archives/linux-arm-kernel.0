From: arnaud.pouliquen@st.com (Arnaud Pouliquen)
Date: Tue, 31 May 2016 11:05:43 +0200
Subject: [PATCH v4 15/18] ARM: STi: DT: STiH407: Add sti-sasg-codec dt node
In-Reply-To: <1464192412-16386-17-git-send-email-peter.griffin@linaro.org>
References: <1464192412-16386-1-git-send-email-peter.griffin@linaro.org>
 <1464192412-16386-17-git-send-email-peter.griffin@linaro.org>
Message-ID: <574D53E7.40008@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 05/25/2016 06:06 PM, Peter Griffin wrote:
> This patch adds the dt node for the internal audio
> codec IP.
> 
> Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
> ---
>  arch/arm/boot/dts/stih407-family.dtsi | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/stih407-family.dtsi b/arch/arm/boot/dts/stih407-family.dtsi
> index b423836..60f95b6 100644
> --- a/arch/arm/boot/dts/stih407-family.dtsi
> +++ b/arch/arm/boot/dts/stih407-family.dtsi
> @@ -746,5 +746,14 @@
>  				<&clk_s_c0_flexgen CLK_TX_ICN_DISP_0>,
>  				<&clk_s_c0_flexgen CLK_EXT2F_A9>;
>  		};
> +
> +		sti_sasg_codec: sti-sasg-codec {
> +			compatible = "st,stih407-sas-codec";
> +			#sound-dai-cells = <1>;
> +			status = "okay";
Should be set to disable in family and enabled it depending on boards
(stihxxx-b2120.dtsi)
> +			st,syscfg = <&syscfg_core>;
> +			pinctrl-names = "default";
> +			pinctrl-0 = <&pinctrl_spdif_out >;
Declare pinctrl use in stihxxx-b2120.dtsi, should be set only if SPDIF used.

Regards
Arnaud
> +		};
>  	};
>  };
> 
